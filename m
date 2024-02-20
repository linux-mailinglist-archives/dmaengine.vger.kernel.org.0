Return-Path: <dmaengine+bounces-1053-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 769BD85B90E
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 11:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A698B285E11
	for <lists+dmaengine@lfdr.de>; Tue, 20 Feb 2024 10:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434F5626C6;
	Tue, 20 Feb 2024 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Bk6KHPH8"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12olkn2063.outbound.protection.outlook.com [40.92.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5B61663;
	Tue, 20 Feb 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.22.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424945; cv=fail; b=UWvGm3B6Rb/tV5nevQSeJMNongehtTgPKf+xtzYjc+PcqMouwpO/P1K45xQg3niceLpGLGE/vo0Xa5mitv8AQvpnbdXVi4df6yJV/NzIv4D0bVeuCxl4n/MvqM58p5ITjfH3iGn+NMAgtGrAZIdEdGkksakgTNTrteRub69IZQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424945; c=relaxed/simple;
	bh=4Y+lZczuBSWd4c+fmfkrznNnCx063pkkQ6axcowgtJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UZcCh7zfj7tU81py0s43mHN1TZwBwNPkDav0I2KQ/eizqs4yjVUTmPYich1DtALx02oZ5/WEXuXdK7INDfXrVYFZ30xXDNYbX96GoC8eSehvdSvAAUEMGD0INpQMFOztRDpy9od0IQCQGIanPYMIjlswY/bRhdyYIqwTa6Gfc9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Bk6KHPH8; arc=fail smtp.client-ip=40.92.22.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLOuQG+7oPtTAOKQHEhZIdD9/R2Zn7Hw7MxD64xOCiVWELHj+bJclAs7M68z22vU1LdBplO8rUf4hOuRnsmXOEKHMKvc3y8Rfn0bu6rHh95/KPX8OKHe43naFC9/fbxHruj+Wdnnd/Gmixrkq/gLlU7R+HgCRhzRekPTzcrWor8FH/HaoBmZcbEDZvcL9ZtJCs7kVsSdt+bNJ9NJItoM9+fVz/q3mDTOhPoAKEBMCpPyigvXplFZZORDiGXKOxwfLZsGat5ZtTgcycvoanSI2Y2qZ0hBtMpGE4p3Tj0SkgQcuPHvdD8sBC+yiPMJl3U2FWajJywWGeXGjKkmHnyIdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9blte/oYIVjIztCnVuSc3Zi1abw05pc89Kc6LVCHUlk=;
 b=kgodHTVPWTe4KV93EYiaa3QNhaR5LzTa3AVmLTMVd21Tec5z4JVy6EeVZCTyCdnBYZ/2eGsakXyi2NMn2NjLzBApMAlL8DmaXgstJKXCt9zJDM9Os7NfJLIn/B6BT1+aY9oTqELb5uVD144aXfdOVK6G/0yJkRQuli3F0AZZLXAbORtpQKy0YKfSOYDjbmgmYIdghGQyLQsp63TMPXAARqeXWE8epwc4uD27NfBiHLml2yOenBRrRWi15Kmvk/+5wIZ5FF1aBmELoql96aRwtvCJzZzKF8acHkNNLmt1iBP8hQjmY+KCzAcIKHIz8eaR8LcEgaJbjdvcx3WP6aXCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9blte/oYIVjIztCnVuSc3Zi1abw05pc89Kc6LVCHUlk=;
 b=Bk6KHPH8rE9WxI0Yo/8PwvouU8N65N9GeDrliiv8q5F2t8zjkX3DasAqhKAjLTf/ANF5sOOYElIz2lp2L9gNN2bjhZ1SqvBindvs+G25sdMEO7zA3smk9nwxoFbtd0L/rYPoRkfA+n5F7On09hTNBT8GKB1Y35KMGmxsHFksE5W99kCJxI36qkrqtpiTpiWMUAcAw53Cc0HC2ZKVxf8/PaViaFzJ/5pg8BWBqsVVh4QBE51yMPSPJFSAh5b82DLnCxmTDCrZ4ZDD57BZsbx60V5tw4hljQR+NAogif1PPc0TO39qQ7JTeQpx3ojcd7SSR9pAlMjUblamuv+Jp83KwQ==
Received: from PH7PR20MB4962.namprd20.prod.outlook.com (2603:10b6:510:1fa::6)
 by IA0PR20MB6813.namprd20.prod.outlook.com (2603:10b6:208:405::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Tue, 20 Feb
 2024 10:29:01 +0000
Received: from PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff]) by PH7PR20MB4962.namprd20.prod.outlook.com
 ([fe80::4719:8c68:6f:34ff%6]) with mapi id 15.20.7292.033; Tue, 20 Feb 2024
 10:29:01 +0000
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
Subject: [PATCH v2 2/4] dt-bindings: soc: sophgo: Add top misc controller of CV18XX/SG200X series SoC
Date: Tue, 20 Feb 2024 18:28:59 +0800
Message-ID:
 <PH7PR20MB4962BEA2751F7C45A16E40B9BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
References: <PH7PR20MB49624AFE44E26F26490DC827BB502@PH7PR20MB4962.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [xw5cnSw+Sr9IA9HuTo2hICCnhKkC8dVex/ANf22Z0dI=]
X-ClientProxiedBy: KL1PR0401CA0035.apcprd04.prod.outlook.com
 (2603:1096:820:e::22) To PH7PR20MB4962.namprd20.prod.outlook.com
 (2603:10b6:510:1fa::6)
X-Microsoft-Original-Message-ID:
 <20240220102901.874602-2-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR20MB4962:EE_|IA0PR20MB6813:EE_
X-MS-Office365-Filtering-Correlation-Id: bd689b2e-a2e8-406d-4de0-08dc31fec112
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3PRifu/rzX4vKb4qXv6zyQTEbu5uJBLjRlflbiefyfPcVO+skYyaEBUrlsaKim8mqaqRx9qlAQ2jwUwVsWrkTHWUgwh45+wBVlRFQQSAT422gMPqKYE6cNcvXDV+0Khgbb5i4QWwQLzMixI16I7vJFkrQYEbpg1B7PI9YRi4hNW+AnLj9bZtEuvm5wlZZWdcXprInIMNHhG1WYV23Inx87SFdaPoEVAG6m53zpUKasf5bkMBBG152xTVl0TtUHrxLvMqJ6vG9b+gUIulFfYG2wIGuf5E19aG1Z5QuHs+B6ffUkREmWxbHx2mMguun+J7hALiLptq07GQGTDHoRkLxcuRGYnwqT1oP49ZN5jLyMWexNynEvzOUqFtU98RzuZTj+xAhJS+Hr1oJjU0oJhazCPDTu2dmXq0xw+8RnRzdiLwARivLJIJYdnc59cCJid8fBJB1WZatIIEs6xJo7SAnGEKUsxbnFfn0fv4XkDFnCSa9myViJZjHxA6OU4izWaQf/uS3qVEWQTstiT1QKms38HEuPXUkYPBl8OsY0vfiH9jADyNEQgpz1KD96qNYCWuMCQHo8l5GZY0I6DNcGbzlpmWL7XRucc4xVO+z+YrIgYwA0GctB8M6cbwNfLU4wUS
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aVRizulA2l+O+/dLNOaNSL/CmLDGC2F+8Vq3oSz+Hff+OmgFVUzmhZ4zae/9?=
 =?us-ascii?Q?cLiIZDi+HT24cCpqgT1s7k32Qcvukms4snkUVYVgPWOnbo2FqA29uD261lAU?=
 =?us-ascii?Q?3Cx4SL09d8vVB6Rb4jQJkj+GYMl3HJoOy5nMXQ2kNl4mW34hFOqpuVByADn3?=
 =?us-ascii?Q?Jh57Du5tIpDfSawGS5Jjad0wqVY0jhnOa2blh2x5OoC3QLg61To6AIcM83Dy?=
 =?us-ascii?Q?dNso+YKvwJApZTrFSv3YOzcwl0CJNz9vN8WuVG6mBXxLJWII3w6tMythqx5N?=
 =?us-ascii?Q?UJktzNzTlnntNHRmUVaibYCk0I9xIM7wQUMvC11hhH//Yi/PpW7bWzvoJfvu?=
 =?us-ascii?Q?RBNuNQS3i0nP7PI/7/lOLn1SJoimtaF+TeaeQuIP685ONtBa0rD8G2R9CB1p?=
 =?us-ascii?Q?Ik6lXiswFVxkmAq+GO7B4PZwoRs6XZdFJOQ9Gf0T15UNRxtFmhL4KNhSIEg8?=
 =?us-ascii?Q?bsFcy8cNF0ZX64DhS67w1qNfl7kg4UvOqzk7PuGz/cKNqvg7Io0/5FL/floF?=
 =?us-ascii?Q?wm8ihRYO+BDfUnDWmQQXfGWwxMYVxFQHNgXIxgjYQSziv1vs79vI0ofcXp2L?=
 =?us-ascii?Q?3RP7bRqJwFE2kTv9aFFlbkHQ4m5wZGveqlQTk4vzl0vat6qB22JSD8i3Hwll?=
 =?us-ascii?Q?TQqe2cyMCf/f1NQOmxE/r6LvUDU1Bny7nz50JM9ZuYb3eEygRQ4lcmz0ozuV?=
 =?us-ascii?Q?Sl3DKfZO4iPYU+N2qldwfg3UDdVdw2Q32j0m1MJSG85VxepJX3l2qXQu0/ZZ?=
 =?us-ascii?Q?ONlwfVsQUz34/xrKX0Hm3L1ZvTCFYBrYoywSuzjhjLFV/S/iplxxJrsScroe?=
 =?us-ascii?Q?IwH1bnqYo64UWK76aBldEL8HvzZ5Qr/wO24vgsenZg0FrT5MDdnwRtnDLkQx?=
 =?us-ascii?Q?42YW0NQbue6/FNffcASisqXEB8Ty6GapRseGZdapCRJDWJPgwv8WXacgcrSc?=
 =?us-ascii?Q?j7OiABrQbSEcojHRLut1IjT261Pk3kb+SK1fWfIz+PxT/1Kl0VlZofr3IwTv?=
 =?us-ascii?Q?PJ6vzSO5ITNNV0da63fQG0mOzFxhdrV/ioeV4/V6DpqEoC7WHe8+U1w29wwM?=
 =?us-ascii?Q?s00x5ZboazvAgTZPLfPgpHtBf1zzaYyKqID3ZeSRBXCWCly4276Eiw5TrVUm?=
 =?us-ascii?Q?+OJL8HO9awYOqlLyJnAbHEtpkmYy+qOaRZHlKb0NjXyc0MNd14trJbLGWDFO?=
 =?us-ascii?Q?Qxm1A3O5uAoci1oonoMOFm+x6YTu+YX4gvL/QUsEpt10k0I8CDoMuEbzbZ+l?=
 =?us-ascii?Q?8MiZMOnzZEpAAYuv+UGX?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd689b2e-a2e8-406d-4de0-08dc31fec112
X-MS-Exchange-CrossTenant-AuthSource: PH7PR20MB4962.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 10:29:01.3343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6813

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


