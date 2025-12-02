Return-Path: <dmaengine+bounces-7475-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1CAC9D5E6
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 00:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F17CE34AA14
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 23:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE893101A2;
	Tue,  2 Dec 2025 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="kG33xDn7"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010020.outbound.protection.outlook.com [52.101.46.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3D3314B77;
	Tue,  2 Dec 2025 23:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719275; cv=fail; b=l8ResIwXnIonqOTbgoL68Llynh6yhfafGUd4eejPU4/akinqOdDMZJSasmH33Xy6yX5IQdqEaA16MVdG1DNcw+mhg/dwp4bMXIVYe0X44ngScQN9mOFCmlTfyDp2guhsEyTTZWkPuFKXQk4pRVKhuhJJclH4P0NjASztT85Yjvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719275; c=relaxed/simple;
	bh=/7zGPUppmwNLvT8obaj+jMQrrc2jUNDyWGjGcnK8mNU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FnMKGmh0CsrWNvg0BRuGHluRbmU1FeLJaw82UQSyiwYrD/Q+tjkTPakOwxvJdxtQWF9gjOvtT+lXTN/6zuU9XAEkDESsDX6+5GYyvFdp03v9BCeiZdjDOCf7LDOqNMhJSsW6nbPUYy7fDBm7fyL+vv6+NBLxzXUjMKAvEaaI3JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=kG33xDn7; arc=fail smtp.client-ip=52.101.46.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CgHnLwPQmNpfqr4aDBkMvsfmzZtopDZcA3ESzYiN00uRJo3PvdDvMiBlcYuN1mM6RSKtycX+duYCG7zjZAPcoIyIn7UqgA42RgKwiz/b8si9WyjrqygBcGYNymjgsQESOUqrwc3nebtJXdF81IKA+ZwI2MSkRh/xxIpgGzTbEeDGCKoCV172I+xezUUV4vZcr3bNtMrgs0OfSObB56bjfrUBKA6UAwP+QZDVF1UeLgTreLIrQ8VvSm1Q/0Gd1SbV7KfryPk2C5BgE20PojX9WfwLLqT1YQ+U9wXk2u+p3+JTvsq3FR+ZDpNhRE8e1xJU96ZvWbeFXN8zD9QTHkKE+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEMntJxkL09aX+2zsDaqolzhP0IoW2iNRLLH2BKiPf8=;
 b=iJaLLDGs3IsijkI8RirJwtG5uZLLW03AsW49S1rFVYyy8xWShiPYAsgAkpIwbfhWmu6lxpfd0gFwsQliJV56QCd58dqrGhAbyFT9AaAsgap39L7CUtGOCA4ppxVSUbDy/oRBJJIb30K7KyPmFclu3I6TdOYBmvC2k9YNcn3aOKpcEC59uhonnCQbZ4xWZTC060YbzZljkVpaZ8AG2mZQivVj4vX2K96Rw4tDE0G/iSfyZTErzXW4QUry8b3I+vHW+dRtRawoPES7BG0ROBu6LaNpvP8jeNW/Qb4KNxJBtNsGqar7OsmtfVXObk0aVi9cWHQKwB1ZRiug+SZUbPYG6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEMntJxkL09aX+2zsDaqolzhP0IoW2iNRLLH2BKiPf8=;
 b=kG33xDn748a374gmS1g1nZE42Kseof7DHOceEzRtxg4EmMZ97aBDe7az39/YZLmBK8qjp32YUeH5R1X9laRYKStx3PmhRJrYwicx8j8mG1x25atBHpztjX7tm9AOEkH/S7EPHF9LrxqioFPVBAKX9t3NV4H+7eMW43OQmb+E9UZBJqhSKM2Jl4aSjsz0AEVYbEBy9zgdHPYzA66Iovq2hYEHxfaPRQHXdgDXQUg+X20VoOtldUEyptgboYpqO4M+wSldHWKbZjNAvPD86yiUOAp7neMwZsN3x4lPYGTH1t9LdB56BKxG2xbn8n4Y3m4qNvrA5UjcJ5w3b1dHM69iRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA2PR03MB5689.namprd03.prod.outlook.com (2603:10b6:806:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 23:47:52 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 23:47:52 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 2/3] dt-bindings: dma: snps,dw-axi-dmac: add dma-coherent property
Date: Wed,  3 Dec 2025 07:47:34 +0800
Message-ID: <025381792a014844a1e7121f11836ab1010cba89.1764717960.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764717960.git.khairul.anuar.romli@altera.com>
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA2PR03MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: f30aede2-dd49-40a4-65c1-08de31fd34ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?59h9qJHAgWXilwUEtNwIfeDwvm55CComZNCFx4mA74sz3ubZIdxRR799n++8?=
 =?us-ascii?Q?KYX4eq/tnECagiO+UdhDburOSde0hwaFdn8nLthiakup8tWxrUJvOW35Wc2N?=
 =?us-ascii?Q?7mwctJPBXgZ6FTZOsNAr3Nzc3uixUDAQzx4mrSB4KvjXlkcfgdMJeGo9irOc?=
 =?us-ascii?Q?yXBKkoMBbyL24bD/hu1hUUdIYu6+XPQCFxUb/YzFbvvFrOBi0DRviFQTQM8E?=
 =?us-ascii?Q?Q24PT7SxIDX41rursA29n3oS34Mdy8nJAUDXq/QL6v8W4/2zWeJXfW7uFs1G?=
 =?us-ascii?Q?j2y+qsFvgVP/SH685GyXxurSN36wPsMF/DKNvuALvhU3JSrIwzv3Iv8rE+6E?=
 =?us-ascii?Q?1FI12XF6/QdK9LupA/ZVXhjck43ilyHEw1BGTLLrlev6BbOYeNN4kNsk30S2?=
 =?us-ascii?Q?YAXn4WzTcLetzsmPT27Jx55A+Tnnf0VSyM5SEOreffBaVxA2gXupzAvICAuU?=
 =?us-ascii?Q?w3/qnuoLhDEWZhOBiMpHVPFnkFU/nsF/qzh7HMtOtz6hqaw40BoU9+I6U3+z?=
 =?us-ascii?Q?aSY5rPg1gd+ABEQpjkHLsIfiwBvFeDQ33jPXxK3RyNOFK8gKGEN/uZaWhNzL?=
 =?us-ascii?Q?g4iSSFxlGNuSiLRGYeD6CvK8ITwP72xDBVE/PdA01QXwGfHNqq0vSi+ub9Ap?=
 =?us-ascii?Q?uwuWJCjKH0nA7BfIRm1uZIGz6OxzAZj71EiS0uB8Nvv5ljROZGF49F+STxHM?=
 =?us-ascii?Q?qUmhGbtSVQ8D9ffrl5+3gNmywPzj1EZrDp9O+KLNtOoJzUbIQGte0x11ckmJ?=
 =?us-ascii?Q?pRPFnj9e5r80koCZYtNsBbxF4csgYRbWF4UGAMKqbp3tk6nW+7BDa+fNxOoo?=
 =?us-ascii?Q?62PGJOMYWVmusWpr/cvYbdY3Y/qT0JL+eH/DbEGTIPrO1YethE9l9SSC7puF?=
 =?us-ascii?Q?L3O1d4xEHs/N9ZSDBR8YGa0vf6lKMXUmUUl8ELSOYQ21tkDT/OVpuq1sDygi?=
 =?us-ascii?Q?6D99AR8mFARkGIH0ZwApkDz1kr5jT96hiiB/yQ8+0beUO7DmuE+LWFObRVLd?=
 =?us-ascii?Q?M25FXFCiIVT5whAPSCykPoPpXrtVh3bWaf0Ii2BU7Wuu+eFXd91AudkAZqNv?=
 =?us-ascii?Q?GLmeGEjvHVj2j4eyg2Lr5RdtpvFP6QLgy5s9506rnKBQX3DiXZozKKFkFj1O?=
 =?us-ascii?Q?y++y0H9LIEMiKlqIYkFgebQjcrs/qzn22LM87oDtStpjD+eGKOOPnePg27Tc?=
 =?us-ascii?Q?TTlfTmRcDwBPJnRMGHZpgtY7ABKozfKq8kJ0DcczOhUdsK751CYGQ0w1wUHV?=
 =?us-ascii?Q?tteJBFRFNs6eNh13LVCohWg06EZitC3RhOivxVfkxKDUebdm+9ucx8iK91v/?=
 =?us-ascii?Q?FOsXxcoZBlBwhXvPjNpruVcOxVyKfLHZ0x6F8Z4upcTyJwyEyyx7gJubIWrp?=
 =?us-ascii?Q?9vL52XJWBQ6Nod+fZxtuhy2YD2Nhu+naYTumJwFO5QSHR48yL0o1dO9joPLc?=
 =?us-ascii?Q?ElRqUJWDVVnM/RUuQTuxVDayG17JFC7s+3nzpn+5a4N5Xne6WsffD1RcMvzj?=
 =?us-ascii?Q?xyLSxwhY66W/h9s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uD8EpcVUfszSw4Zx7eE4obud6o3tAbdiSb1Mk36ISDT5mwoium6+5VGT0jRf?=
 =?us-ascii?Q?Pj7lp/yt4vZkH75/2riKU5Xo0EreGQhOf7eE067unYI2rDp4m3WFzmfLBsyK?=
 =?us-ascii?Q?EAZinrueJF6PI1NA6aWpkTZrYz328QHfZmDYe2RO8TQwoKtPEdENBA80SnjN?=
 =?us-ascii?Q?NdyFSTLhaAI5tQSZYKt7t9Fd+lbjchGdERVYaw+eWJp3Rp2pqhKOEJ3Yi9VL?=
 =?us-ascii?Q?lf5hLfC9Lv23QUEGMCFvcqGj0Fpggg9hNmuNfJeiq3WvOugYoyh/vHuFuMEJ?=
 =?us-ascii?Q?hDk5Dr7eAv6dLmM1faOfVpQkqgrTlX4LVsyRUWvt6zdlARVSaudiucYqmS5M?=
 =?us-ascii?Q?hcX68Ex8Vbmb28JuVAW/rv8HzjMOTrz/80F4BwQUpvFPUp4OeTDNQim67KCC?=
 =?us-ascii?Q?sLoW4ynuOV3NRlOaFgNtUpintB6jRs02LphfrN5myzCsMWwMW9SpZbbvaNAn?=
 =?us-ascii?Q?itoHRiOVnanNAXpCfQxnS2uwjbzZVWiI0bWcMJOFpf6xmCznpyqVn/cS8qSc?=
 =?us-ascii?Q?eCXMqL7A8AYLnergnoW1rc1BgFIAeC8JrPd7TQj7oIVzQ/VD6byVWHtxvpHl?=
 =?us-ascii?Q?08ARXnQwYa2JbetI+Lae6pX98nFvBddHd3oue38uEo/WspnsvV4T6sJZyedQ?=
 =?us-ascii?Q?v+BQjVE5lCjlS4qxVNSjg2b/j/CoyiNgq3y9lTu7On4cui+ALbNfnjzR10sq?=
 =?us-ascii?Q?0b7gZRT3kZCl/3wODa6r6s2xItnaXwZAoHLywq+qHd1iKMuRUivrK9N5h76m?=
 =?us-ascii?Q?EN1cf+vzCHOgy9gFuRHn05uEKE+tfSkxbMPMkF5MS3Jn4tqy6Snpl2xsnRhb?=
 =?us-ascii?Q?gA0WI2t+WtxnYq1dkZUcNrHW6a34gPVEi7j2+JcCkA1LiNIHz/sflcdLKNzs?=
 =?us-ascii?Q?8nqRI81Vq/dcFdSZGayvfpT7TLuHcP26oVNWjl3poSjqq7AipmXXeAnGdO74?=
 =?us-ascii?Q?oolehyPyzUaCS+Av8eyv9UNH5L+gTjShqOD53oSErsHhw/uVOE4gPzES6WRP?=
 =?us-ascii?Q?/JHlVpvqCVqyPDzU+bM2hnY8jNWVPbzTNePKNlVl3MZ0ISeEDIyYucHrZ8oS?=
 =?us-ascii?Q?oi9gIrQO9j5E1o03NyPSli1R6Rogi3mQYwYxILSXCYOI/FOfQya/Z493ueET?=
 =?us-ascii?Q?nN1rv0TZM1x7mcveTaJIYKDH84II7jVeqXpY5dWhiILAgsI7pdAYRU3XxCqo?=
 =?us-ascii?Q?QRxP4nNHhReNXk6nFF6HdNoaP7WkQL1VOAJ5Sx93J/8uvuwyq2P/iqxSwuWs?=
 =?us-ascii?Q?mfR3iVWyvQUrmf/ufbnhsIzkas8qNMNl8Sw0Wr76FGfrUHKwdwYn4YK6kZcE?=
 =?us-ascii?Q?/F617pnC72OKT0dFJTSyA9Stdvjnu1aqXBHNJAgWLS6HUSW6l2gfULxvS4lx?=
 =?us-ascii?Q?qIEBhgnY6FDc8aWHjZc9tdInWy4MMPpSEg1mqzM0Vkusn366xNuDrXzXK4BL?=
 =?us-ascii?Q?THPcWqLtqEw3m9Utgld/g7XckkKQro74Se2rK+0iR8h+d0G3UjImZOyXEPQd?=
 =?us-ascii?Q?nLiAK2vMPjOM0Sb7jPzs/WRSEnS2f/Y4aG+tiJF2sjT2clRFipPniKuJU4pu?=
 =?us-ascii?Q?oWHR5O1mXFpUUGAWhSSngxzHb+AXmGmjvSmq6+Bh+nw3yyqwbDtP9Vqkup3O?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30aede2-dd49-40a4-65c1-08de31fd34ff
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 23:47:52.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNIeTKAa1nH7uddok7X5G4Tt8vFGVcyWbAiPAI9oOa00eKyZgqT1mT0ZiIVHf89avhOkleC+3SLW3DulIbFWg4xKux8z5sDLZR1jI0qP3VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5689

The Synopsys DesignWare AXI DMA Controller on Agilex5, the controller
operates on a cache-coherent AXI interface, where DMA transactions are
automatically kept coherent with the CPU caches. In previous generations
SoC (Stratix10 and Agilex) the interconnect was non-coherent, hence there
is no need for dma-coherent property to be presence. In Agilex 5, the
architecture has changed. It  introduced a coherent interconnect that
supports cache-coherent DMA.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
        - Rephrase commit message to describe why the property is needed now
          and was not needed previously.
        - Remove redundant statement.
---
 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
index a393a33c8908..eb67348b4ab1 100644
--- a/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
+++ b/Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml
@@ -64,6 +64,8 @@ properties:
 
   dma-noncoherent: true
 
+  dma-coherent: true
+
   resets:
     minItems: 1
     maxItems: 2
-- 
2.43.7


