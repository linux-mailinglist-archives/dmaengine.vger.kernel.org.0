Return-Path: <dmaengine+bounces-1048-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 127A285B8E0
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:20:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D676281DCE
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DFF612FE;
	Tue, 20 Feb 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="cQRE+MwA"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02olkn2026.outbound.protection.outlook.com [40.92.44.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC2612CD;
	Tue, 20 Feb 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.44.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424435; cv=fail; b=KwxD+QUhleAVk/KAuQIs+YULxbg09Os3CaspiA1FmPEmLSCOP+zAyTzjvdB0R8i6Kp5DBV291HtjVJrXPyAeKPo7RRybJmDIDSj+cZUIbYgmKkDO0uGYWSeHMn1/jK5pygLoCqqyGIjSS4gwM/X+tnl0jmN1zumKG8LrEbiJvQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424435; c=relaxed/simple;
	bh=4Y+lZczuBSWd4c+fmfkrznNnCx063pkkQ6axcowgtJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hTHCjozeSlfXm/sS5j4wLMtjtVNT4sjkF3WT/6b+yDGHvLr8Lwv5QmK0zdtR3ohIcqF1d7wlP6y7Wno2kEJgW6hOXT3GQ+dTJcWt1OfEqoX+GfRFSk/3zjSw66as7mwlM6HipuHcg9I3uNZIdQxK1q7oCTJnXvpDdkuVHusz6mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=cQRE+MwA; arc=fail smtp.client-ip=40.92.44.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTlsFq5ENqziyPDKfgD9zieKO+wQMLRjTreAidP2t9AFjHgy9PuCSgCZVYOeU75/u2CMC6yYkdU5fgTpMBNkG39nbuXVBJnmnWF8uzQZzdKe6fZLiLj4fumyNr3a9x2eaZqp+b6TQTmR4dS+kipXewEBIYsg9OIpg9dNusNv97m4511xqAdkiL0r7m8D6+1ZdAmq6COeH2X4a/gtqOM5RNlEt0IaEGnLrqfUEoDA04umX4u4ioicP6FEfURWQ1Xjc/s+I1h8hq9QMoPagSpAldS160YMUAabx00v/LH36OFXHNgFnSjez5T4nA1DjOvfD2PwGuCXrt6NZk//owcnjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9blte/oYIVjIztCnVuSc3Zi1abw05pc89Kc6LVCHUlk=;
 b=U6d15aNxd/pTwB4XOrtXvWAxot+QUF3otkbV/1WccWUukvuNimezeF7yMIfnUOCASEAKIcSN5bAlt2GXKKr1SSkhE0Z7QgO+YJ14ZZmMZyLtOZRaXwt70VZIwTX0dIp4oSjso6dYvMC/dqYES6EtNQJSw514qlwLBkVo5Q4LQJuPahZ38JbXDwr6m/6wtnWR1xBDdztkWISMyZ5zouyEEi+bnWyXoWrt8PTzWc/hsj81YIDOGzB9v7wqiwW7zYG1saZljBDypcOxBFglfFGutH0wrRjrCw+h/djVDqLXEPzPSvPrNgk6w/+rw5eaAsWS4T4P86i9ASduDrUhHhmDCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9blte/oYIVjIztCnVuSc3Zi1abw05pc89Kc6LVCHUlk=;
 b=cQRE+MwAraYZns7Q/et0WTkUvtAW3hP/rXXpbtdJY++EnycYnB6KUVW1VCSnPvePdOkHtUAyz6S67mqY3h/9w6hkn7Uim3PqgwMUpwePb/g5oAPB9ow9MAHONYj0YxJGNOZ9gZ8rdQoInHs8f3Lz3XRU5px9n7U0ISL6+1iVyuGgdyqxYder+SfNvPFHHIQbsYUlCwz06aiMF6ce5kde9olPIARwNqMmLJFOiD6esCqz/GVhzCd9fHJ24rHm9YaL70TP7ED7QivzBOeFpym3Ja6x3ZYbpXjLsG5antXXZFTsC62N9hVKeWsGv+zv1ZiMWmbv6cFDH/53ixST5njv+w==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by MW4PR20MB5156.namprd20.prod.outlook.com (2603:10b6:303:1ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Tue, 20 Feb
 2024 10:20:31 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:20:31 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] dt-bindings: clock: sophgo: Add top misc controller of CV18XX/SG200X series SoC
Date: Tue, 20 Feb 2024 18:20:29 +0800
Message-ID:
 <PH7PR20MB4962823548BE1CB8E225ED09BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624130A5D0B71599D76358BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [aNiP0EAz0lB28HdS8r17bHZ6hs+QXw3PZOhsV59Gp4E=]
X-ClientProxiedBy: TY2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:404:56::27) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220102032.870200-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|MW4PR20MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: ad236ca9-b7b2-479b-7f3d-08dc31fd9100
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vVIX4O1AQbUhAkozBbTsgGu1VUub6I+13sV/3e2Nao0S9BNWsB8ManZfeTOVo7p60kHP/qUcWOmyWegMI6++Ic4rURrl260Q1xUld8IQ2NMNY1tcsk8S5BWUh7dSOdR0nXtExk4DEcjSgcPZkX58324Mn4l9E2vQVJM6YSj+0lI4LaKIU49rr5ysKDSwaR7+gcYu0ibghzd42N5SqDuPMdDyf5egN5J12r51P2GdozWFhZ17BNdFhHmBwXr+etFzYUZ5Mt6ASmp+So2zp3QLI/Eqhu6JEAoLxrok9sNBZne4Z7TBptu7fyYOS3K7mBrBmU81PA+uwN7/qjIrMYimbR5BkVJo/oZFmx6Uf5qmP8ZdQJNfvkHYSvuGUvGZi/6IX4gr/X+bOXva5zvkTR0eeerfOf4tvGOXOQb+f0+CMH6p+nkNsdSq7PuIaTdkaAzJ/t71gXgGVHfzzVgjxVAAwGHpHKgFbOqt5wVmKOsnYTn8Ei6Zd2JlsqR3r1cT8oVpcfB/Hg2munl5CiJlAnxG8bJP1gdtev88qDhaPGqGrDTHpHc+R/Xk0pQwED4EPu4vKFtLEfXkhqIBsIUUjo8ehNLzJYazBeinZioiiYbcSZrkIj8h7ifs1PQwvCDKU4SP
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8gvopGn2ptUsdoYpOTzbJnVcsu0U1nHlT4a7DfoIS1i1iNw0MHljCB7XOkCM?=
 =?us-ascii?Q?NGn5qi4+sim3FzjSlFM9MW9qBb9uAiy8DWWQkTk0ALQ9PpYTXJcg7ICWai5/?=
 =?us-ascii?Q?fmzQ/f/o/tkdBszr9d60lTgOpGFrRT4VzG9OGHRhU6y6BBmVuzFR/mX+Ozyw?=
 =?us-ascii?Q?dOWcqpKZPZ27tFohcIuiPrYWVQ8k0Lj3EFLDoFP1a4DqHHbp5Us/gJR36UME?=
 =?us-ascii?Q?6xp7eEVw7dB1cSKLEtbz3X0CsPa5qSVV8cIjgADRFM1LrbvU3NQ5EpLnWiRv?=
 =?us-ascii?Q?B/twYzTpNpZjNl35PS+UzaSghj75Ju8rhzmA22UAelHydlUG370OPltS2vrV?=
 =?us-ascii?Q?O6sVaVBW2/W7Z2snGUyZ3ZCfMleAZPLSNQZ3WleCrgmDDI9su+ZHNMAsB2dU?=
 =?us-ascii?Q?YiAeOaBvINfCxxT+Yz2nFEjtqq6ZOTaM8+V6U8dWzPASM24zPQ77HfAXJsuK?=
 =?us-ascii?Q?d3N5W8z2XVSFfRnEikzGYNdtbmmSgS4+1Vpb5rmvcn/YCeYLjQbByn6LdP8c?=
 =?us-ascii?Q?GLxsIdbi+U1ytBJngxg9zWm0GMrAprfkmjn94Yd9QqzgV1zbrb7Ie/HIny9E?=
 =?us-ascii?Q?ceec+26/J12ZRYqLc4AcMeN2wBMWNXiHCj+jpo327dXtLU4Upo9d4amgw+Bi?=
 =?us-ascii?Q?QOdRvd3C/W1vSKtHHV7zib7Q7of/mSThVhFsHDEvqqG1eQw+3HHT2enwm138?=
 =?us-ascii?Q?Gq3w1YP/cuYowGLtlcNuZt22queVsysbFnsgk+I14o813t0wYRpjMJQgJUdW?=
 =?us-ascii?Q?QrF2wluyXo736D9DgCjNu4jY/EMwkiGjX+wOyRJQmIw2OqDpWr9J99X15F6B?=
 =?us-ascii?Q?PEqUP5SQFhsdda8i3VQ04U6wNCb5v4uCXhloyRxNOy+S51gqLr2AbdNhQXed?=
 =?us-ascii?Q?Pkm7YW/CJ7eHQJcC/Ez3Ei+/9nVHKTKFMEVRWYkaL/91CBBy8BgvxisLNsDH?=
 =?us-ascii?Q?g7A7DYCqohDXFj+8HfEo/WMY1t63G3ztAhMkePuwtgpdZAJJmAf8SKRgLooG?=
 =?us-ascii?Q?mmufeSk3iQyOzOxeIgTkPf+4jr+kdytYDXB0tLRB8YJFbQ1MppdbtrbiV1WM?=
 =?us-ascii?Q?xL8yEN7TdnOZAl6xw7yCqAeEfFVz895+NES5J8wJiJqnxMAEqkynqzT2mdFf?=
 =?us-ascii?Q?ItS78xaCJmcr2yHcT/PgmIDxnmyaF9Zf7t9m/k+UmdoP8woyKdSHZ8kyJ5E2?=
 =?us-ascii?Q?E/MUR3CF9m5HXjnMiFUTwY04pq50ei4om6izazbsBrJSwLz0o+yyfoejWZ2u?=
 =?us-ascii?Q?OtNMHf8FV/BEMeZth9in?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad236ca9-b7b2-479b-7f3d-08dc31fd9100
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:20:31.0634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR20MB5156

CV18XX/SG200X series SoCs have a special top misc system controller,
which provides register access for several devices. In addition to
register access, this system controller also contains some subdevices
(such as dmamux).

Add bindings for top misc controller of CV18XX/SG200X series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml

diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
new file mode 100644
index 000000000000..29825fee66d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo CV1800/SG2000 SoC top system controller
+
+maintainers:
+  - Inochi Amaoto <inochiama@outlook.com>
+
+description:
+  The Sophgo CV1800/SG2000 SoC top misc system controller provides
+  register access to configure related modules.
+
+properties:
+  compatible:
+    items:
+      - const: sophgo,cv1800-top-syscon
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties:
+  type: object
+
+examples:
+  - |
+    syscon@3000000 {
+      compatible = "sophgo,cv1800-top-syscon",
+                   "syscon", "simple-mfd";
+      reg = <0x03000000 0x1000>;
+
+      dma-router {
+        compatible = "sophgo,cv1800-dmamux";
+        #dma-cells = <3>;
+        dma-masters = <&dmac>;
+        dma-requests = <8>;
+      };
+    };
+
+...
--
2.43.2


