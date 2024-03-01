Return-Path: <dmaengine+bounces-1220-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE9586EB5E
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 22:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA631C21496
	for <lists+dmaengine@lfdr.de>; Fri,  1 Mar 2024 21:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220559150;
	Fri,  1 Mar 2024 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y2nDEvf/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2074.outbound.protection.outlook.com [40.107.8.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0AA5820A;
	Fri,  1 Mar 2024 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709329561; cv=fail; b=LBYwQ7P7B8stgoS0POIr0c2FzFe9NRtqOLIpKlsVR+ra4D2lU/VQWqy8kq4qP44DlyGuvpoS5CsDKzVaJlMrDAnXED2zbhttnbHvqBxba4ib1+y1QID0RyX1tXf2QMHs6VC8d8HDoGAnZY3TYUEYne7Q0rWmnItXMz9V+u1xaTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709329561; c=relaxed/simple;
	bh=zxqSnPYquYDPAFFmcfsqNb5ShuMuKXjnUghfh2cuZ3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NXU0TLNpwSkIl6Xkyg0CpmpfCZY9bsSZuXUiPL/SKv5ApaegnbRhJcRbNt4dr5nVkA+InMzfCzsavC188lplb+OWg16iAOlVKyj8EZ9b0xVqFVqGK+qNZ79VwXIeVNf/Qy+wgExNbKiH4e1Xu/rVu2SsMkB8XrdObVpDp/VSfKs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y2nDEvf/; arc=fail smtp.client-ip=40.107.8.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EAjyA+lW83Dx3AyJ7Tr9Gjx5E9m/WIecFaUO8psMy6ZZ2zAhb4HU9iLORiGaBEQpSm8ghDBwT+jxoyaldvypj7A5u9tJL7bTHk7a8rmGYx3EmFDX/rTs+HD3weMEt0nzT+5UEOup1UQPqBTWyDk0Vo2fhi+zyOj8mhxGGrcH4NybXF/6p/jbd2HWM9itA12qP2CgUz5gv65geoG5z8Db2bmGZnrHQ6fcSJnbw5NMQB+08DbemOb9ypCfa/Ctvmtry80I4UDNoCznMRARfGYKRZdFUaPBE9bqquyGpfJMoU3vquIDIhhtIDZIv/VsCwuX0AQCbLfcANvqlGdZLTOeiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kiUcEomaZ1cVPBbRlczd+NnblB8odBhBEPQmOl/uJJ0=;
 b=d0v5+DAdgzS7XL0T9SykFUjyNKdiXNtNsaKvuUMIxXSOitTa3A0Ph46tu9wnHbT6xVbGuXKo9BIfkPzHlpMK9FjJPyZ+4Jn3pKs3OKpB/4Z6KqZ7L0NbKabqlBQcu4rFRioO9kHlHmmkPpJC/FGdWqnfZpkClXDb6ROy1ky2uqipJxWtTW87bMrtqHiGf8V8fmyyIwp3B7/MfuN9Tzonzezks1jpKjhNXT+Vv9bQl2+skFUfW4UsNY/2zdFH6PqdZdMa2QJxCldyghT7RDu+mG3Iacv0Hpq7PpvkmEXXzZSaZSmm3CSRXzmbw/lCo07kXhJrPkLC/fN2tmZKmSoS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kiUcEomaZ1cVPBbRlczd+NnblB8odBhBEPQmOl/uJJ0=;
 b=Y2nDEvf/f9em0PReAfAxK11c+FDkAoZHYi6gqQNAMIXM43AGrvB7Fn3B2xv+KPqjVrAePIRYQCf/Dovs5OvkjdcKQgW9yG/M4D4N6bFLZit3tWalRSziWZOrWUttcjhVNGQk/MV7QQTbsviV8ixtMPNDNwhKFrUjlGj7wffLQhQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB6911.eurprd04.prod.outlook.com (2603:10a6:803:12e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 21:45:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Fri, 1 Mar 2024
 21:45:56 +0000
From: Frank Li <Frank.Li@nxp.com>
To: krzysztof.kozlowski@linaro.org
Cc: Frank.Li@nxp.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh@kernel.org,
	vkoul@kernel.org
Subject: [PATCH v2 2/2] dt-bindings: dma: fsl-edma: allow 'power-domains' property
Date: Fri,  1 Mar 2024 16:45:36 -0500
Message-Id: <20240301214536.958869-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301214536.958869-1-Frank.Li@nxp.com>
References: <20240301214536.958869-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cfeee85-98d3-49d7-7381-08dc3a38f97b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tUdSOCT8uEcVChG1WKkuHqH3BRSiT5hPhKlc+el0gzIN9+VmdjD+booIOSoTPLBLUgHlu7+x91ljwZb83zHC3zfzANPJlfzmD0gAp6OgIYIyYv2Fo6WQJcSkZZ6LZe8riec86nGxGMZn6SAZuY5xbF+ZE+PoXcey6yT/zU5iNMO/qEe5Whjmwk2enpLVDuMcpkteYhRSQ6cRrDnbMtnu0PagmHlWePBdOGGpOqoNyUMFFfhDO+yJdh8lCOgAkNoOrwZo7hGr8Kol6PVjAJy5R0gBfyCHr5OVBCUbZUNVykhHwqA09510/9Zd4ljlU6it4/D3VuL1uWvkS5ss+PZdYBJcEuBxkChF96eVZ5iqNfWOSzNznDofR/0rTiyFC/ClhieCEckyiafYVrfEPVgORrqbh2VbhIE0B+lHHDjxE1p0AquiqZqK7AtsIksa70SnO2jsd6IX9yRs+WKhTtgrKieimB5BfudECfyXQ8RtmurJOvmiLybULG09J/SpIpgVc+QFcSfDH4mCkVnD+VogXgWg1BoCsgebJwAEUBqDN4aQ76M1i73PRRqLkiTQ7n2713ZFtHv+GUpkgXhQImUKMPFLTtKR51k5URb92RafgwIJqUxEnFUNkT6i+ROaIyk2zGRTgtc99XX7eoTVF0Ej7GmyDDS5dYQtG9DBWMERwPePNlweUggaCGe8PL11Q0w7WpdY73SbpWYkHbBJBf+IwQhvSdxtQ22FJP5sg7zdwZo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SUb20mxCLwyhdqGMP+jit0svHELFTKQ8TFEO+mgkuN5OyB2Jf9rOZdEHshdn?=
 =?us-ascii?Q?jYpGV5gvorDq1M7j4pgPbeL+o1Y1dJxJv9fX131TvljKGM5qFqAUlPIzlqEw?=
 =?us-ascii?Q?sHMv4kWUzqpFtWkejtjp4j3B+TRq6ZIqbULnXkLSg/TRI/3fiFRvpvrePkU0?=
 =?us-ascii?Q?Tr9hR9ai15hqg7uvzNrkFlYElAwLTAKjSZv+1Iyr7lcXkv/rF+zje33h9Eep?=
 =?us-ascii?Q?cR9joAHIfxXmtIonoB43bQorveRNYDEjmfRpo4IfQCXkHFBeJTzDTaNb8wbY?=
 =?us-ascii?Q?RWweyLhJVUGSymCEt7b/cUtZos6pJpzDRs0N9ICNqoX6nMDcP4CdHVv41jAF?=
 =?us-ascii?Q?EhvPLv9nVGINS3YnpPqYHc27Ulxhza8+YXzlcQrIqNh/wrb7k/RAKZVdvota?=
 =?us-ascii?Q?EvzpA28GQxrohyp7+qDmdz8YpZI3xU7fd5KOhBECs2BXPZMQ+vdrL1AnynP+?=
 =?us-ascii?Q?rfSIfslbvz+g3vEWUZqlTdJMUvgrBxHSS9/VjSMTgR7F7FHallcZouVwdgoF?=
 =?us-ascii?Q?K54QrvHsVrk1TKL9JMwXslUloLUz7v6Cngrw4f9kKgjVd3AmQAVF2LamQT6S?=
 =?us-ascii?Q?OJvpwhPOz0IcnMH9p74fQ5kGuVQIbtyrIjf85+TWUDC4G5gy9lABeQQ48rO8?=
 =?us-ascii?Q?q2Vt3HcQLpkhMAEdhtsiM2/jKi3/9W0iEG+Zq3AuXHJBResYdI0JnRWP89Dc?=
 =?us-ascii?Q?mBIVSvqeigP4dh5O95N3rj5eYZuzlT5ViXsqFiLSwyxzhDlTNtYWRkFwgJ10?=
 =?us-ascii?Q?Z60O35vuEXMz+SWn6ebMGVE9NyD1Gdz1DvFpjEjvt5zmjIt4X7NmKwkGDkDp?=
 =?us-ascii?Q?xaKRnfXrNxYSnO4ZkLTUnJxu8Fx1m44Bs+Xdq4j2LtHlSBRNIIwUwCvhJkcO?=
 =?us-ascii?Q?Z7ANKfJoi6udLAFChZU9T4gFk4wprkyry20XjoWbgZqhXpZZDwkKpStZInUt?=
 =?us-ascii?Q?jwwqhQH6x29Kz6VjbgQbCUOeyPaM95PCIQ99Dix6naiA+CaEkSuKC+ReCjvI?=
 =?us-ascii?Q?PIhLH4M1tMT9cvmSMQDPhUu79Yo9901sneHbPPkJDMuURvknphdORMWhPDeV?=
 =?us-ascii?Q?QEeLcQUbfaRJZozSzKOqA0zA4T0GLUA09/YepZ0YloMLQLIdVOiXVs96Nwn0?=
 =?us-ascii?Q?IVK4GqmeH7288HzflXoMsO7HTy4qftHHNfIQTUe2JWpSefYTKgCMah6j9+Xt?=
 =?us-ascii?Q?nODQGVuqIuycAWzwhhVdsFkFFZjSlO5UCTd+Ht9mWLHK39XBCTpbR4XccLf7?=
 =?us-ascii?Q?pXHmLfLhF4hVP/PrsSDk8E1Xp3C4M/8PP12o4s1OkfcUeYKqe9KK/sZsijIV?=
 =?us-ascii?Q?1jhqhhZEPcgSQP+ntTNophQHF/kU5rs9TAzfatw923RYQ0pHDBkBOpSr/3/w?=
 =?us-ascii?Q?lhzrAKexaCJ1CPgA2KtG0ftLPzvEcM+PwRGYBGT5Zv3dja9LRjp3fnLIuAQz?=
 =?us-ascii?Q?k3vZWGKnzlgLchj1uMVtjpYrw/lcPPKVY3U99CCHMaAUa0fFTlEP4S4Sw0/l?=
 =?us-ascii?Q?MgcjA2aBs8d9XS3hSSD697GC6Z1ZB3Wct8MjG167JQyB+6KJV5bLg3ljoFLl?=
 =?us-ascii?Q?cfvzAv3W3eqmsT6MMw3Es2ZGIJaMI0Aw/IFIb4j8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cfeee85-98d3-49d7-7381-08dc3a38f97b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 21:45:55.9655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3TI7TFkeLkes8RkHNXyal+1pE7ww55lwXnc8JR05p3edyDrKaUva1tdX/5tQxcyaUWc1JskZpK1rq0sZ42BQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6911

Allow 'power-domains' property because i.MX8DXL i.MX8QM and i.MX8QXP need
it.

Fixed below DTB_CHECK warning:
  dma-controller@599f0000: Unevaluated properties are not allowed ('power-domains' was unexpected)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - using maxitem: 64. Each channel have one power domain. Max 64 dmachannel.
    - add power-domains to 'required' when compatible string is fsl,imx8qm-adma
    or fsl,imx8qm-edma

 .../devicetree/bindings/dma/fsl,edma.yaml         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
index cf0aa8e6b9ec3..76c1716b8b95c 100644
--- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
@@ -59,6 +59,10 @@ properties:
     minItems: 1
     maxItems: 2
 
+  power-domains:
+    minItems: 1
+    maxItems: 64
+
   big-endian:
     description: |
       If present registers and hardware scatter/gather descriptors of the
@@ -165,6 +169,17 @@ allOf:
       required:
         - clocks
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - fsl,imx8qm-adma
+              - fsl,imx8qm-edma
+    then:
+      required:
+        - power-domains
+
 unevaluatedProperties: false
 
 examples:
-- 
2.34.1


