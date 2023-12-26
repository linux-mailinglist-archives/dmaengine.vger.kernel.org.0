Return-Path: <dmaengine+bounces-665-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C03F81EA0E
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 21:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C68FA1C212C0
	for <lists+dmaengine@lfdr.de>; Tue, 26 Dec 2023 20:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B1EAF3;
	Tue, 26 Dec 2023 20:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7iy9utS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9CAEAF2;
	Tue, 26 Dec 2023 20:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703624049; x=1735160049;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=6vm3/1J8+0RlhGUApQzpmYZe5Ax8xA/w2zIHtPsoe6A=;
  b=V7iy9utSXW+GsdVQwa6V9UgsJ7Xpz27eOFY6cG3CDkhNly2XTc/xd3Zq
   gKM++pCtizEwYC1Z+5HoxcmcdFesucM3QUc0W8cj9k5oXQebEmYlq1SSy
   5vuGWnjjZlquEEgbl9X5S6kGlenl0YCdu1oyGSLMr/S+8TWKIlwCqYORA
   to/5/ZhJaJgGqaCdC2g7i0XLq/NTMINjzppQZ2E6UP3HFpvOkD4lrq+br
   nuuyN3tq8LeI9KsfWdkwEyaYdNsALooC7UJ5NUpjaEjr1M3qQuyVn1Fby
   YAXAlQIWuUEQ5wEAzUJO/9Zv8cXbUpNYAF3f+s6ZxLlfc8yWmglK8gmvA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10935"; a="399168939"
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="399168939"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 12:54:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,307,1695711600"; 
   d="scan'208";a="20102656"
Received: from smorga5x-mobl.amr.corp.intel.com ([10.212.113.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2023 12:53:27 -0800
Message-ID: <00e3eea06f5dde61734a53af797b190692060aab.camel@linux.intel.com>
Subject: [PATCH] crypto: iaa - Account for cpu-less numa nodes
From: Tom Zanussi <tom.zanussi@linux.intel.com>
To: herbert@gondor.apana.org.au, davem@davemloft.net, fenghua.yu@intel.com
Cc: rex.zhang@intel.com, dave.jiang@intel.com, tony.luck@intel.com, 
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org
Date: Tue, 26 Dec 2023 14:53:26 -0600
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

In some configurations e.g. systems with CXL, a numa node can have 0
cpus and cpumask_nth() will return a cpu value that doesn't exist,
which will result in an attempt to add an entry to the wq table at a
bad index.

To fix this, when iterating the cpus for a node, skip any node that
doesn't have cpus.

Also, as a precaution, add a warning and bail if cpumask_nth() returns
a nonexistent cpu.

Reported-by: Zhang, Rex <rex.zhang@intel.com>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/in=
tel/iaa/iaa_crypto_main.c
index 5093361b0107..782157a74043 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -1017,12 +1017,17 @@ static void rebalance_wq_table(void)
 		return;
 	}
=20
-	for_each_online_node(node) {
+	for_each_node_with_cpus(node) {
 		node_cpus =3D cpumask_of_node(node);
=20
 		for (cpu =3D 0; cpu < nr_cpus_per_node; cpu++) {
 			int node_cpu =3D cpumask_nth(cpu, node_cpus);
=20
+			if (WARN_ON(node_cpu >=3D nr_cpu_ids)) {
+				pr_debug("node_cpu %d doesn't exist!\n", node_cpu);
+				return;
+			}
+
 			if ((cpu % cpus_per_iaa) =3D=3D 0)
 				iaa++;
=20
@@ -2095,10 +2100,13 @@ static struct idxd_device_driver iaa_crypto_driver =
=3D {
 static int __init iaa_crypto_init_module(void)
 {
 	int ret =3D 0;
+	int node;
=20
 	nr_cpus =3D num_online_cpus();
-	nr_nodes =3D num_online_nodes();
-	nr_cpus_per_node =3D nr_cpus / nr_nodes;
+	for_each_node_with_cpus(node)
+		nr_nodes++;
+	if (nr_nodes)
+		nr_cpus_per_node =3D nr_cpus / nr_nodes;
=20
 	if (crypto_has_comp("deflate-generic", 0, 0))
 		deflate_generic_tfm =3D crypto_alloc_comp("deflate-generic", 0, 0);
--=20
2.34.1



