Return-Path: <dmaengine+bounces-8857-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G/XE7cUimlrGAAAu9opvQ
	(envelope-from <dmaengine+bounces-8857-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 18:09:11 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA9F112E05
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 18:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D298B300823F
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F753859E8;
	Mon,  9 Feb 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Or59phe3"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799C72EB5CD;
	Mon,  9 Feb 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770656708; cv=fail; b=uLP6gok4PZRP8vy6RDy1wFcBOJyM1OjvsMK+leCUBtB1fm6bj0GrSvhN8kDqHRIx48pwusGdz3wYqoo3lvM3yzc1h5U8/CItcTy0RLLcUneuE12kKN6pBzK1Vj+90ahhydb4yl0wJQ9xisUO3th+ZuZY048CJi9abyg8PTgjgJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770656708; c=relaxed/simple;
	bh=39/tWwrn11oq1L6GrwINOzF3wSeeLS8kw1V8pFQ5bfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XYeaeLrX00Pv/BTrktDeefjIyLRuM30vky0+qNR7BqLY5GaBBfNVgyZfu7XocpczhIIUGtqWA5M0AHtdFhWkUBtpii4keTSpAVNTBYOZAY32nEjxp8Hdz4ghmv5g0QaoCNasRvXT8yp95mvPzsqfcOpFY28RNfxEEFK40NB8ONs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Or59phe3; arc=fail smtp.client-ip=52.101.70.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkgNsUylsscmMigsgb88i+a4wCbIsNXqCL778B4BwKbrNJkZvMxWXFDUCfH+qyw3nlU+584ueHj0/UBg5anMhaVxFwfawuC8wHeC1dZv4dlVbVpY+q9morflCULwFdxVN+d3fXT5R6dhfk6ZXTJnSNM53BTkj4AvwXEf/+A0Y0BLXCQpC1iYlttr3kn05Mcu53ndAQTfRhx/bEkYE/Ntt44YQnB1o0KfmhvPx+cQARkm0+bU89ctrJJdclqZdSJafneMrvdl3BHYHj4aa504FWRdckt/mjWhvTHTpEvM1WtZCeq+nTc0TAqbSTmmolAQ/3G7jwgfsthrajkf82qxqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPBhlFe/pyUaVu4MV4ZlPJRcLsz4asnGAYCLGniF/Ic=;
 b=kbcwBwNn/cDFvuF/QJMUkZ7K5R6TCMls+V03uAG7IsSKRG9uevPn0hNy8YZ4f5wPeauuiSU/x0NhFj+vAPCJlAePRNuUabe8K2LZT9ttLupMEkyKYLG9RRk1pKxtUMwC26xHSp7QP+3VwnbLSGBeUJYmn+0GeMErADskBRq+VckcoJ5GiM/1oEC6vqfACYqqF0NjJ/PxxFB6hVPxDyuJCN2fllL0nYpkzOYC7CMZMqMAAD+iHyrGxIFx5N7q8zAtjqyLuvbLghDWLUekVGeu11z9jIvMAXWi5wzf+q3a9U6wMpiVCXfFNQlcXOICCdRydjRi8v7WkSsdYES6Y+hJqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPBhlFe/pyUaVu4MV4ZlPJRcLsz4asnGAYCLGniF/Ic=;
 b=Or59phe398n4KH210HrmwMzhTBk00YqVEzX2/uMariLOcdgG1JRHS7FAgc9BjrhVMmkC24mEkDDclDdWE5JeEjDd8GTXkobOmZu802v/aNvJgzJm18HPXMRKPb0f4r23S4OM/AjiTuWatStnDArFmLjnJ9b74xURNOzqNprXyi7p0TT9ifxfZ9JYo2tnit+Xdbjh9rQi2d4OLcGrLenTDCIqwFaZBr6N/Ul/URlpCTmG6hakmashYCigMLSrM9Em9iEdB1lfuJxGZoBWnpa99yvzy3o4bfxDRC6hD5aegJKIra9WkTDKQvKuexB2Iq1g7jfXzUJ6dDsssuB0yJj+Jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV2PR04MB11422.eurprd04.prod.outlook.com (2603:10a6:150:2b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Mon, 9 Feb
 2026 17:05:04 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Mon, 9 Feb 2026
 17:05:04 +0000
Date: Mon, 9 Feb 2026 12:04:53 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	Xiaochuang Mao <maoxiaochuan@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org, jeffbai@aosc.io
Subject: Re: [PATCH v2 4/4] dmaengine: loongson: New driver for the Loongson
 Multi-Channel DMA controller
Message-ID: <aYoTtQ01VGXEW2Fu@lizhi-Precision-Tower-5810>
References: <cover.1770605931.git.zhoubinbin@loongson.cn>
 <a0eac5b7ba0bcced9664ff64349e563da3d031b3.1770605931.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0eac5b7ba0bcced9664ff64349e563da3d031b3.1770605931.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV2PR04MB11422:EE_
X-MS-Office365-Filtering-Correlation-Id: adf7ffcd-7336-4888-94a8-08de67fd5e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cHfjLTYbzkXZYqPgQKRPnfJiGwOiwaUGkMQslFOoWIZxsmwZ6cFtHxsWpUzt?=
 =?us-ascii?Q?DOeVm8D2y6QwNgZ0RkRl08Za+SbsxAuW9san+fGmsylV6D2WP9VekratORfe?=
 =?us-ascii?Q?oyAiN+B2AISkG1D9okuUan0HNvQ3OuvjoGxCHUijk9v/Xyh/x1Fmhud4o/Du?=
 =?us-ascii?Q?WnR6AH7CjqP+S7bsotbaDEraBDQKG3B0LbP3OUlUF1lspouPDYJSmDjvA78W?=
 =?us-ascii?Q?tLzubCljp4MPZzpEXYT2iBiXQA4DUXIM4k06jih+nXaGwXuiVYCa9UsEAz55?=
 =?us-ascii?Q?adHAKJ6bb1pB5Gslw2WKnvHd0BnSvYlH6zTfuE/5OM50SrYUlj/aQlXvklKw?=
 =?us-ascii?Q?XbjQHdNaU1VYslO/yr5N8g1eej/K/tt603mcJ9sLeMaJ1oVO81/D1525c5jm?=
 =?us-ascii?Q?CpvFfuxCSv9pA1UoF7OI48KXPec8oL+Tsq7oJZCUrMhv7vVuUeYJv0BP4dXZ?=
 =?us-ascii?Q?5yKHu5XxbCqMyKcz3KH3gEXroUOXe27xIJVxaACiedZz6xrv4RlF+71qsk1V?=
 =?us-ascii?Q?VneXAQfVTXZgHEvEUwKJrrGZPqyYA62suUAzEPdIOmxE8Ns/m5tZ+Sm6dl7W?=
 =?us-ascii?Q?oNkgH4FT2QPb1NxZ02wNMEkT0nBTOZ4j5HMP58nJw55ZR27EQfUWbvcjYpGI?=
 =?us-ascii?Q?tsNQyuiPf4vsQsO/RcFR/IvBoZ34hCJoS/s+HD3c2tDveXy/laAgq/hlPsqu?=
 =?us-ascii?Q?RXKn+TIPees0pDa9uRNiUwXn/qgiWJ4O9XNC5G8QhJ0ScROCykjnRDuq4DPi?=
 =?us-ascii?Q?4GmM2xhrjeyE8adGgbXJclVXMhZ7jXd4zAJ2vzMfR5ILD1zRgBas8H1T0r0l?=
 =?us-ascii?Q?QW6K1uyjngbs6XULDp1gg2Kqcc9AjiR+Uq7HfltENaJV9l4PViPjaaR3Z//D?=
 =?us-ascii?Q?2tNcD5yM9d5LnjjdtLf5tgoaf2+pSieq47wbOmNeRNg4JIVs8r0i8gQAdZHU?=
 =?us-ascii?Q?Mp7lVxyGsaxK3HddL4q/jAlME4YAfUc+7emeYOJlr2F2SLQ1D3opwZRV1qSB?=
 =?us-ascii?Q?hXMrjihxd/77R2n44XqNBbEsMITN+qAfHt2q/s7nO9CLIdUo8hSW+W5MGmKW?=
 =?us-ascii?Q?fnWcea40osAGZ+x+tzaO9wYEpEGprhvkE9lAEsLAQT+ap8bR5i/ksGMp+7u+?=
 =?us-ascii?Q?oGJOig+zxI+NVmZY3U5BflpJmGkttzHRvw1TRqX8hYr4uuK8LMnJKs6rXxCr?=
 =?us-ascii?Q?U03DpJ1IKTc2qMP7G/w+b3KEp4M9WxX7fMjcncHvVEAdFWO/ec4aM3V47pss?=
 =?us-ascii?Q?u1P8EDgWwnI9qMZpaVvLdu/Lcx1WWGvfER9/HigUZ8Em16ctg2cyeKFoCrDp?=
 =?us-ascii?Q?Rx0wit4R5bkcDCrX8C2R4EBJJoED0SPWPc1KH1LFKpK1b0zgOVDRfWPXacLH?=
 =?us-ascii?Q?oX7nVQMstySOZLrBXjXaJnC1MXfCeaqEDZQaB1Q50GeOA2i42aTIRzu4Oc54?=
 =?us-ascii?Q?CDvp2um8vi7AD5Z5JQy8GR8/BuLM8oBH/THwsZF4T8yTxb4CYf3S7eKzc7Ht?=
 =?us-ascii?Q?d4xGd7hzoLCnPZe8/qCJxCLmoErfNo/oqKtR2UTR3jzHaIx7OGicwvRAujYS?=
 =?us-ascii?Q?+govLWsXM+2nj5yx2jOfXL5R11FwxKHCY1N8KszoMepZ/F2kohG3sjVeQpk6?=
 =?us-ascii?Q?mZ17TVA+Hs8+/eUpNpNoFQY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKFslx6jpXrkV4vNNZZYb7epFVXwi4ytZR6/jcVxggwXF6ZS+ZZi+i3Vi6nI?=
 =?us-ascii?Q?Xd0x4YlGBYk8X1n/m0vQpAJHJEqD2kac8cIawRl4XlBL/Ng0pVnMQZS20R5W?=
 =?us-ascii?Q?u2slSVO5AM/AGf3Gy/LXbuobzfJENYZ/G5wZk0IgS+Pp/A7TDMyeE2nMehes?=
 =?us-ascii?Q?8D0LZUZIdX3Vc/q7sYWPVIqGAp4qgcH5iIOKkiVEK1TQ40Im3mAXi4p8wK3O?=
 =?us-ascii?Q?/HygB2PKs5siNSOONVXEMItWhIrnD8Y0qU2XDPXfGABpUseR4ok0v7xJXosx?=
 =?us-ascii?Q?2Iqr9R8+Bwvy+qraemFGc9Y7U6pem9g3zmYNc4ZaLBGATgm1d0AgMDWPLUjn?=
 =?us-ascii?Q?EbX4f1G6YrQfwMGehcq13EQISSOvDf4BZrhoO5pGGc39aIS+hBDlyyUsSLto?=
 =?us-ascii?Q?0cbV07u7YDF8MqXtLk7gqNYtxiy/QWP4w4HbnXU9PvfX8XmqtWpqhqjm9j1W?=
 =?us-ascii?Q?cnyNUsNZWgd5xF0jCEmDS1n2yai96iO1z0tpspYRG/dnL+6ASXhp+1GcyonQ?=
 =?us-ascii?Q?yqZsdqKUSoaEc4z/w/yR60DOnyhMfumvO/5OUXdoexy5cvtajuEiGs8P9qxT?=
 =?us-ascii?Q?MhTL9WR301yhnL4e1ixW3GS4xhR20ZAMoZtzdbMMkvuP5M6u5SEXiDV6Q8Xe?=
 =?us-ascii?Q?brKUr7/Q6VVRaJfgFyovf8cenMqsTxISH+ZVzx6ev5kASzg7xmruSBG4D2fS?=
 =?us-ascii?Q?TUvcHyxxJ7OfFh/WYuzKTfFey79ieVVQuZXTacfzcZHAfnOojeroyKjUo/Os?=
 =?us-ascii?Q?CMwkzfQgguj++zB4rQipWyjKSwZlF+HMiCYc9P6/kWSJzwriVLmymRCDZxFY?=
 =?us-ascii?Q?fErdPM68is9hXW213n9+lJg+Y4fUc1F2pytJgRW0BkgFPT4YAlBqkt/wmBvW?=
 =?us-ascii?Q?P/fYhboJFJQrNrJI7f0MactL6RZc8y2lCOeX/7dgr8Ka+JM9NB6RLs+Lcb9M?=
 =?us-ascii?Q?Oj/3+9A7M0Dff+FkarLtMjY+zi4ZIVXDBJbuNDCTLdkMzVQ3O4kDoLEzPaWf?=
 =?us-ascii?Q?GuXMyOEWShY4aF0KX2ijZ4VQU5HkEFDeWXZIRbswk2si/SRPe89NSE7Paz48?=
 =?us-ascii?Q?uF+EujuHFgy2ZeqnXiphLQzmPrzZ0NRHu6XYsTydPFgYP5r5EY5PacUKHB7I?=
 =?us-ascii?Q?Fze8CfSy0TzkRnOqkgQZEIDfewLHFfMGPMiN0neDPbnamrpykqGRqBDw0k5U?=
 =?us-ascii?Q?G3nIl3KUra5uA9+7bzaxGuv9CJgNBDy10qFYrpMc1Ty9FL/E/VgwMVm3ltrK?=
 =?us-ascii?Q?fjHZhUiY2s5JVR7CbZLXFBUFXWDyFr+whOc2wTbq3R43u1WhQbJtDv+JR9DG?=
 =?us-ascii?Q?EXIC7LDmG8xZiUjx2ZNCEamZ+FMje0eE7RhbO4UlIsrmcxA3SzKiZFYHEu6k?=
 =?us-ascii?Q?FeNkSDfND12aWmqUQIAMAqbHgw4sdaJyUOrcfMBh9y0pqrOAib3CcC4X+mh+?=
 =?us-ascii?Q?2dmkk21TkdG/pCgKFCYHuDBio4N87jK87PC+j2+ZLfe29ESzs+hbdgl759o0?=
 =?us-ascii?Q?SfSe8AWuxv7OyNC6cj8YmetPNEmptM7UAA/jwtFkqu7kGdcJ6rtZiG/lK+lm?=
 =?us-ascii?Q?mpGH3vNn59g/6BsseJgwfRBRxQULc/fVn34vwmho57gG8AbC79yAX64gM2Jb?=
 =?us-ascii?Q?S1jnuLDLZZ8P6bg+Bm0Nf45FnSdMwuopRyHXBuBoMhJBFLfFq++e+VmQq1Mk?=
 =?us-ascii?Q?iE22tIihVoOGwd8EiUo4vsuL0oq98jBA/sEBKsBXRu8XznaEb8y40WOPVa0w?=
 =?us-ascii?Q?KpcyIB57fA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adf7ffcd-7336-4888-94a8-08de67fd5e00
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 17:05:04.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: smhFgs4JEyWPCtyWthqYUtb/1TnUakmBhebcHLLqSrgfdy4PiwaPFgGoiVsCmORcnega7OMdesvxNH5xgNgnZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11422
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8857-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev,aosc.io];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: AEA9F112E05
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 11:04:55AM +0800, Binbin Zhou wrote:
> This DMA controller appears in Loongson-2K0300 and Loongson-2K3000.
>
> It is a chain multi-channel controller that enables data transfers from
> memory to memory, device to memory, and memory to device, as well as
> channel prioritization configurable through the channel configuration
> registers.
>
> In addition, there are slight differences between Loongson-2K0300 and
> Loongson-2K3000, such as channel register offsets and the number of
> channels.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
>  MAINTAINERS                                  |   1 +
>  drivers/dma/loongson/Kconfig                 |  10 +
>  drivers/dma/loongson/Makefile                |   1 +
>  drivers/dma/loongson/loongson2-apb-cmc-dma.c | 736 +++++++++++++++++++
>  4 files changed, 748 insertions(+)
>  create mode 100644 drivers/dma/loongson/loongson2-apb-cmc-dma.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d3cb541aee2a..61a39070d7a0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14778,6 +14778,7 @@ L:	dmaengine@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2k0300-dma.yaml
>  F:	Documentation/devicetree/bindings/dma/loongson,ls2x-apbdma.yaml
> +F:	drivers/dma/loongson/loongson2-apb-cmc-dma.c
>  F:	drivers/dma/loongson/loongson2-apb-dma.c
>
>  LOONGSON LS2X I2C DRIVER
> diff --git a/drivers/dma/loongson/Kconfig b/drivers/dma/loongson/Kconfig
> index 9dbdaef5a59f..28b3daeed4e3 100644
> --- a/drivers/dma/loongson/Kconfig
> +++ b/drivers/dma/loongson/Kconfig
> @@ -25,4 +25,14 @@ config LOONGSON2_APB_DMA
>  	  This DMA controller transfers data from memory to peripheral fifo.
>  	  It does not support memory to memory data transfer.
>
> +config LOONGSON2_APB_CMC_DMA
> +	tristate "Loongson2 Chain Multi-Channel DMA support"
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the Loongson Chain Multi-Channel DMA controller driver.
> +	  It is discovered on the Loongson-2K chip (Loongson-2K0300/Loongson-2K3000),
> +	  which has 4/8 channels internally, enabling bidirectional data transfer
> +	  between devices and memory.
> +
>  endif
> diff --git a/drivers/dma/loongson/Makefile b/drivers/dma/loongson/Makefile
> index 6cdd08065e92..48c19781e729 100644
> --- a/drivers/dma/loongson/Makefile
> +++ b/drivers/dma/loongson/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_LOONGSON1_APB_DMA) += loongson1-apb-dma.o
>  obj-$(CONFIG_LOONGSON2_APB_DMA) += loongson2-apb-dma.o
> +obj-$(CONFIG_LOONGSON2_APB_CMC_DMA) += loongson2-apb-cmc-dma.o
> diff --git a/drivers/dma/loongson/loongson2-apb-cmc-dma.c b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> new file mode 100644
> index 000000000000..f598ad095686
> --- /dev/null
> +++ b/drivers/dma/loongson/loongson2-apb-cmc-dma.c
> @@ -0,0 +1,736 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Looongson-2 Multi-Channel DMA Controller driver
> + *
> + * Copyright (C) 2024-2026 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/acpi_dma.h>
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_dma.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include "../dmaengine.h"
> +#include "../virt-dma.h"
> +
> +#define LOONGSON2_CMCDMA_ISR		0x0	/* DMA Interrupt Status Register */
> +#define LOONGSON2_CMCDMA_IFCR		0x4	/* DMA Interrupt Flag Clear Register */
> +#define LOONGSON2_CMCDMA_CCR		0x8	/* DMA Channel Configuration Register */
> +#define LOONGSON2_CMCDMA_CNDTR		0xc	/* DMA Channel Transmit Count Register */
> +#define LOONGSON2_CMCDMA_CPAR		0x10	/* DMA Channel Peripheral Address Register */
> +#define LOONGSON2_CMCDMA_CMAR		0x14	/* DMA Channel Memory Address Register */
> +
> +/* Bitfields of DMA interrupt status register */
> +#define LOONGSON2_CMCDMA_TCI		BIT(1) /* Transfer Complete Interrupt */
> +#define LOONGSON2_CMCDMA_HTI		BIT(2) /* Half Transfer Interrupt */
> +#define LOONGSON2_CMCDMA_TEI		BIT(3) /* Transfer Error Interrupt */
> +
> +#define LOONGSON2_CMCDMA_MASKI		\
> +	(LOONGSON2_CMCDMA_TCI | LOONGSON2_CMCDMA_HTI | LOONGSON2_CMCDMA_TEI)
> +
> +/* Bitfields of DMA channel x Configuration Register */
> +#define LOONGSON2_CMCDMA_CCR_EN		BIT(0) /* Stream Enable */
> +#define LOONGSON2_CMCDMA_CCR_TCIE	BIT(1) /* Transfer Complete Interrupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_HTIE	BIT(2) /* Half Transfer Complete Interrupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_TEIE	BIT(3) /* Transfer Error Interrupt Enable */
> +#define LOONGSON2_CMCDMA_CCR_DIR	BIT(4) /* Data Transfer Direction */
> +#define LOONGSON2_CMCDMA_CCR_CIRC	BIT(5) /* Circular mode */
> +#define LOONGSON2_CMCDMA_CCR_PINC	BIT(6) /* Peripheral increment mode */
> +#define LOONGSON2_CMCDMA_CCR_MINC	BIT(7) /* Memory increment mode */
> +#define LOONGSON2_CMCDMA_CCR_PSIZE_MASK	GENMASK(9, 8)
> +#define LOONGSON2_CMCDMA_CCR_MSIZE_MASK	GENMASK(11, 10)
> +#define LOONGSON2_CMCDMA_CCR_PL_MASK	GENMASK(13, 12)
> +#define LOONGSON2_CMCDMA_CCR_M2M	BIT(14)
> +
> +#define LOONGSON2_CMCDMA_CCR_CFG_MASK	\
> +	(LOONGSON2_CMCDMA_CCR_PINC | LOONGSON2_CMCDMA_CCR_MINC | LOONGSON2_CMCDMA_CCR_PL_MASK)
> +
> +#define LOONGSON2_CMCDMA_CCR_IRQ_MASK	\
> +	(LOONGSON2_CMCDMA_CCR_TCIE | LOONGSON2_CMCDMA_CCR_HTIE | LOONGSON2_CMCDMA_CCR_TEIE)
> +
> +#define LOONGSON2_CMCDMA_STREAM_MASK	\
> +	(LOONGSON2_CMCDMA_CCR_CFG_MASK | LOONGSON2_CMCDMA_CCR_IRQ_MASK)
> +
> +#define LOONGSON2_CMCDMA_BUSWIDTHS	(BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) | \
> +					 BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) | \
> +					 BIT(DMA_SLAVE_BUSWIDTH_4_BYTES))
> +
> +enum loongson2_cmc_dma_width {
> +	LOONGSON2_CMCDMA_BYTE,
> +	LOONGSON2_CMCDMA_HALF_WORD,
> +	LOONGSON2_CMCDMA_WORD,
> +};
> +
> +struct loongson2_cmc_dma_chan_reg {
> +	u32 ccr;
> +	u32 cndtr;
> +	u32 cpar;
> +	u32 cmar;
> +};
> +
> +struct loongson2_cmc_dma_sg_req {
> +	u32 len;
> +	struct loongson2_cmc_dma_chan_reg chan_reg;
> +};
> +
> +struct loongson2_cmc_dma_desc {
> +	struct virt_dma_desc vdesc;
> +	bool cyclic;
> +	u32 num_sgs;
> +	struct loongson2_cmc_dma_sg_req sg_req[] __counted_by(num_sgs);
> +};
> +
> +struct loongson2_cmc_dma_chan {
> +	struct virt_dma_chan vchan;
> +	struct dma_slave_config	dma_sconfig;
> +	struct loongson2_cmc_dma_desc *desc;
> +	u32 id;
> +	u32 irq;
> +	u32 next_sg;
> +	struct loongson2_cmc_dma_chan_reg chan_reg;
> +};
> +
> +struct loongson2_cmc_dma_config {
> +	u32 max_channels;
> +	u32 chan_reg_offset;
> +};
> +
> +struct loongson2_cmc_dma_dev {
> +	struct dma_device ddev;
> +	struct clk *dma_clk;
> +	void __iomem *base;
> +	u32 nr_channels;
> +	u32 chan_reg_offset;
> +	struct loongson2_cmc_dma_chan chan[] __counted_by(nr_channels);
> +};
> +
> +static const struct loongson2_cmc_dma_config ls2k0300_cmc_dma_config = {
> +	.max_channels = 8,
> +	.chan_reg_offset = 0x14,
> +};
> +
> +static const struct loongson2_cmc_dma_config ls2k3000_cmc_dma_config = {
> +	.max_channels = 4,
> +	.chan_reg_offset = 0x18,
> +};
> +
> +static struct loongson2_cmc_dma_dev *lmdma_get_dev(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	return container_of(lchan->vchan.chan.device, struct loongson2_cmc_dma_dev, ddev);
> +}
> +
> +static struct loongson2_cmc_dma_chan *to_lmdma_chan(struct dma_chan *chan)
> +{
> +	return container_of(chan, struct loongson2_cmc_dma_chan, vchan.chan);
> +}
> +
> +static struct loongson2_cmc_dma_desc *to_lmdma_desc(struct virt_dma_desc *vdesc)
> +{
> +	return container_of(vdesc, struct loongson2_cmc_dma_desc, vdesc);
> +}
> +
> +static struct device *chan2dev(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	return &lchan->vchan.chan.dev->device;
> +}
> +
> +static u32 loongson2_cmc_dma_read(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id)
> +{
> +	return readl(lddev->base + (reg + lddev->chan_reg_offset * id));
> +}
> +
> +static void loongson2_cmc_dma_write(struct loongson2_cmc_dma_dev *lddev, u32 reg, u32 id, u32 val)
> +{
> +	writel(val, lddev->base + (reg + lddev->chan_reg_offset * id));
> +}
> +
> +static int loongson2_cmc_dma_get_width(struct loongson2_cmc_dma_chan *lchan,
> +				       enum dma_slave_buswidth width)
> +{
> +	switch (width) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		return LOONGSON2_CMCDMA_BYTE;
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		return LOONGSON2_CMCDMA_HALF_WORD;
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		return LOONGSON2_CMCDMA_WORD;

is ffs() helper in case your hardware support more buswidth in future?

> +	default:
> +		dev_err(chan2dev(lchan), "Dma bus width not supported\n");
> +		return -EINVAL;
> +	}
> +}
> +
> +static int loongson2_cmc_dma_slave_config(struct dma_chan *chan, struct dma_slave_config *config)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +
> +	memcpy(&lchan->dma_sconfig, config, sizeof(*config));
> +
> +	return 0;
> +}
> +
> +static void loongson2_cmc_dma_irq_clear(struct loongson2_cmc_dma_chan *lchan, u32 flags)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	u32 ifcr;
> +
> +	ifcr = flags << (4 * lchan->id);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_IFCR, 0, ifcr);
> +}
> +
> +static void loongson2_cmc_dma_stop(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	u32 ccr;
> +
> +	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
> +	ccr &= ~(LOONGSON2_CMCDMA_CCR_IRQ_MASK | LOONGSON2_CMCDMA_CCR_EN);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, ccr);
> +
> +	loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_MASKI);
> +}
> +
> +static int loongson2_cmc_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	unsigned long flags;
> +
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&lchan->vchan.lock, flags);
> +	if (lchan->desc) {
> +		vchan_terminate_vdesc(&lchan->desc->vdesc);
> +		loongson2_cmc_dma_stop(lchan);
> +		lchan->desc = NULL;
> +	}
> +	vchan_get_all_descriptors(&lchan->vchan, &head);
> +	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +
> +	vchan_dma_desc_free_list(&lchan->vchan, &head);
> +
> +	return 0;
> +}
> +
> +static void loongson2_cmc_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +
> +	vchan_synchronize(&lchan->vchan);
> +}
> +
> +static void loongson2_cmc_dma_start_transfer(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	struct loongson2_cmc_dma_sg_req *sg_req;
> +	struct loongson2_cmc_dma_chan_reg *reg;
> +	struct virt_dma_desc *vdesc;
> +
> +	loongson2_cmc_dma_stop(lchan);
> +
> +	if (!lchan->desc) {
> +		vdesc = vchan_next_desc(&lchan->vchan);
> +		if (!vdesc)
> +			return;
> +
> +		list_del(&vdesc->node);
> +		lchan->desc = to_lmdma_desc(vdesc);
> +		lchan->next_sg = 0;
> +	}
> +
> +	if (lchan->next_sg == lchan->desc->num_sgs)
> +		lchan->next_sg = 0;
> +
> +	sg_req = &lchan->desc->sg_req[lchan->next_sg];
> +	reg = &sg_req->chan_reg;
> +
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, reg->ccr);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id, reg->cndtr);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CPAR, lchan->id, reg->cpar);
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, lchan->id, reg->cmar);
> +
> +	lchan->next_sg++;
> +
> +	/* Start DMA */
> +	reg->ccr |= LOONGSON2_CMCDMA_CCR_EN;
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, lchan->id, reg->ccr);
> +}
> +
> +static void loongson2_cmc_dma_configure_next_sg(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	struct loongson2_cmc_dma_sg_req *sg_req;
> +	u32 ccr, id = lchan->id;
> +
> +	if (lchan->next_sg == lchan->desc->num_sgs)
> +		lchan->next_sg = 0;
> +
> +	/* stop to update mem addr */
> +	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, id);
> +	ccr &= ~LOONGSON2_CMCDMA_CCR_EN;
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> +
> +	sg_req = &lchan->desc->sg_req[lchan->next_sg];
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CMAR, id, sg_req->chan_reg.cmar);
> +
> +	/* start transition */
> +	ccr |= LOONGSON2_CMCDMA_CCR_EN;
> +	loongson2_cmc_dma_write(lddev, LOONGSON2_CMCDMA_CCR, id, ccr);
> +}
> +
> +static void loongson2_cmc_dma_handle_chan_done(struct loongson2_cmc_dma_chan *lchan)
> +{
> +	if (!lchan->desc)
> +		return;
> +
> +	if (lchan->desc->cyclic) {
> +		vchan_cyclic_callback(&lchan->desc->vdesc);
> +		/* LOONGSON2_CMCDMA_CCR_CIRC mode don't need update register */
> +		if (lchan->desc->num_sgs == 1)
> +			return;
> +		loongson2_cmc_dma_configure_next_sg(lchan);
> +		lchan->next_sg++;
> +	} else {
> +		if (lchan->next_sg == lchan->desc->num_sgs) {
> +			vchan_cookie_complete(&lchan->desc->vdesc);
> +			lchan->desc = NULL;
> +		}
> +		loongson2_cmc_dma_start_transfer(lchan);
> +	}
> +}
> +
> +static irqreturn_t loongson2_cmc_dma_chan_irq(int irq, void *devid)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = devid;
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	u32 ists, status, scr;
> +
> +	spin_lock(&lchan->vchan.lock);
> +
> +	ists = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_ISR, 0);
> +	scr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
> +
> +	status = (ists >> (4 * lchan->id)) & LOONGSON2_CMCDMA_MASKI;
> +	status &= scr;
> +
> +	if (status & LOONGSON2_CMCDMA_TCI)
> +		loongson2_cmc_dma_handle_chan_done(lchan);
> +
> +	if (status & LOONGSON2_CMCDMA_HTI)
> +		loongson2_cmc_dma_irq_clear(lchan, LOONGSON2_CMCDMA_HTI);
> +
> +	if (status & LOONGSON2_CMCDMA_TEI)
> +		dev_err(chan2dev(lchan), "DMA Transform Error\n");
> +
> +	loongson2_cmc_dma_irq_clear(lchan, status);

irq clear should before loongson2_cmc_dma_handle_chan_done() incase you
missed irq, if loongson2_cmc_dma_handle_chan_done() trigger new irq before
your call irq_cler().

> +
> +	spin_unlock(&lchan->vchan.lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void loongson2_cmc_dma_issue_pending(struct dma_chan *chan)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&lchan->vchan.lock, flags);
> +	if (vchan_issue_pending(&lchan->vchan) && !lchan->desc) {
> +		dev_dbg(chan2dev(lchan), "vchan %pK: issued\n", &lchan->vchan);
> +		loongson2_cmc_dma_start_transfer(lchan);
> +	}
> +	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +}
> +
> +static int loongson2_cmc_dma_set_xfer_param(struct loongson2_cmc_dma_chan *lchan,
> +					    enum dma_transfer_direction direction,
> +					    enum dma_slave_buswidth *buswidth, u32 buf_len)
> +{
> +	struct dma_slave_config	sconfig = lchan->dma_sconfig;
> +	int dev_width;
> +	u32 ccr;
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		dev_width = loongson2_cmc_dma_get_width(lchan, sconfig.dst_addr_width);
> +		if (dev_width < 0)
> +			return dev_width;
> +		lchan->chan_reg.cpar = sconfig.dst_addr;
> +		ccr = LOONGSON2_CMCDMA_CCR_DIR;
> +		*buswidth = sconfig.dst_addr_width;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		dev_width = loongson2_cmc_dma_get_width(lchan, sconfig.src_addr_width);
> +		if (dev_width < 0)
> +			return dev_width;
> +		lchan->chan_reg.cpar = sconfig.src_addr;
> +		ccr = LOONGSON2_CMCDMA_CCR_MINC;
> +		*buswidth = sconfig.src_addr_width;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ccr |= FIELD_PREP(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, dev_width) |
> +	       FIELD_PREP(LOONGSON2_CMCDMA_CCR_MSIZE_MASK, dev_width);
> +
> +	/* Set DMA control register */
> +	lchan->chan_reg.ccr &= ~(LOONGSON2_CMCDMA_CCR_PSIZE_MASK | LOONGSON2_CMCDMA_CCR_MSIZE_MASK);
> +	lchan->chan_reg.ccr |= ccr;
> +
> +	return 0;
> +}
> +
> +static struct dma_async_tx_descriptor *
> +loongson2_cmc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl, u32 sg_len,
> +				enum dma_transfer_direction direction,
> +				unsigned long flags, void *context)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct loongson2_cmc_dma_desc *desc;
> +	enum dma_slave_buswidth buswidth;
> +	struct scatterlist *sg;
> +	u32 num_items, i;
> +	int ret;
> +
> +	desc = kzalloc(struct_size(desc, sg_req, sg_len), GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, sg_dma_len(sg));
> +		if (ret)
> +			return NULL;
> +
> +		desc->sg_req[i].len = sg_dma_len(sg);
> +
> +		num_items = desc->sg_req[i].len / buswidth;
> +		if (num_items >= SZ_64K) {
> +			dev_err(chan2dev(lchan), "Number of items not supported\n");
> +			kfree(desc);
> +			return NULL;

if use sg_nents_for_dma(), you can use multi sg to trasfer more than 64K
data.

> +		}
> +		desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
> +		desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
> +		desc->sg_req[i].chan_reg.cmar = sg_dma_address(sg);
> +		desc->sg_req[i].chan_reg.cndtr = num_items;
> +	}
> +
> +	desc->num_sgs = sg_len;
> +	desc->cyclic = false;
> +
> +	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +loongson2_cmc_dma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +				  size_t period_len, enum dma_transfer_direction direction,
> +				  unsigned long flags)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct loongson2_cmc_dma_desc *desc;
> +	enum dma_slave_buswidth buswidth;
> +	u32 num_periods, num_items, i;
> +	int ret;
> +
> +	if (unlikely(buf_len % period_len))
> +		return NULL;
> +
> +	ret = loongson2_cmc_dma_set_xfer_param(lchan, direction, &buswidth, period_len);
> +	if (ret)
> +		return NULL;
> +
> +	num_items = period_len / buswidth;
> +	if (num_items >= SZ_64K) {
> +		dev_err(chan2dev(lchan), "Number of items not supported\n");
> +		return NULL;
> +	}
> +
> +	/* Enable Circular mode */
> +	if (buf_len == period_len)
> +		lchan->chan_reg.ccr |= LOONGSON2_CMCDMA_CCR_CIRC;
> +
> +	num_periods = buf_len / period_len;
> +	desc = kzalloc(struct_size(desc, sg_req, num_periods), GFP_NOWAIT);
> +	if (!desc)
> +		return NULL;
> +
> +	for (i = 0; i < num_periods; i++) {
> +		desc->sg_req[i].len = period_len;
> +		desc->sg_req[i].chan_reg.ccr = lchan->chan_reg.ccr;
> +		desc->sg_req[i].chan_reg.cpar = lchan->chan_reg.cpar;
> +		desc->sg_req[i].chan_reg.cmar = buf_addr;
> +		desc->sg_req[i].chan_reg.cndtr = num_items;
> +		buf_addr += period_len;
> +	}
> +
> +	desc->num_sgs = num_periods;
> +	desc->cyclic = true;
> +
> +	return vchan_tx_prep(&lchan->vchan, &desc->vdesc, flags);
> +}
> +
> +static size_t loongson2_cmc_dma_desc_residue(struct loongson2_cmc_dma_chan *lchan,
> +					     struct loongson2_cmc_dma_desc *desc, u32 next_sg)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = lmdma_get_dev(lchan);
> +	u32 residue, width, ndtr, ccr, i;
> +
> +	ccr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CCR, lchan->id);
> +	width = FIELD_GET(LOONGSON2_CMCDMA_CCR_PSIZE_MASK, ccr);
> +
> +	ndtr = loongson2_cmc_dma_read(lddev, LOONGSON2_CMCDMA_CNDTR, lchan->id);
> +	residue = ndtr << width;
> +
> +	if (lchan->desc->cyclic && next_sg == 0)
> +		return residue;
> +
> +	for (i = next_sg; i < desc->num_sgs; i++)
> +		residue += desc->sg_req[i].len;
> +
> +	return residue;
> +}
> +
> +static enum dma_status loongson2_cmc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
> +						   struct dma_tx_state *state)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct virt_dma_desc *vdesc;
> +	enum dma_status status;
> +	unsigned long flags;
> +
> +	status = dma_cookie_status(chan, cookie, state);
> +	if (status == DMA_COMPLETE || !state)
> +		return status;
> +
> +	spin_lock_irqsave(&lchan->vchan.lock, flags);
> +	vdesc = vchan_find_desc(&lchan->vchan, cookie);
> +	if (lchan->desc && cookie == lchan->desc->vdesc.tx.cookie)
> +		state->residue = loongson2_cmc_dma_desc_residue(lchan, lchan->desc, lchan->next_sg);
> +	else if (vdesc)
> +		state->residue = loongson2_cmc_dma_desc_residue(lchan, to_lmdma_desc(vdesc), 0);
> +
> +	spin_unlock_irqrestore(&lchan->vchan.lock, flags);
> +
> +	return status;
> +}
> +
> +static void loongson2_cmc_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	vchan_free_chan_resources(to_virt_chan(chan));
> +}
> +
> +static void loongson2_cmc_dma_desc_free(struct virt_dma_desc *vdesc)
> +{
> +	kfree(to_lmdma_desc(vdesc));
> +}
> +
> +static bool loongson2_cmc_dma_acpi_filter(struct dma_chan *chan, void *param)
> +{
> +	struct loongson2_cmc_dma_chan *lchan = to_lmdma_chan(chan);
> +	struct acpi_dma_spec *dma_spec = param;
> +
> +	memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
> +	lchan->chan_reg.ccr = dma_spec->chan_id & LOONGSON2_CMCDMA_STREAM_MASK;
> +
> +	return true;
> +}
> +
> +static int loongson2_cmc_dma_acpi_controller_register(struct loongson2_cmc_dma_dev *lddev)
> +{
> +	struct device *dev = lddev->ddev.dev;
> +	struct acpi_dma_filter_info *info;
> +	int ret;
> +
> +	if (!has_acpi_companion(dev))
> +		return 0;
> +
> +	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	dma_cap_zero(info->dma_cap);
> +	info->dma_cap = lddev->ddev.cap_mask;
> +	info->filter_fn = loongson2_cmc_dma_acpi_filter;
> +
> +	ret = devm_acpi_dma_controller_register(dev, acpi_dma_simple_xlate, info);
> +	if (ret)
> +		dev_err(dev, "could not register acpi_dma_controller\n");
> +
> +	return ret;
> +}
> +
> +static struct dma_chan *loongson2_cmc_dma_of_xlate(struct of_phandle_args *dma_spec,
> +						   struct of_dma *ofdma)
> +{
> +	struct loongson2_cmc_dma_dev *lddev = ofdma->of_dma_data;
> +	struct device *dev = lddev->ddev.dev;
> +	struct loongson2_cmc_dma_chan *lchan;
> +	struct dma_chan *chan;
> +
> +	if (dma_spec->args_count < 2)
> +		return NULL;
> +
> +	if (dma_spec->args[0] >= lddev->nr_channels) {
> +		dev_err(dev, "Invalid channel id\n");
> +		return NULL;
> +	}
> +
> +	lchan = &lddev->chan[dma_spec->args[0]];
> +	chan = dma_get_slave_channel(&lchan->vchan.chan);
> +	if (!chan) {
> +		dev_err(dev, "No more channels available\n");
> +		return NULL;
> +	}
> +
> +	memset(&lchan->chan_reg, 0, sizeof(struct loongson2_cmc_dma_chan_reg));
> +	lchan->chan_reg.ccr = dma_spec->args[1] & LOONGSON2_CMCDMA_STREAM_MASK;
> +
> +	return chan;
> +}
> +
> +static int loongson2_cmc_dma_of_controller_register(struct loongson2_cmc_dma_dev *lddev)
> +{
> +	struct device *dev = lddev->ddev.dev;
> +	int ret;
> +
> +	if (!dev->of_node)
> +		return 0;
> +
> +	ret = of_dma_controller_register(dev->of_node, loongson2_cmc_dma_of_xlate, lddev);
> +	if (ret)
> +		dev_err(dev, "could not register of_dma_controller\n");
> +
> +	return ret;
> +}
> +
> +static int loongson2_cmc_dma_probe(struct platform_device *pdev)
> +{
> +	const struct loongson2_cmc_dma_config *config;
> +	struct loongson2_cmc_dma_chan *lchan;
> +	struct loongson2_cmc_dma_dev *lddev;
> +	struct device *dev = &pdev->dev;
> +	struct dma_device *ddev;
> +	u32 nr_chans, i;
> +	int ret;
> +
> +	config = (const struct loongson2_cmc_dma_config *)device_get_match_data(dev);
> +	if (!config)
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32(dev, "dma-channels", &nr_chans);
> +	if (ret || nr_chans > config->max_channels) {
> +		dev_err(dev, "missing or invalid dma-channels property\n");
> +		nr_chans = config->max_channels;
> +	}
> +
> +	lddev = devm_kzalloc(dev, struct_size(lddev, chan, nr_chans), GFP_KERNEL);
> +	if (!lddev)
> +		return -ENOMEM;
> +
> +	lddev->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(lddev->base))
> +		return PTR_ERR(lddev->base);
> +
> +	platform_set_drvdata(pdev, lddev);
> +	lddev->nr_channels = nr_chans;
> +	lddev->chan_reg_offset = config->chan_reg_offset;
> +
> +	lddev->dma_clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(lddev->dma_clk))
> +		return dev_err_probe(dev, PTR_ERR(lddev->dma_clk), "Failed to get dma clock\n");
> +
> +	ddev = &lddev->ddev;
> +	ddev->dev = dev;
> +
> +	dma_cap_zero(ddev->cap_mask);
> +	dma_cap_set(DMA_SLAVE, ddev->cap_mask);
> +	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +	dma_cap_set(DMA_CYCLIC, ddev->cap_mask);
> +
> +	ddev->device_free_chan_resources = loongson2_cmc_dma_free_chan_resources;
> +	ddev->device_config = loongson2_cmc_dma_slave_config;
> +	ddev->device_prep_slave_sg = loongson2_cmc_dma_prep_slave_sg;
> +	ddev->device_prep_dma_cyclic = loongson2_cmc_dma_prep_dma_cyclic;
> +	ddev->device_issue_pending = loongson2_cmc_dma_issue_pending;
> +	ddev->device_synchronize = loongson2_cmc_dma_synchronize;
> +	ddev->device_tx_status = loongson2_cmc_dma_tx_status;
> +	ddev->device_terminate_all = loongson2_cmc_dma_terminate_all;
> +
> +	ddev->src_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
> +	ddev->dst_addr_widths = LOONGSON2_CMCDMA_BUSWIDTHS;
> +	ddev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> +	INIT_LIST_HEAD(&ddev->channels);

where use this 'channels' ?

Frank
> +
> +	for (i = 0; i < nr_chans; i++) {
> +		lchan = &lddev->chan[i];
> +
> +		lchan->id = i;
> +		lchan->vchan.desc_free = loongson2_cmc_dma_desc_free;
> +		vchan_init(&lchan->vchan, ddev);
> +	}
> +
> +	ret = dmaenginem_async_device_register(ddev);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_chans; i++) {
> +		lchan = &lddev->chan[i];
> +
> +		lchan->irq = platform_get_irq(pdev, i);
> +		if (lchan->irq < 0)
> +			return lchan->irq;
> +
> +		ret = devm_request_irq(dev, lchan->irq, loongson2_cmc_dma_chan_irq, IRQF_SHARED,
> +				       dev_name(chan2dev(lchan)), lchan);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = loongson2_cmc_dma_acpi_controller_register(lddev);
> +	if (ret)
> +		return ret;
> +
> +	return loongson2_cmc_dma_of_controller_register(lddev);
> +}
> +
> +static void loongson2_cmc_dma_remove(struct platform_device *pdev)
> +{
> +	of_dma_controller_free(pdev->dev.of_node);
> +}
> +
> +static const struct of_device_id loongson2_cmc_dma_of_match[] = {
> +	{ .compatible = "loongson,ls2k0300-dma", .data = &ls2k0300_cmc_dma_config },
> +	{ .compatible = "loongson,ls2k3000-dma", .data = &ls2k3000_cmc_dma_config },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, loongson2_cmc_dma_of_match);
> +
> +static const struct acpi_device_id loongson2_cmc_dma_acpi_match[] = {
> +	{ "LOON0014", .driver_data = (kernel_ulong_t)&ls2k3000_cmc_dma_config },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson2_cmc_dma_acpi_match);
> +
> +static struct platform_driver loongson2_cmc_dma_driver = {
> +	.driver = {
> +		.name = "loongson2-apb-cmc-dma",
> +		.of_match_table = loongson2_cmc_dma_of_match,
> +		.acpi_match_table = loongson2_cmc_dma_acpi_match,
> +	},
> +	.probe = loongson2_cmc_dma_probe,
> +	.remove = loongson2_cmc_dma_remove,
> +};
> +module_platform_driver(loongson2_cmc_dma_driver);
> +
> +MODULE_DESCRIPTION("Looongson-2 Multi-Channel DMA Controller driver");
> +MODULE_AUTHOR("Loongson Technology Corporation Limited");
> +MODULE_LICENSE("GPL");
> --
> 2.52.0
>

