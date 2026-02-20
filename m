Return-Path: <dmaengine+bounces-8996-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIycB5TDmGl/LwMAu9opvQ
	(envelope-from <dmaengine+bounces-8996-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:27:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6916A9D8
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 21:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEE603016938
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D172EBBA4;
	Fri, 20 Feb 2026 20:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UGAGX1r8"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013009.outbound.protection.outlook.com [40.107.159.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEED2DC349;
	Fri, 20 Feb 2026 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771619214; cv=fail; b=qrKrvkylOLWWkGawUi+niBi0uSIhNQAw4wm1fyI9qt2JSymvcqFOiFGQE8ufbwjBcDeLSFY29xh4LxXip+2nQX4qskhotA+lBfpSvhQF9tx/OwPJNpj/65l7Yskw4Auuj3PRC1mKJXf1NqwgoBvdliaH6a9cdKbwKxnKnTXyQuM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771619214; c=relaxed/simple;
	bh=SsOkqmWXBq816cLc2GnDiAWrDxk/dKCNwf5Zpbvy8k4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lwr5S6/75q177gXaq2uDU8Ci85QTegMVo2R3pK0ykIdc+UHBCIFDz8cm6RcGkwo07yfBEIXTPo1oxqb3bpaKXTVcitMF842BTOvnrnlpgAv3QECxnf/piaK3mQHyy4n3e3uzuf7Vx6ajLY81Ty/OZvhvBlK0koCopTYRnqH3MUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UGAGX1r8; arc=fail smtp.client-ip=40.107.159.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdxKm/kUgCiYZLBAw9NtBtr3O84aFxCoeQolvVT8jSbRrNtIsJi88xNZd5FGlV79RGg25ubD+PUOx9xj3+rPDt3iHKgkLFe505y1uWLaNoutKiwTczDKJ5uH9NXcplroGfEO2bQ+Ewk8UDu40MgumK027ybBPEfPe6vAy8E3a5sY25eHMgM9AdtW/wDza4i8qIJrxX3PsVXuQYhKAEsMmImkLLBhXy23lb2wTinO8rJoMDazQTNI/Sd6R1GV3zOYM7rTYRMl6IG8qhuY2pijl6VGZCByoljYUoJBxURq7/onUAQ1m7lAGLga+LaBjhGV7WW6WVyywqMvADrB/31IBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRPC+5qgTy6+za2BO+lZHzKVx3yJtSOV18AXib5eWLY=;
 b=u/KTOWlfNCWNFW/RGChazqFeTjmODn9i5tfhjM75omNKn4Fvs0aPp+bmndUlJGNt54Kv2YVqBNeg+yImxt4l8X2H42TBLNTFgclTtKKcYSsouLJ3i9VMbcZXioN9sUp9Hm3RcWOPNxRQUXsj5rgBNERRyD8atMZ+/TK5l+Jao3TASDbXuRb+nRtKdVPNXO5GD1pEJtG5k8NL7jEQY9J8PRbKUZUBAKmSJngvxtVcQxYu8kOs+hZ6gA3InvgfGyZCH7yfPxjgyByuKUHO8yQWmOC4Cmlq2dStzZJJcTM0+y3dV59qteys79bd6RiDD4h+9EuwXFb+xZYGN1VcdsS/GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRPC+5qgTy6+za2BO+lZHzKVx3yJtSOV18AXib5eWLY=;
 b=UGAGX1r8Dt7BH+/dib1ddOg48lHqvcz1LqelTfGbfB15y5tH30RrN0y1s7AY4EZIRdPYnW5YgFgulFA3OJ5oJJPZg//j6sChzOXle5NJ/BdB/82krT/TvZfJuKZzWtUsmiH0//Ss02noyZkf+76FcHy+nQo1y28RR0T+82Z9Yqrkm6YUzuCzpd8dANrmFuJaUDoI4YkzmVA0V1aiwIRG7JCZBrZnpFClUHlCv77OpoQhFwwP/OxRsjNxfSy9lRSvq0MqHTK2qKGn+lFucYU4LSsytMefWIT9HLMibMV54mczyT2p9s5dGPrZSQ4o/sW3hq+5vbq+GpEStMrqGp+usA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 20:26:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 20:26:50 +0000
Date: Fri, 20 Feb 2026 15:26:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Max Hsu <max.hsu@sifive.com>
Cc: Paul Walmsley <pjw@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Green Wan <green.wan@sifive.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Palmer Debbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/5] dmaengine: sf-pdma: fix race between done and error
 interrupts
Message-ID: <aZjDgWHD5cEXPNg4@lizhi-Precision-Tower-5810>
References: <20260221-pdma-v1-0-838d929c2326@sifive.com>
 <20260221-pdma-v1-2-838d929c2326@sifive.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221-pdma-v1-2-838d929c2326@sifive.com>
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM0PR04MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0fd9c5-61b2-40a3-1628-08de70be6092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|19092799006|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HjH5awddP7mRkO98Q3r+2c2N28pVD2m0swy91/a+4aaSHj8Qwdw0AaJSvx4d?=
 =?us-ascii?Q?Q7fxU/Ug2Wlr8rGK/oRm4MGg9fgfZq8wj/nG+4cj4+LDpuOB8hpGVXGf8Zzd?=
 =?us-ascii?Q?ZPPiMDnfZR/m0O1zx6Hc3uRfcz+LUmze/tKFRn0J6loUbDkLWrwLsM06b4Pe?=
 =?us-ascii?Q?8DDMKOdTMzwn3F1eOvY77tjIarpJi2z86Q99V34gTxm9diHDoBB2LxvGUOYQ?=
 =?us-ascii?Q?7UUpUgOjf3VtqBBK9tOphgNesHBD4HHS0dzdxBLthSCGYAQUUAIfwL6s/Voy?=
 =?us-ascii?Q?/NlLbGH2Eq2MpqHD4SMbRzzlQJvHhC0rR1YTb/IjjueU2qpBol0bMfy/cZSX?=
 =?us-ascii?Q?i3X/p6rP06De6vxREqE+fCTRB0bwzw0MjWjC0ky+68FT1JLFkNfFs4QikOVq?=
 =?us-ascii?Q?xlfq/0SwABY5o1ZK3KD2CVWzbNkU6HPps18OdhqN7QURid6NTiwTBcdSeaTX?=
 =?us-ascii?Q?MC2YLI+SIEW9TgDW4KXKt9znTXnNLFii+AZ1MVrAy36Gk5HRS05aryB/WOpm?=
 =?us-ascii?Q?z4DE1cm8smSBsNI23POfEZUFAd6GXdeDef+Ku5G+qd1kgQDk5TqJBx0g143y?=
 =?us-ascii?Q?nufSEUXWYuKH1TDwwBKL95CXDypondxofOxeBKSlpEjDtVyU2KrbPo2HfyOX?=
 =?us-ascii?Q?01RpAgMsLdnt3Wu+YxxPfJbr8VkSqwRaIyiZC0wMCBR8KIx0yT2n1hKN5ceX?=
 =?us-ascii?Q?C6Fiq+TbdGiYLAm2FhGAhEGffBydv35ORRjSF/lmN49sANuKfu9qrAaknuXl?=
 =?us-ascii?Q?4c//xxYcVKSn5x+MkTSXGnWFfWr8iJSjxoaErpbsDSdnexpq/+BlQd9QW8+4?=
 =?us-ascii?Q?yH3qN3ejcmEGZSgE5qmbncO8p0CjKpfLYkA9WHLdeB4jar15CF87tgoQdVJG?=
 =?us-ascii?Q?0mCA4FZlEeAmZ2OBslObLYwQvCif8ScCNzXojE6911tqAC+6Xdd38SfwRL4f?=
 =?us-ascii?Q?+27ZGOte43mWzN9BTE948ZLLKbgAEkuN06ngmK5n2orFvCak+tVxQbW7ylzE?=
 =?us-ascii?Q?rJL0KNXSZBX3508rE57bVYdHGnL8mcu4q5HdJn3S5OvfgO9pkjx/EW0BP0gr?=
 =?us-ascii?Q?lUMNr+tJKDVkSV7YPTwFQw7ipghwTuH0lohXqMCuD0zjWSzBs3r9pumg0JEm?=
 =?us-ascii?Q?vJQ9A0YOOFASREF5EFOXkp35nVS0sGGUXxoVZxMWesiKglboq8BnIJgZPMAJ?=
 =?us-ascii?Q?HthBylHcyZTbYGWu4tbjjLseriKW5L2qV8kLBSENc4BqDydsTgr51YC9Td0E?=
 =?us-ascii?Q?Haks+1gYQJklV8UH3IBxKyacDqpZfFln3Od8QQqZiOreyLE9OxdyRmH09aMl?=
 =?us-ascii?Q?sT/7xPdqVl9wDVKzsgrZE0jSENHngCDRbH3EgK9j6YcMkgFuxQBl9pICAVTJ?=
 =?us-ascii?Q?8MbBtL9AmkAPyFvWNvAf13u2qYe4VDiuoB0HgFK/KG0+VnxybdRac9Yg3Un0?=
 =?us-ascii?Q?l1lFcpAQlvmmWrNpoaOPdOge2X+lPbdpFBeBEbebaTkz2DTZfY/GTvfnFR55?=
 =?us-ascii?Q?IFM3PM+7wjFUWiz5VD3KDdRET8QeVUFyu9ECy4CFYPmdPL0v/XPS+Z7+tgfA?=
 =?us-ascii?Q?BmglVL+2xS633jIJM8Prigk9TPBYZuaAOIpqQOLQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(19092799006)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xgLEtwayZ7LVJ38aCQlzkgK2XcnPWrLCX7VHCIm5A6YQyX4G4SXNpYf3lR6g?=
 =?us-ascii?Q?exYDg7ZDBbExAkrvu9MjTxtmCJhtVwn+CvmlZZBed7OZVBCdRI22KiKlm7RU?=
 =?us-ascii?Q?/0PyLo81ID7txpvpMvW/pHJWZsdPnYZ5b6Z/6pCn+GkIcqr53q/zp9S28oKR?=
 =?us-ascii?Q?I8DIOOIutdboWg/FfcBwIJZT24/763LYXOKixSGQDaHut6CrVxMoK0wL8Qre?=
 =?us-ascii?Q?SuzLWmnExCV1/TL2+p9B4Lu2+SbuHxBSFHEtb/p4O4M8lY3PHev/JD6FheNY?=
 =?us-ascii?Q?NF+PzZgfe1Gszv1xTN16kBOVkWvxmL5VfADa7AGEEw+QJ+IqvRRYOuDXRp+w?=
 =?us-ascii?Q?YuJ1wktTavOfLCGBJ0M4BAzgvztQfQylmyPAz6fb5u+SmFE37HLVq/Vr0oxM?=
 =?us-ascii?Q?TSQYKGnYhUbiZLAsvvcfY5+zdwdiM1sTaUKjNRVb3Ro445kh1MEYdrcrRX6K?=
 =?us-ascii?Q?oeyXUYwgU3KEttahJ9eed/hgCBngrCwScXBzs/XsBae0rVcpV5HEi5CPmjl5?=
 =?us-ascii?Q?Cr2S8MyyGwjNgUVJ4mazlV1Ph6PUfXZlhcsesG8JtygtWW6hGsx4Z8gootrT?=
 =?us-ascii?Q?/zE00w6vB3hf2I1SADOld0QFrIYzsfQ9z+x16a6yzd3lDYEIRIF4hVHdL8K4?=
 =?us-ascii?Q?p/SexBfYJjdmbSwx3XiWZUQwOs3sYeROK/Hv8FjB+9XKUhZTVGhjTAAJPWk0?=
 =?us-ascii?Q?Du+Vvob0fTNoTHkyl77EPxnESf8+dz4QTBWEpjg8/cnflA2eYAlE6eiVz+gP?=
 =?us-ascii?Q?bdJzcOw1UfyQ+jXFd+GRdNxkckHCkMMBRGzFIESSid8fz6spkF0FRYApMy/J?=
 =?us-ascii?Q?LOY50mOuQbA57aBqnx/bf88K8y6J2tAniLJtaF0JQRK69F3c2KX1TIYvdpBU?=
 =?us-ascii?Q?65PgUXWclRzLdGg2Ni3GKqycJ+8wPisS0XJwZxfoNr3Zcr9/md7S51slKO4H?=
 =?us-ascii?Q?K5LT9YKgJv0vduzpaXG4m61g9OHv9WzOVriTECO/XVlcx1jwcS9zENio5nis?=
 =?us-ascii?Q?tDPQdNs4l1kUZZ4odmcR1YYG9G7wzb/9dTpjWqNvhnoqpCnoHB7vdQpDAP0C?=
 =?us-ascii?Q?ulbfRz/pTKiMvx49ieKFCHmNRS94kByTo89YtVF0ApJ/i9L4j13P2Kf9aWJO?=
 =?us-ascii?Q?ol3jgs6MjZe43l6KMdSZflhILHlGatzRsf0KXZsOcfHrOWIXyLZAu2rGvzLI?=
 =?us-ascii?Q?Cxfk+chsgbntABXE6UtB56JIYVClh8jHQ/YUS4kdpwwqMf58atz6lGVFHokR?=
 =?us-ascii?Q?fD257Hrh2vpr71uPll+ujK3NiM1MBVvp2YCuM+WqQhWV+wriWF1SV8RoGcf+?=
 =?us-ascii?Q?JV51RL1fF1/K/OKMoBxF4GnYAC49U1taLbaE10ZcEE2ILMRtgyAQSdkFWzVW?=
 =?us-ascii?Q?qISO6o5vIpm3weQUsxzRI0/4yBssqwKuQYX/zfxaz3F81Asp+xVJpfk6AgeZ?=
 =?us-ascii?Q?7bAEGRJmB4IvWQLDufV5dJp8oriZF1gTKLldciuL9eA0vrJCclMNQ4FeJUqx?=
 =?us-ascii?Q?n7JbKqVPUvJvlEwhjtLkSvL6nUFJtU5sO8tkpceRB/K1EMVibbUXxz+HEySg?=
 =?us-ascii?Q?D51+SG2JToLCMRz8DCtyh4M7nhbMS9Ktks+7SuS12WZj7iGIIeKqesf5gFmS?=
 =?us-ascii?Q?urMZWQWH92rVcyyZxue2/UCC6Q5xa4EcWKIEke0vfztq3EciEH0VXs6UxfNH?=
 =?us-ascii?Q?ZmQ56pyUJ8jsfXGSC2RjQNw67lA8jtPQKv1QoLheUiaylk7ggTl/KBvNxzWH?=
 =?us-ascii?Q?jBVoKLqgWw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0fd9c5-61b2-40a3-1628-08de70be6092
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 20:26:50.0740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZSN8UwZ0wftxYAvclF3LBQ7eLttWPllGJAtHqwmM0lNDjWykWgJd/Lw5yiDSgX+QVIERcQepbI6BL8DSivYWVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8996-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sifive.com:url,sifive.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A5C6916A9D8
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 03:43:54AM +0800, Max Hsu wrote:
> According to the FU540-C000 v1p5 [1] and FU740-C000 v1p7 [2] specs,
> when a DMA transaction error occurs, the hardware sets both the
> DONE and ERROR interrupt bits simultaneously.

Nit: need extra empty line between two paragraph.

> On SMP systems, this can cause the done_isr and err_isr to execute
> concurrently on different CPUs, leading to race conditions and
> NULL pointer dereferences.

On SMP systems, the race conditons and NULL pointer dereferences happen if
the done_isr and err_isr to execute concurrently on different CPUs

>
> Fix by:
> - In done_isr: abort if ERROR bit is set or DONE bit was already cleared
> - In err_isr: clear both DONE and ERROR bits to prevent done_isr from
>   processing the same transaction
>
> Link: https://www.sifive.com/document-file/freedom-u540-c000-manual [1]
> Link: https://www.sifive.com/document-file/freedom-u740-c000-manual [2]
> Fixes: 6973886ad58e ("dmaengine: sf-pdma: add platform DMA support for HiFive Unleashed A00")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Hsu <max.hsu@sifive.com>
> ---
>  drivers/dma/sf-pdma/sf-pdma.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
> index 7ad3c29be146..ac7d3b127a24 100644
> --- a/drivers/dma/sf-pdma/sf-pdma.c
> +++ b/drivers/dma/sf-pdma/sf-pdma.c
> @@ -346,9 +346,25 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
>  	struct sf_pdma_chan *chan = dev_id;
>  	struct pdma_regs *regs = &chan->regs;
>  	u64 residue;
> +	u32 control_reg;
>
>  	spin_lock(&chan->vchan.lock);
> -	writel((readl(regs->ctrl)) & ~PDMA_DONE_STATUS_MASK, regs->ctrl);
> +	control_reg = readl(regs->ctrl);
> +	if (control_reg & PDMA_ERR_STATUS_MASK) {
> +		spin_unlock(&chan->vchan.lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	/*
> +	 * Check if DONE bit is still set. If not, the error ISR on another
> +	 * CPU has already cleared it, so abort to avoid double-processing.
> +	 */
> +	if (!(control_reg & PDMA_DONE_STATUS_MASK)) {
> +		spin_unlock(&chan->vchan.lock);
> +		return IRQ_HANDLED;
> +	}
> +
> +	writel((control_reg & ~PDMA_DONE_STATUS_MASK), regs->ctrl);
>  	residue = readq(regs->residue);
>
>  	if (!residue) {
> @@ -375,7 +391,7 @@ static irqreturn_t sf_pdma_err_isr(int irq, void *dev_id)
>  	struct pdma_regs *regs = &chan->regs;
>
>  	spin_lock(&chan->lock);
> -	writel((readl(regs->ctrl)) & ~PDMA_ERR_STATUS_MASK, regs->ctrl);
> +	writel((readl(regs->ctrl)) & ~(PDMA_DONE_STATUS_MASK | PDMA_ERR_STATUS_MASK), regs->ctrl);
>  	spin_unlock(&chan->lock);
>
>  	tasklet_schedule(&chan->err_tasklet);


ideally, it'd better handle by one function

sf_pdma_isr()
{
     stat = readl(regs->ctrl);
     writel(stat & ~(PDMA_DONE_STATUS_MASK | PDMA_ERR_STATUS_MASK), regs->ctrl);

     if (err)
	return err_handle();

     if (done)
       return done_handle();

     return IRQ_NONE;
}

Anyways, this also work

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
> --
> 2.43.0
>

