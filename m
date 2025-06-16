Return-Path: <dmaengine+bounces-5492-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E52ADB440
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 16:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585E1188C308
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564D21CC74;
	Mon, 16 Jun 2025 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="GLFWTMZ+"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010007.outbound.protection.outlook.com [52.101.61.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A8520C00C;
	Mon, 16 Jun 2025 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084912; cv=fail; b=afmHYoEhbyET7U63Sb5xHUSX97tMqGQl13ZA2/hqYVc722CPqY/kvSvzHQrA2SNbNaxjt1EFk4p+oplIR+MuPArvkvyafvULEW2R038DhWzjqFJW97tKAP7nYX8Pga7MJZjmLCov+PWG+s1XwhEYTplkT67ll/1mx1dUoZvijok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084912; c=relaxed/simple;
	bh=7+M8VIpe7BNEhY8Fws3P7AsbFSNlv/IYhvsxkhSVEvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8lOoPsRPlycethbLM4zEYqByrtWKH3cLV0KyhZp35B7z+EXES46FAwSjl7kZWKWBC0DcdbGPseJOpjkMyHJVx2UOYxFdm9T+wpvzHDFD9+cQLNUH7G+NUNQ5ZJS1pQLhXX6hSLN1MhtD0L9/QH9vTAVtqIvvAj860+46c8kWpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=GLFWTMZ+; arc=fail smtp.client-ip=52.101.61.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjG6uQ4/6kzLxfF20H6yKSwA2a8ItKElfK74gurbJqgWRQhRFmo+Sy2nJzaeVYgveg9A51RUB/UqRoD5CRxYIYDiZ5QDnSUS6v4RS6rIQOxdqe5g2bOdgL71NF9WrtY3zfPHZ9aoQzF8Ew1mMsW8nR6EZIryrmysdTP+fJ/vzTkJAmTm4uxHbDdu41ebAeh8KiSXkrDxgM2YM/VuKUoh2SSvjHgLz8cLWYA7LVGMACdSp6+leh3sNA3e6GFVfjTyO6I9JYExXbePC/+K/jlwYa89Y+YiV15iSFiYd8oTGJEppEhyZHVNDFRZs4K0H0aIuygrtVJi6BYwdhuoQyrVAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2KG1yPnUYLTj7Q4FEDXtugyvdqH3ixK4FiYSzV0b6A0=;
 b=Cd1OJ0wpsOC9RuJZK4krKW31o86DqZnyS1sQYgiexVpl8jX4X3mHWAZOjN5LhUh/rbixI1XcmZJvHTLtKwwndLs5+MgUsx/OrMM5DIBGgrJOLFgI7ZxUZ5R/lSD3Rmr3WGcO/b4ccIsMjSGXJxSVqkIEzQGgS3f7868VDEXb8Hs5WEy5A7rMO781dTIbDGrepkOpEDltFeGKM6MlpDqXD38Nt6ae4wfJ1CNve1CiBH4+fDwdrVJhQumWzgb8536khslm1mzuQK+3ekwZhDgg5InFJxMmFcWOy7JhxdScOIV1nJ3Ut2yudKAlhXo20Ls2dFpoOEipceGUmguoRkI7MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2KG1yPnUYLTj7Q4FEDXtugyvdqH3ixK4FiYSzV0b6A0=;
 b=GLFWTMZ+VEvLp0gcFvWib9thCzDqvQ9dfqOFIPtaNkXzf2eiSKGIZl/LaxV0bgn/RWKfzeS92MZKVZ34OYrHESKiCPiG8uy4Qv6JLD4q3mdnvDf2/jVRhORELOpQwtWe9SJzwwCYfdZ8OvFTT94ukWgyM+/CPqfE/BL+pIoLHXNWYkGnjtmhcqQSdSMX+jx86Z1O+oskO6gPaptprM3NcNzcBblq0/QDJLJ3c4cTAE86CPYQD8Hupwj6nDhcFf42EzlDiKuMCDqnYa+x9u6f525gBYw4CE5EC1NlMRXjfEitY/eN9zGhHnVubQ0nAICteQMYo9Lx68dUboeGM9Ey5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 14:41:47 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:41:47 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH v3 2/4] dt-bindings: mtd: cadence: Add iommus and dma-coherent properties
Date: Mon, 16 Jun 2025 22:40:46 +0800
Message-ID: <8787d4b22c801a18662e32e247665c2d3dcb0410.1750084527.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1750084527.git.adrianhoyin.ng@altera.com>
References: <cover.1750084527.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 63d18ca0-cef1-4b05-1098-08ddace3ebfa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hTUF9L60RCK52nQA03A1ZMT67Hym8bE1H8txPz1D7tFXQaiwkyeCPkaylArM?=
 =?us-ascii?Q?uv7GDLUqq7zfxfDVQxBY6cVqqS/aBxE1SYYDazn1yRPnAosMYunzB+tOFd6p?=
 =?us-ascii?Q?nPcYIb+lmWRZ1c2u/PSdQbm7KLQIvRpGR3f8wpF4NhFblOw99Q0Lll3eVYCV?=
 =?us-ascii?Q?99Wy4og1V6dA1Ii+A1QRg8WA9baq/EGW1WhvNol+qigjKIb1X2cR620OViTC?=
 =?us-ascii?Q?k5tOaPJ7ahikCG+GpVMZeY5JXnzSSf7mgm3WYhLCt31Jlh+OV3Sd7zAZIoHU?=
 =?us-ascii?Q?HWeK9WQeycTnjnaJZMFU8JzRr+vG4kLLv++OhUcHAKAJ7Ce7VTRDgK2c9rFU?=
 =?us-ascii?Q?rEZXeoJjIjdLk3br8NaMYmqeyeB281pp/Y53jm0Oh+/yVjcKB35+4tVanfo+?=
 =?us-ascii?Q?ZGfLfu9kFhJZOM9qFEyuJRdSV9glpqqyCzHJC0RdlILwQHvJt3LIifj8exbk?=
 =?us-ascii?Q?OkvCL+3sIB7QHQpBokyZgbVIVKwhj8W+6baCp4bdnAIgYb9DktPDo3w9OnGe?=
 =?us-ascii?Q?Ko/j5leVofJ0xNDJgtlsbS70YpaH4jc0dyGtyRUmfxYUcWv4IesqPE/IXzVj?=
 =?us-ascii?Q?xvX79Q6Ca6lwwnx0UxKtblxnGzA/dF4tBUN1tVkEztfzNU5aaoAnxq8Bh6RW?=
 =?us-ascii?Q?/VDyNCD4uVPtd657QAotYoNe90fDjjYqQRLAZtNtJ3pqI9PheKIEy2Vtfb2/?=
 =?us-ascii?Q?6+6aqmUoMq3m3z0Fj+2qEZ0b7ZG1obEXNV0HqmwP1vXLkajkXixs7narcSRI?=
 =?us-ascii?Q?0P68s/+6/06eWGNLlrijfh/MlpWu91lNpI6ilQcPd/ULTWmNeACELrNZMMwv?=
 =?us-ascii?Q?qsE82CMti7qshz0WibiTGSAaTXF6qLhoRrL7ulZHSKPm0fjLlCwLeGNjaACc?=
 =?us-ascii?Q?hvyA/BJxAOAy+0QOcYga5mKbR4hOjAMJwOjSrCIvB1La8re81tnyOn0cdkis?=
 =?us-ascii?Q?MVvJKentIfu6588PVYaFmsk8YebEPEd/I382SGihl4I639buhusPeXzjUSfY?=
 =?us-ascii?Q?C3EMXE+wq4DYPu1PKj91ulQZNG+G/DzHpxhbyuDDUbmFLbPfeFCSfBLgA+Bm?=
 =?us-ascii?Q?bB7/pRLB8PMEtssXq9b5sqhJt7Be39T4tcnOCJgXgzPbpBF+pP6GjyNuKPXL?=
 =?us-ascii?Q?MwaI6W2H4vsDenyACIX+CUoj7BBjd5APt7ZHX/+kbNT6ROSreFW3RisnTyPT?=
 =?us-ascii?Q?cHQjPndczaarvcR3qCWPi2ElFd9IXmG68Xrd5ykhRgL0FzEH6c6iwu11jYSg?=
 =?us-ascii?Q?0qnentBG2WkSoHLOEkfgnflKmZ4sOXrs1WcPcIwPThvus12Kj36BWcQEjcjE?=
 =?us-ascii?Q?9Wbj9AMQQXZ+IU2h+U7g5+uLC7xnAPwDdoZLZ2DXsDLdNMi9A/FUkGcoZvVx?=
 =?us-ascii?Q?ZmRH31/EG/CydKpTvwTvUW/fu8Ym7H7yidg8I7n/fd+85/gE9XINTs5Ve6j4?=
 =?us-ascii?Q?B8s/g37q8Ig=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzdmnX9MbXU/kiY6gRGF+dvT09e04lbEVePrEZ0tIL0hbJw87bvoEqLBWrBr?=
 =?us-ascii?Q?4/x+HVnJLUHxKrqESM9t1a1wZJFdP61e12Lf7Pte2FTuR46PnGOPDoBwqDhH?=
 =?us-ascii?Q?uRGoKwVMbyWmEOXDt37cyWfGNa6hZ979S86fBTsKF6uf579rGKez9lwhD4+4?=
 =?us-ascii?Q?lSHSwfyaPy53DdeiM9n233EBWNL5kh+SMVz/ftYVNGmf2+lie6gJX+hEMbHm?=
 =?us-ascii?Q?VYEsANk+Denw6+Y20LWb2hp9FPh7ERx2O7g/BnVieZFT45xuA/SrGtbwRwcv?=
 =?us-ascii?Q?rHBaq9s7ykBWmlWy+2jWDwWOrp28QUXMyN5YH4P1qT8A93JogCBMVTkiwh81?=
 =?us-ascii?Q?zU5ZiA1Qmz+pFIunnHyi30jZgfavobKBddy5Q6AckVlKZI77aeNFnuCjIc1h?=
 =?us-ascii?Q?TcZhkEUUogo29ge/wSn4ID6tLmWsmx2M1iO66BHCDV99r78gJBQyGdFbIYWQ?=
 =?us-ascii?Q?Owt/VFaqSwJZYkvg+tW5MY1KkoZU7qQOVOSkQFKNnWckzruTbeeSClLcRaHE?=
 =?us-ascii?Q?jgxWpCE996ORXYXFetpA4+kyuysGby5L8UQFM7RdQcJ5uyBmJeWjFGL4t1ue?=
 =?us-ascii?Q?7YazDPdtd33rTU0Rl+vPNI12hJ8v9/LS2MW9x5R7Q1aHT1F9uUhfkw1nVmI4?=
 =?us-ascii?Q?Q+PHe7UiUe01hOZ9x7V8tdY1PBCJZDTajl+JYBwTaPow7BGXQ1XaoYfqc+Q0?=
 =?us-ascii?Q?RZDar3O+JT7zEAHtPP0o/QcFbYb35lBPR9Cob4ivE+oaszw3JFyr5F4U/4T0?=
 =?us-ascii?Q?hJu3Cb+NxON6GlcaqBmZUgT0OwxBpKa1pYAGDYM+jsyNLKrD4CQwbopMIg5/?=
 =?us-ascii?Q?ebnHoXdnjS2FrFofNvczCrhau95O/202UWsbjeT23ZEvH1HQmYXjcJRtHDg1?=
 =?us-ascii?Q?HG+MMuX7Rsv5shAj9hXN+LsoWg1cRrqgQoZG4Tb3pcNcibpUZSUmyDAEp6kk?=
 =?us-ascii?Q?XlgLN3fLqniq1JszqC65IgNnvcqXrWW0dYJ3rPHQiBfxO+51mUDLE8qAKRGU?=
 =?us-ascii?Q?F32qNJbj/tK8Jx1Xia0AUjoGKpeExUhv/mPIQF2CDP1dVC9rXckYcmy0KhJz?=
 =?us-ascii?Q?KR/L3r/e32ghcZB/YVtVm/Vp66lFZ8Z9ru9uEF73Gnq5E7rPng1FLlNbuY/6?=
 =?us-ascii?Q?eAbsUJusGszUlp+MFDz7BNAFFpHYIezytnk29fWp1784Ix9jUsxPd2/86EFr?=
 =?us-ascii?Q?/VcFaeRYTNfPllcqZPPjxE8chwiVF5ei86Z2MXeS1xMjBEWIgxL09UVAC3D5?=
 =?us-ascii?Q?lbxa6EZqZYnCICSmSOOMjhUC/IEiKtqcesPq6f2kwRhFDMQAW7vNGTlw3SK5?=
 =?us-ascii?Q?Id0dxrUvmFkaINKGWKmfk5dwB+q2A8zAhG7jlhGHkqOyJ/+mTazFXO+GYW1F?=
 =?us-ascii?Q?QQZHXwZmJebMjEEzRJ5rcXU4q35yWamHlntCa5leJJHXZM7oIwWLygQlqtXm?=
 =?us-ascii?Q?tpzeTkc1BO29OOHNVEPD3R9KLZWesz7W3qNdRhwPFNzugmlSnPskIwq4Bttz?=
 =?us-ascii?Q?i19CyEY7PONmhyWxmlUYFROnyU0HdrmoKe3Ytm9y+xrD4wcJ7ozWIE4Pyf9I?=
 =?us-ascii?Q?ulPBqJL5MrWb2kVPHiKYAanpVL67aJdmCFbFOHJtCgYITpjHu5gPf7SphcYY?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d18ca0-cef1-4b05-1098-08ddace3ebfa
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:41:47.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tl+Dj5qjnscZMO+ID4ikzyYOSl7EYlwN2PRXUCzzCNiaeaPbrUqh+RNB5f58Wqb5EBy5CzdM7uPwMHqd9CbEq5BLQy5Xa94Q1GCtp45Mcbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Update bindings to include iommus and dma-coherent as an optional
properties.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index e1f4d7c35a88..367257a227b1 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,11 @@ properties:
   dmas:
     maxItems: 1
 
+  dma-coherent: true
+
+  iommus:
+    maxItems: 1
+
   cdns,board-delay-ps:
     description: |
       Estimated Board delay. The value includes the total round trip
-- 
2.49.GIT


