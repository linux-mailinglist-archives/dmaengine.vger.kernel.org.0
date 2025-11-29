Return-Path: <dmaengine+bounces-7399-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD20C94289
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86503AAD33
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317623128B6;
	Sat, 29 Nov 2025 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vWAer50H"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C621311C3B;
	Sat, 29 Nov 2025 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432280; cv=fail; b=rrO7TMlQ0/8+iam5bdpGCyZVnJQDMWmk2FAfArRUZIHuB2kju7LFOUaKzhyAjAfU0ebHHtctcK9n+FMzB9RoUnynes/qpAsTV2bkQQIieGGwIwgBciboNjfzWDIVYgVMyaeNYNb/DgyobnDa/2oW7IoEWNbrsdKUe2wGrlXJPoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432280; c=relaxed/simple;
	bh=mcdeDaYfMNIN7NJFyfqIICBfhf8XKBxVQj2O+PgEo/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uB40mCtK6h6noTQPrkyadnwO/z5TVb/g1nPkRDmORUCS8OqmW3C/R93//HfaZbhDIsFF9LEDklUVz5GClR98DGOcMlGfUuHvvb/R10utKIXkVSy65O5AqqpAm0YIHt9bMRIKElyEFpJAW83Ib+xnqL4kECK3zmoJ1Rz5MyR4KnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vWAer50H; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1+IoQs3LbMN88r06j2saUQbro4OXRzRhLHfnYs6/HK6+3i9HP+iYBHRNSY4URsHZWjMKt4Bvig5Vtzfq5y/AwjPQU+RuEp/JYykRIYwHoSY/PmM8JKhSKfx2fyP9fl4Pcw7lzEuC62zxO4sQ51oQRYBQgXUpOPqoyw0RjCrY35I9c6uamZGHUzmOOwTr4UPiSt9x0g5rscA0MDNy34WUEor6+2PM3s3MrdvQ1m6qXwFt2zo17FhoBxeYnPmBHKfA8oehQ4GbS1z8l78ieC+kd5PanWc0UDTBiiEqO3vWTA41mowbd/rG0drSHwNphZhS0ZSE1j5hNcjn7DgmLZVnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=esXbSAiVVB5PoD+HxHqGiaCPLKJ4AJynuShtiPOTQD0=;
 b=aObNdnkuzfpu5In0bv5+2jheXxc160mOW+VMBU4Nu/FLx7MUtzeKa9uKgMJZ6lSce+m/iEw/jM7f/PV2vRN/9H8V4E/KOFvPKobvwNSwxW1Q49Y4aGnLeo8g4LX+d1RtlpjEn3jeOKbuSCDc/5szxYfqBmcj/VKHz8bK+yEJruEp87Tknj6wIKrFYe0OF5u7O66v4CVfugeSX7YeIpzkjTQKFsjWCPteTqP+BnLFV6IEGl3IbqCxFzdfJiMLqpfO1BD2Zp94/NyoJaJOOQVHyQcqM37UFmhzB+V3A37pUCz2geTI6MurdnKirfLY5nJWV8fUtJJZSDIePyc/37y/nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=esXbSAiVVB5PoD+HxHqGiaCPLKJ4AJynuShtiPOTQD0=;
 b=vWAer50Hoa7vfNybtCXpjp1dosoWKQBmm6Ewq2cRDcw+fPBjXIYiRyJjY5eieErRbgdmUS+EX0fFBD0oYzHhB3KI1iRhNCSV3zBXDGslWFHBcjjylq8EMbVW2tl5eupScN4xkpqGCxYNXSTJgjnp3R/Ab6B8UhAbTekwjCk0huI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:31 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:31 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 13/27] NTB: ntb_transport: Use seq_file for QP stats debugfs
Date: Sun, 30 Nov 2025 01:03:51 +0900
Message-ID: <20251129160405.2568284-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0218.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: f0187964-dc57-42a0-6b28-08de2f60fb7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4KPxgfDUzkAwqvn4tusPKpVq9B341YAIYhDSN5jGhlgGL6dzrBnNfeudD+Iz?=
 =?us-ascii?Q?MPsosqlWgDnH/MRXDe9HUrYIcfbEqN7iBnscXWxPlmALZz1E/ofQyU3bgyhM?=
 =?us-ascii?Q?xyqm3QEQnAh7thDRrgVRVxIauMK+od66LUzq//czkwH+TNNXFoQwWDhNSaon?=
 =?us-ascii?Q?UjipTSiqwjwyj1S/v71oat0H+Ff6MdXbPxY05pZtvU/rBmO+D9c8lH0FjpC4?=
 =?us-ascii?Q?RkxXvpvvsgVQNFd75RSobCebK/tE4d7vcNbbTjpofPj+6vH+227NVkXRMlw5?=
 =?us-ascii?Q?6hAl0OnajfkamIOaWjjIvGmJNxhfC+NuXQ2I3YCdOCfXMR5TXFJvZ6IQ4eXl?=
 =?us-ascii?Q?SwGBmaCfieNOFqYItcDAOUQw0JADLpnFx5V6cv4IZthOTswCeWfsKBXDwZ7l?=
 =?us-ascii?Q?E32SdEI7st0Y8V2/P5a1voPhsTF6ldeygQYLXqpzUqCSTCqW67ywG3UbF58X?=
 =?us-ascii?Q?5T57NhOOwMKRPc+Q5278FtuNWE1sloil45S4e/urINiQOvcfcZFdwfO846Gl?=
 =?us-ascii?Q?wVdVrE9QSpHF5DbZmjJ8T35xoV5WhfMA2g43+BAMaTiaUOs6B+dM+/aFGDSp?=
 =?us-ascii?Q?MLEt03vzKJ1ZyoRFlqK04FzQYTswR8YCSms2c8Ci4RT9ZSrKNzfrTxaPSHxd?=
 =?us-ascii?Q?t/R7b75DvFOVr5Hpa2P2o+/V+/0N1rNrcqsCXuud3/RnaVqWffbcV3/IX3Bi?=
 =?us-ascii?Q?if8E6J26rAv4HZgIQqiVjKdGeA7fGfshgmTVO/otPR113/edrGag7Gr1Itx9?=
 =?us-ascii?Q?YAQIcY/kYv8gmr9j68RzfVC7POjGbKD0E1Ca7mpYcdxY/FG0ptopfabwyStC?=
 =?us-ascii?Q?hYuwzl8nFUJHZWY3VTWTW4q9fOWNo6l7vPbbH8pw4gmzwR4UPNYJWiVpvnek?=
 =?us-ascii?Q?1LPxX0I7yo/YuGGgXqETs1sJc/OwWVnWwghhSSYHri8ZOCsijHJgEkt7twnE?=
 =?us-ascii?Q?q79br4oNoP3DSddaBhsR6uZlh1v4pivCv1cJFkpZdLrrzX/PIY2I3Cv1Sd7l?=
 =?us-ascii?Q?trsycJRi9w0ct8boDt86vNa6V4K5KrhyA1kofvGH7oVWsmJY1q7ONdNZAxzL?=
 =?us-ascii?Q?E/t/lbQz2xxgx2vAm0K79Wv42NUXqEYwcxXwJqu+rcJ5KlVWCFDXNmMD0Z+E?=
 =?us-ascii?Q?71+NorazZMfkMEyZjOKOxtzInLhSWzURnk2u25FlwHnat7bM37g88ozZcwnV?=
 =?us-ascii?Q?pUB0GrsOk3cTkfcGV4EnpIyegH1umXp/9Wv1Yj2MfJ8tSLB5ELu64c/FPOdc?=
 =?us-ascii?Q?crUS6ZrIe5cO1Q6JPgXJbQXG3DI1hCKkvCRrDRAB6VA/0aRUWfAGXWs/3gZL?=
 =?us-ascii?Q?oFTh43ViKW+sV1DgE2XDjKKi+RVvOusqfowl/MsWMIGWTWInRBPBA9NDm+b2?=
 =?us-ascii?Q?wmk5lV8fHa72k+HoFhJ+yFNAJNIfLZwr1QxWVLrWxB5AJ6qF9EQy+DPjylFC?=
 =?us-ascii?Q?ZIdPwrvjETwZ33zHNqDpBWNJToi9xmdB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4YrkrC7nCYNOX2uQr6CK3O6VLCsnHYmLEaKlEfivR4S2iqP70azDStG49QvS?=
 =?us-ascii?Q?FWEL/rlDimySbarNAX7yzn7H05OX1Su4VRtpT34ZqcsQSvScF1Qrt03XA+JO?=
 =?us-ascii?Q?bANR95Kq7affprzPIVepMHNg9l9GJA3fY7s5r6mfSZ8MUakK+AVFBMb8V8GV?=
 =?us-ascii?Q?Oew7/zYBACxHqg+EvL2ZL3bmAOI00U6JIUHEc0y9sp3CoE1vDzFQpWL7/a/v?=
 =?us-ascii?Q?UUEcR19MK5dQo5L211MGlmi6Rwp+zFmht2fOsWZDT8/7sAP3cST0gVnJnEkm?=
 =?us-ascii?Q?uh6TEzvsA/KPorbLFR88/l2J865qG7Bvew+pz0/pvqYV0mLCTIfYmd249GKi?=
 =?us-ascii?Q?Y/5oDUwcBeImo3Tj+EXt3bzTJe2KPYTQD+uWeENsFQ8wV/JwXMMiXi/j4PTc?=
 =?us-ascii?Q?auFRzNC+gwlVTu2Z/CJ1UvJo6tz1yk7CpgXj+vqRP2OrCQi71CyCAQeZIxEm?=
 =?us-ascii?Q?xmtwdxKl0lbZrP133toNbktUbViuIizRu/zN4HYVBR96vxXOofB2DpJcTQ/e?=
 =?us-ascii?Q?ERRrx+eqiHqFt6aXUTg/loqXZhQofVz8zd9FsDIAeTNLdX+k2SU0d8Kwik3L?=
 =?us-ascii?Q?N+PGpiD/I6pPHjWf8mcIN0zNgCKH4cQRI0/60dMi6/QgqcX5q9Slqr2j3L67?=
 =?us-ascii?Q?yxCV+oYkQ1dafcV5dPZb4/59j8ud6n1fitDizQjH3Z/G1zR8j54Y8WtuMneJ?=
 =?us-ascii?Q?0QF5VAFgf/MzhMTScyvVC4O1YrZBS0ErUMl6mJy1dZnI8ajFVaJD0OaLepbH?=
 =?us-ascii?Q?Q8cX/7w+qkqEtb4oeTFvc3D77Fz+d4xLpTG8kHS3LaE6pvpieqm1sXSP/7Ya?=
 =?us-ascii?Q?2ev8pLMA2SklvPty5JWlh/XC5n/QNICZ5rWeKJczp5i7ZZeEhAa88N/vj3rF?=
 =?us-ascii?Q?UXvUhQ8GQLlM/huA7xSAZZIs5uk+1okm57H3y1e59sn/SXWvqM0+NxcsjzL4?=
 =?us-ascii?Q?CSZkH2F7FfmTUT+wlniVlGPbKp2NwpV7kR5rjj02gEYlrRT5O7tMkaa2hIz/?=
 =?us-ascii?Q?ssrTwl3QqFq+lpSYVRnS/nPysl0K42pKPMsNtHIE7AkkO/3aShtuoHX+Uc7R?=
 =?us-ascii?Q?KceSG11DrC+g2Q/CzOufubq/ePFgLDuweTG4+ufYypZsto/SXcdskL3q1B7S?=
 =?us-ascii?Q?eeFqonFHBjIfPD/HAET6D5OrBj6IAIjD0BNSP7EmwlTKttwzZ+qsrQmQyO+u?=
 =?us-ascii?Q?gkYHMRDCPlvAFD3KtcOQ6yndDPvGo9fGNPAl19UeBYZwaFK7PHr7ykrNftg0?=
 =?us-ascii?Q?DCvRB/SJPt9BbIPbVR3gxMGzjOwGjO56bOYV7jKiwkMLi1G6X7QONQv2xXvd?=
 =?us-ascii?Q?VIwHaUfupk3LOUW6VAI7D4AAp17R2GdkDCZkhaCj2uNAuWamR2rCUvw0yRxU?=
 =?us-ascii?Q?8Vtr0Qwyp+Mj95x254N43scxT19yodEv7f6jWN0I0wKW3BQbv22z/YwdFZFZ?=
 =?us-ascii?Q?OlFg0PPRLJBMiAdGQLhvjTcjELzgK7VOR0BLoynbkphTtsAQL7d2YW8Zdnpk?=
 =?us-ascii?Q?+tAOnnEtKSeiogEo5P7TCUpIYR4h0iS1/7TaK5UWUh4D5NAu/pXO5mqL7TQh?=
 =?us-ascii?Q?Ste2YgT/dAUyOcHj4nlSIIpp6Z8LSuxetE+pFGqhNnuwwvCp5EDYEUDB4G1G?=
 =?us-ascii?Q?7NGSegOE5GJDFjtqb5hKJao=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f0187964-dc57-42a0-6b28-08de2f60fb7f
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:31.6685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VLXl/lPlcpWl4TMvKLqNhDtziw979kOKlSpDHbIN024FmCzrJMKtI+IsdeSlp8Im/uu6BnlygXcFFmYoTbiYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

The ./qp*/stats debugfs file for each NTB transport QP is currently
implemented with a hand-crafted kmalloc() buffer and a series of
scnprintf() calls. This is a pre-seq_file style pattern and makes future
extensions easy to truncate.

Convert the stats file to use the seq_file helpers via
DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
core handle buffering and partial reads.

While touching this area, fix a bug in the per-QP debugfs directory
naming: the buffer used for "qp%d" was only 4 bytes, which truncates
names like "qp10" to "qp1" and causes multiple queues to share the same
directory. Enlarge the buffer and use sizeof() to avoid truncation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
 1 file changed, 41 insertions(+), 95 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3f3bc991e667..57b4c0511927 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -57,6 +57,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/mutex.h>
@@ -466,104 +467,49 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
 }
 EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 
-static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
-			    loff_t *offp)
+static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 {
-	struct ntb_transport_qp *qp;
-	char *buf;
-	ssize_t ret, out_offset, out_count;
-
-	qp = filp->private_data;
+	struct ntb_transport_qp *qp = s->private;
 
 	if (!qp || !qp->link_is_up)
 		return 0;
 
-	out_count = 1000;
-
-	buf = kmalloc(out_count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
+	seq_puts(s, "\nNTB QP stats:\n\n");
+
+	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
+	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
+	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
+	seq_printf(s, "rx_async - \t%llu\n", qp->rx_async);
+	seq_printf(s, "rx_ring_empty - %llu\n", qp->rx_ring_empty);
+	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
+	seq_printf(s, "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
+	seq_printf(s, "rx_err_ver - \t%llu\n", qp->rx_err_ver);
+	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
+	seq_printf(s, "rx_index - \t%u\n", qp->rx_index);
+	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
+	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
+
+	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
+	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
+	seq_printf(s, "tx_memcpy - \t%llu\n", qp->tx_memcpy);
+	seq_printf(s, "tx_async - \t%llu\n", qp->tx_async);
+	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
+	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
+	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
+	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
+	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
+	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
+	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
+	seq_putc(s, '\n');
+
+	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
+	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
+	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
+	seq_putc(s, '\n');
 
-	out_offset = 0;
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "\nNTB QP stats:\n\n");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_bytes - \t%llu\n", qp->rx_bytes);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_pkts - \t%llu\n", qp->rx_pkts);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_async - \t%llu\n", qp->rx_async);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_buff - \t0x%p\n", qp->rx_buff);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_index - \t%u\n", qp->rx_index);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
-
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_bytes - \t%llu\n", qp->tx_bytes);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_pkts - \t%llu\n", qp->tx_pkts);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_async - \t%llu\n", qp->tx_async);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_mw - \t0x%p\n", qp->tx_mw);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_index (H) - \t%u\n", qp->tx_index);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "RRI (T) - \t%u\n",
-			       qp->remote_rx_info->entry);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "free tx - \t%u\n",
-			       ntb_transport_tx_free_entry(qp));
-
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "\n");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "Using TX DMA - \t%s\n",
-			       qp->tx_dma_chan ? "Yes" : "No");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "Using RX DMA - \t%s\n",
-			       qp->rx_dma_chan ? "Yes" : "No");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "QP Link - \t%s\n",
-			       qp->link_is_up ? "Up" : "Down");
-	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
-			       "\n");
-
-	if (out_offset > out_count)
-		out_offset = out_count;
-
-	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
-	kfree(buf);
-	return ret;
-}
-
-static const struct file_operations ntb_qp_debugfs_stats = {
-	.owner = THIS_MODULE,
-	.open = simple_open,
-	.read = debugfs_read,
-};
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
 
 static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
 			 struct list_head *list)
@@ -1237,15 +1183,15 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->tx_max_entry = tx_size / qp->tx_max_frame;
 
 	if (nt->debugfs_node_dir) {
-		char debugfs_name[4];
+		char debugfs_name[8];
 
-		snprintf(debugfs_name, 4, "qp%d", qp_num);
+		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
 		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
 						     nt->debugfs_node_dir);
 
 		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
 							qp->debugfs_dir, qp,
-							&ntb_qp_debugfs_stats);
+							&ntb_qp_debugfs_stats_fops);
 	} else {
 		qp->debugfs_dir = NULL;
 		qp->debugfs_stats = NULL;
-- 
2.48.1


