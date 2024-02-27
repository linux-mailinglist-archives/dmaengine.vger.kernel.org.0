Return-Path: <dmaengine+bounces-1125-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0087B869C59
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BC21C24AF7
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F31208CE;
	Tue, 27 Feb 2024 16:38:18 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D2B208A3;
	Tue, 27 Feb 2024 16:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051898; cv=fail; b=WB2NINGvVwxQC4+xqZYWn2V2HVZkB9opMeeIOyyKHZdzj5E6aDDW1dXarpZAHl8GlnMfHlN6Gc4TfeqjorUP274Nr3JWfbKbhAhAP6/BOBRRiHccMw9i5koAG4m+n54YSajv6iw+84hml3jhdqRTjHUfVTzDOLruZTfGMQ8m7yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051898; c=relaxed/simple;
	bh=wfVs5+YZnoQc8CcxqlenIofRy9YTq5OUy9r4NsL1wS0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gkmCecv++o9I0Xe/5WIelKNKXP2WG7kjOo82zIBga62sz4P7IStGWcZJl31vhykH2JhBS9n767Ex2JsIo7IdfzrNkqhJ/HAILUXdX8ngDmkhuZnKagi1bslJcL1alPQW1D2AaeQJ8rKF3vA4ed3mKrXMa6NETR9FzrUCQdvkfmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYNjhkqe88LsiEoGYWHeycnEZ0FlOs3kE6/CS+EXz4Yv6t6lhU22JcyOQwvhk8H2BowBRIwHgnpPpRbxHO7X6vmBQ2lWZiR2mtmwbWVsXzeTQHG3w/qWvdeyFHvwPbnSPjfzjC3arb/uHxNsWZTmdzPTevxR0zD+le1hXV554aA3hIbNTpqoIvOwiePYn+FPLCdYNILbAT5cX100B+WaTuhUwbYZhbmQuAcz3vLxhKLOAzFejKjlsingMqWomFWh3+twcDX2zXzwyfoPZuAWprVXU0pHke9UCR27dRDByhNrSqhr9g0AhP0C9hptD8woKy1rbBDa8SMOqyEtIl2IHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvkjuJQgBaQMbXcQsb5bU6na+3fU18CU/GW7PffI/30=;
 b=YmtRGkm1IlpHXhYwrn1G9UWBlPaFCbUiySsXux56mtkb4kiXsnMeKdk72dcD/JC/gzMcFtt+0jJpwvgKQdtvqyOHDf4BzDukcrEB3Pn2M11KA+GDIe1UIyJAACG3sqHCDILs3bKgV9ZjpIj+CsFRf/jXWXRbXd0LibzFqJ8FBt3GiG1WyphevYZJM48xf6r/6M+y7+jTOaDMp+drKpkHNjP1Fi1aLu6Vp/idEzC4aHVu+Tcefj4qnr5xhlnHZnB4q8IdrKBwImFCxkVuFu69ZnkP+nz9s5Y1ivZGcmZaKdmW3BJU2hxkCeNTc2nsGppgFYjCUOb0K/U5WvZ/sJe5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0685.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Tue, 27 Feb
 2024 16:38:08 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 27 Feb 2024 16:38:08 +0000
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
Subject: [PATCH v3 1/6] dt-bindings: crypto: starfive: Add jh8100 support
Date: Wed, 28 Feb 2024 00:37:53 +0800
Message-Id: <20240227163758.198133-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
References: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::16) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0685:EE_
X-MS-Office365-Filtering-Correlation-Id: 846691b7-858d-415d-22c9-08dc37b27a98
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NflUOejmdlGd0aPEjSgCH9n9XtaGaPWSeED4g/8XRaRSXGEOOFzeAfYO1OxRhqK0NBWmY5mlYqLOeuDHHXAAELMncEDYf2ze0pQyulAYlyN+1Ad0pOsYrbvmt3Uda8PW/ujL7FWE8b8meygN9hwpp1RkN39msoUqybGG7LPSnCEpeA4vUP/HEGxoi+DGDtcocuC5723wmmHf/CyiOGQ/PlwOJ3Mvyvl8d9R65oXZPs4BYFky7oSnYkQHGwUHB4cXxOik/y9sUfbFJ6knmrc0s5rs/ODhqMg/a6mHZBqmkIL/yvsM1oryT5vvNAThJqbRK29G48ROKy936UTJrRSuc01/v+9ylD/NemTT4PEGdl6jTUmD2mGq5cU4hmlx9q3TDFA0Lnk0sCatME9QgUw/d8fFKLQgPa1fI6WDrDq1DYBURpAVhdOvp+jwSpeMLoDQlkF8459Pl7wITUQGEafVDLjE9tyWV+v0bI7gmcn9ST/xMlS/dRpDQu+0y7FHyJLRVgNpp9nP75ri21iTurpxA+SzNaajoBYQR78X6oq4ACRLBzOtDqqYFJajEpwlDfu1uJJZEzYAz9bC4bO7Z9riHTBzOdJ02N60yOUodfBvzK7N0LUjHl+XLul9wStefRijNvTD568MPuyRZtTy4jQomQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EH2CV9SEOmj4/30CuCNEEkGB1+0zKllgLj0hJchCFWtc2BViJw5fLLmGYzJA?=
 =?us-ascii?Q?xqOQ3nwl2lhCN69pXaiX0dozt5K8UQVveHL9UshdklWSOE9zJq6ALp2/lNWk?=
 =?us-ascii?Q?/Zjp0CVF36g0S/j37IwUoBiYu6L2t3Nw4EM3FsBf2krbpqsLcCR+44qekIaC?=
 =?us-ascii?Q?SP+YbSZRUj+G2/rVyDVVwKTqjDbR8UAA+FodswuPwSjXAHeGwZc8WFdalOBp?=
 =?us-ascii?Q?lYgTDap1FB2GHmsAWv9V5v/W8CU0m20hw5Cn9lyvxMoEQQ7eV9mFxFG2BZQJ?=
 =?us-ascii?Q?cMCXQ1Hd6GlO+xmnlV5IwhfaJ/1x/CRfYnPTE5ViuH9kMov/tTP3kJYRSRZh?=
 =?us-ascii?Q?DacnKeV2Tp39I1OsOI1n6GHRErAmVG5uRyIlaMbqXj0XMNqcOZgq5xBn87s/?=
 =?us-ascii?Q?YJknWdgnAD0Z8JOCvLsaKnEtfa4QHZz+4aFdFZoP6oexWdYdWmiXYajYWa0y?=
 =?us-ascii?Q?f8yrisUtuja8z1L8OPqLoCkvzCkd0YEHZWTd00rhj9EvDKebUWPB6qgCh4wU?=
 =?us-ascii?Q?QeMHuKqfTWH7+Y2n2Qg7i7tJboZ5sd+MtOc1HTUGLlSxYjOLku63dau/FtJq?=
 =?us-ascii?Q?aiu6UV2uPjHBtdIAeAx95VtpAgOLvI5wRESPVNx281FwH0qac0ZsG4B8gKeY?=
 =?us-ascii?Q?NpJqkAchOxgD6WHqHlmdm2MXoooomUh7gk5OFv/XHhNTHpmdGlcijC/BpeDe?=
 =?us-ascii?Q?Crq9oQyZAjW8lSN7dszJXSyA0WB9nPlKJRWKrTCOvv+O5XNZI1wfMx5A5mwY?=
 =?us-ascii?Q?Hj/uz42vSOuH1I3grptioqYHsirA42Ody4fq9xMdirspP9FUedM0rgsMeMJM?=
 =?us-ascii?Q?vm0yDmSR1vuY3/IzLuxibg63MfGfsv8THmXcVtZx+w/FLzL7HSW8PbmEq7OG?=
 =?us-ascii?Q?ilOoEDtATI7U5LRW0fFOplwaashssiKd9PTl4aWk4jo33ZorfqZrP9zyfU9b?=
 =?us-ascii?Q?XtZ7dVZh1bh5fMDi7p45zaHg8uDC1+sD/hLov5u/qjIxxQiqdFzM+CCblQ/W?=
 =?us-ascii?Q?Wj7k+1GP3Ws86onOlaiksIk8lnu2k7KzvUl7+R/rEPTaWoCovDxaUQvx0Y9G?=
 =?us-ascii?Q?9yjyOBXi5oOuF0LuwqcV+yTfAL+SpZ2i8f0NpEVIz2/aKgK4HCZCeOLxvHzq?=
 =?us-ascii?Q?e78lClV7CzO/vT5j8/AqLcbwebDBZidxNTvjQtbranSC1qZUn7bqmCG+JPDt?=
 =?us-ascii?Q?W3+5glsJNVWMCXdQK6BwLf0iQepU0XCfFYdd7g4qI32Ebcu5xWTgeJICJvVb?=
 =?us-ascii?Q?RfvoZVed8UUYlGgYKKR7mqom9tfNiBUsIug9Jx8jD+OvuAzNFc+RSFAOCvfP?=
 =?us-ascii?Q?AToVUFFp0PihBssieFvIlRVKOUHK/26ikGbW282NPhEjcNldsJz0shZ7ryg5?=
 =?us-ascii?Q?c3rIRlNh479HS67AIcfLNkMfeZXqLP86ExrROj/jm1sdoR3tCoF7Gg81zL/R?=
 =?us-ascii?Q?LdwTNyvoiKP+ybMwv7+1i4RDeVBwl/FJUSYHGqKUd/UkbpK6yMMh7kcTJB8S?=
 =?us-ascii?Q?tHov3EQPWKhrUNjDohLMSx8TTImxNVa8p8aVovkrxhRlAYIIX5c29quLu8f/?=
 =?us-ascii?Q?kIQaCwn9A5DgNR5qqpcezp+fGtulNrG/AiZkTPwt4fdcCcd4NRrwIH7uyqlC?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846691b7-858d-415d-22c9-08dc37b27a98
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:38:08.1053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ycJ8qfjnjfOOVT4YkV+Pukbkr901ikG81JvRujFb8MDX++zvT652wJzFCGvsyuorZWtNJTIAACfJdp/3WlIeAwpDMiHnJjW3Tc1y+HD/9fk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0685

Add compatible string and additional interrupt for StarFive JH8100
crypto engine.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 .../crypto/starfive,jh7110-crypto.yaml        | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml b/Documentation/devicetree/bindings/crypto/starfive,jh7110-crypto.yaml
index 71a2876bd6e4..d44d77908966 100644
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
+          maxItems: 2
+
 examples:
   - |
     crypto: crypto@16000000 {
-- 
2.34.1


