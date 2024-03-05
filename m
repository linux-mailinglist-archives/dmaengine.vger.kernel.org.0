Return-Path: <dmaengine+bounces-1260-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D457487164D
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 630F21F248E0
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544487E581;
	Tue,  5 Mar 2024 07:10:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CE97D411;
	Tue,  5 Mar 2024 07:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622636; cv=fail; b=iY4RAgrg1XksCeTBC51YKfP3bAvr7QdwafIcR9RNCRGMPGFkWKlNY6uVLRKNll3MPZucLlB8NVHFCNS/BeiFanCpGsgm+peCw8IxnbSkP8RvOLAJu7MJNj24ItRAKGo3zTfuNpzef5LFJDtAREv1ooDKGbBfoUCxo38QYr9MG+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622636; c=relaxed/simple;
	bh=G6Qnj03YpRUqKd4fABm9T3V8nIbn6F4entfJ7xT1Fj8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RPMGNLZ7sqB+ccAwVIgUylTtqKYySx7AJzAh5xAa2qaD9FRGkCB8cPI/60LjneIAk2FU32BP4KkHteLIgyhNBx97JhuRvgVJeCztWR+dqRt4hVz1W/bREr7lu0osmtUfYffCBliRvQtqYIQd3wSlSP8Qdo2ZeEKxK6Jyit5zyCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nw5D6yfUvKyNSJmb1sjKkNDtJDMXxTIaIZTnrf5+Ytm+55jQKLZneBY6Odwony6SZlaGz/lO5aZyWBVgTPJW/H8VQxeSH20OrbeslAqDtV67WZjKA4WjH6Iaj8VsCzt/a9BBemCSYEX8ZPCVRVAB+9k0jXGFsoR4O/tjoV3dT42wFsbeeT/8PxNfoRVJ9iHiE8kZdZoWWVzdRs3d+xUjVnaywekPrNvtDvH9VqwJpI7OMXV87AQ2ZeLtgn5ZCB2xyuk0O1/86MfU/2HyEJL46EJKY/dYsvKxp1zSjfUJy4KFLtz7/MW2fVPcfeiqI9BiIWgnGj3zxpS3PtWBIUEYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TaVrJC4O7fZN3U7TQrQc49XE4zU5+SNuqUt6uDhei0=;
 b=VmYdogmzI1C/tNMm3PP/4DsNENn2twszIri0vbOh2wiZnX4lvgZemFUPeFTrZ6cnwXKBiMK970cycw/CWnd8vuVPxPQ9p4ntFRQQdSf+L1dqAYtXStZDkLcft7kap/R4bUUzW1eTJdXcTFQngEyqTGXH2vSSp1NUwIsWvdnC1ZIXiE6ASfGypSltRvH2DX8QtIJndLjma9B3Y37z9DpmTm8Wh0KI6Uw/LOafUsWuEYsBT7h+Kxgy5/msCKKK+UhXqsHsOti77nSX0vMTBJORsgqIGO2SVQylk4ad4blHJJT9yL3hRgZPQZt95pO+91adzDTWeY7zh0rvSi9YmUEYyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Tue, 5 Mar
 2024 07:10:21 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 5 Mar 2024 07:10:21 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v4 1/7] dt-bindings: crypto: starfive: Add jh8100 support
Date: Tue,  5 Mar 2024 15:10:00 +0800
Message-Id: <20240305071006.2181158-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
References: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: a05bb595-a644-4843-9ef5-08dc3ce351f6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bnvvexP9JT2iwhw6AxDKaHfg/nBnWga3odjMAav9lIx/zEc1oaElc2W8uFDEGhCN/9jioDmZBQiadxCp5Vcte4sjxnf2UnFkQk4zK6VtHXMTjRis/CDh9fcHom2mvexVsZuO/vpCPxSWR+pq7sxyf+4k82JInmtzogwNC3jEO48rvIeYxDF8aOJhXtWgn6AFdLjSRAevZN/7VQdfRHp5HbX1nBNZ1pm6oYgpIAI3UF5N7YBYIF7UxIwjBTusy1wMavDq78P/I6eRTgUSICBmHSA0BvG8gx0aSSgngWOOSK0mTqRi/zSF1MnQ8zDE8LycWJMZvAkQ5sizeMRAD7JH3JKKmzJGUsaQN75351Yie0fCgbyQUKAyZLA1yri6Kn3YtuF8NZhvJVYxos01J55hlz+HD9cO2ZAEGeSLdQ2E8GXjEdcJL9YXTsbSb55k9tgBkgx2fLpB3ea4oXxaaov/tEV0jCm8owpNeK2OeATtQbGnfvpKp9/Y2dM5AWAJfukjc4GSaToKkq/Qamux7YxQORWT1KbuZzOI9DKZbHMdtCJcvsc7uY2b6JGmqqkoO0yCR+DTfCA2L2uoui5I/x5y4rN+A1ixSPlOjWU2WComovXgWndjl4cIBDqP7cMcdl0wqmn9043wd4dHSQOiamAeSw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f1qUJSFn4Ak2Y6zJdkl/t5DS13786hgYJxGDg8i3uOb1iyA3tBZx6Eq408Zo?=
 =?us-ascii?Q?iiM/wN2gDZuwEoOEFGVnY+0l5Sf6wSSQRwdigNceh6wzIs6q8KBXnjx+FlJ1?=
 =?us-ascii?Q?R4i7snCdLxrM0SxOt1H42nI18aVC6kEk8zyrN4wIrOs+ky0VUbFLbCSjPv7l?=
 =?us-ascii?Q?iRRC/uxkag3Vn+3XbvglRdRZg23jMkegGMMkg0BEGvG/Gn6KT21LYOheStJJ?=
 =?us-ascii?Q?EB8guPZEiasGmaBWmbkvrOHHmyLLVovqALc7VKzdrDlMiwONpvfDgSMArE3B?=
 =?us-ascii?Q?Z0DPRreBu0tPplkwmDFYIh2h/GmJclsnjIiNB1q9eI3ks1b8lrChnHEXZdAv?=
 =?us-ascii?Q?QdrNEtBTcX8UynDR2llH0fjmu1zkXQ026W+kJUJEWcv91/XDYPDqtzP7lizv?=
 =?us-ascii?Q?jDi3Fveklf2ZgqafPXBQt0/rZYn3XP2tgbZQOEASQV2a3KXdSFh9p3XaRyAC?=
 =?us-ascii?Q?Tr/ze3Ot4cwsPjd9IwjlA1TflLHUVtdG0KxTXYX0j2uPairgdRLrb7w3QUAR?=
 =?us-ascii?Q?YRgiq+M+h92goBcREhrXttudHh4nWCjBzmOLRjx/qh5jXsv3VsKxNY1NYwsA?=
 =?us-ascii?Q?MeAc9nef4A7PX8L9qKazfeP1MmJ1qDDZjCOwBnI76wE9sNKeDS1u/3H5UP3L?=
 =?us-ascii?Q?fUssUL0JRTzPfu9cuBs+6vYEOvniF1iWElGZeEOAqYV9lBedNBopbuXMCjMH?=
 =?us-ascii?Q?McggLTx0y5f1IyfNePTsV+3PMvFSbt+f2uEEumia7h/i5lg4J6lKbN8rnPYT?=
 =?us-ascii?Q?Twkdr1ti+hzORJHAHnzBsnh+NNd/HDa9S8rlo/gqRXj85Jd+cnOTJZyUwETa?=
 =?us-ascii?Q?hHV3pvwBgspjL9hzcqLMtVd4B5nkOJR94eTpaNre8HN7fyOAq8V9sV9Ymd5S?=
 =?us-ascii?Q?D2yq8VtOFyDp/4AFiafss5jyGls/bseP9rt8CZb1v0u2OlZBXYBXO0pXhXDh?=
 =?us-ascii?Q?VNaR9KZe5emqKiFPEGqj1K8zbF0gLUP6e5vDCKEp4huFr8tRQKoNBN7nh7zP?=
 =?us-ascii?Q?hdU39+CBIfPffgFi0DdTi3A2//j/VVAmbiWm1SS5OGjJGrAi+lkfnj1UAY5Z?=
 =?us-ascii?Q?H0xbZJwlaSxVz3iqTnEQNMTg6ShiHrjDmtjdA8svKo/0lJts8jSvoCSP6f0w?=
 =?us-ascii?Q?ZGl9kE3XTyagjfrTUqRdr5uuwVxFe7OuGJgenMC+FxQtcUZguB3DX4BuEX+o?=
 =?us-ascii?Q?SiO9SiWTT1Ji9bYNpPSWgGqCteI6jnvQReRz0w3HSDcwvyJ6m7FtdJF6PeM8?=
 =?us-ascii?Q?vXu4MxiygrYIXeW1E6JjFYMOa8rCSKE0+dLIoWWLU6u9q5w2xjXf7IfDV6Y5?=
 =?us-ascii?Q?lqE+3Q8jBi1Nf6R8ZH49LaOvf6TekPSduh0VMgH31vklWHrVzltBusM18uDg?=
 =?us-ascii?Q?u76kw/J+q9rFBRqL/S/tazCAaIyirLQUxgOXAIBNdLaSGC93ofnkNKeFkQQh?=
 =?us-ascii?Q?PiNUntnGkX0iMQEpjp83dgnPPxzYaD1/Duaf3hpCpNcpjKbX9WlhhxxyGw3W?=
 =?us-ascii?Q?+2q6hU/yAq7rg0PhskC8DvpWwEFvcyBlbFZlh5MH5tifK0U84XP+H/y1EbkM?=
 =?us-ascii?Q?PIEravhDGM6OiBTC77FhDNAENALGDyoL11efhuOO4BSiv/5Dm6sU2FartLbM?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a05bb595-a644-4843-9ef5-08dc3ce351f6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:10:21.6233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xy7fBn6f80XcLe8S8Q71sjObMv3j0lwqQMsTukyK2pPcFEqRGDxdwgVAek69ndR32iQbRvc463fD8ah+O1CQjAyisPkXzFQwkfBT17tnAcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

Add compatible string and additional interrupt for StarFive JH8100
crypto engine.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../crypto/starfive,jh7110-crypto.yaml        | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
index 71a2876bd6e4..446764bc2ccc 100644
--- a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
+++ b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
@@ -12,7 +12,9 @@ maintainers:
 
 properties:
   compatible:
-    const: starfive,jh7110-crypto
+    enum:
+      - starfive,jh8100-crypto
+      - starfive,jh7110-crypto
 
   reg:
     maxItems: 1
@@ -28,7 +30,10 @@ properties:
       - const: ahb
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: SHA2 module irq
+      - description: SM3 module irq
 
   resets:
     maxItems: 1
@@ -54,6 +59,27 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: starfive,jh7110-crypto
+
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
+  - if:
+      properties:
+        compatible:
+          const: starfive,jh8100-crypto
+
+    then:
+      properties:
+        interrupts:
+          minItems: 2
+
 examples:
   - |
     crypto: crypto@16000000 {
-- 
2.34.1


