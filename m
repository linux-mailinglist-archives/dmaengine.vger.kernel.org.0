Return-Path: <dmaengine+bounces-8434-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG50A1kCcWmgbAAAu9opvQ
	(envelope-from <dmaengine+bounces-8434-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:44:09 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B97DC5A10F
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 17:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 605D2787A61
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 16:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E3C361DA0;
	Wed, 21 Jan 2026 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dK81HxXM"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98C47CC94
	for <dmaengine@vger.kernel.org>; Wed, 21 Jan 2026 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012620; cv=fail; b=As2z+P103gpsqJzcquM/WLNodJOOIbGgtiANj9axcXCB8OYe0koqcDeVvRki6pzLDFGs6lNi1HSPkfEfZIOfEf65SlxMI7+5SCuDBOwXNpIv/xmb/8b0EZQHT7HaJI6v/mZWVclahIiSiX2LhZ4DArjbcE/PWF/TSxq2nnN/ZKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012620; c=relaxed/simple;
	bh=z9p3EwwrtoG3IQAizlaova5msycmjnatNlkEiXWopHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOnHpotVnP069fhb2/Ry2/gby7lQY2RfmWUtqOjE4II3usUhbwb49fG4DoC2WLA0elDI0oBdX0t7hz2AMp4IUavB2nki6u28Gepiy7cFDF6UEYDhJtM687qywT8n1thbVr/BpNYniWHUH3T1tARsrjwM5iyKSAmNZTahqCAaI2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dK81HxXM; arc=fail smtp.client-ip=52.101.83.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISMPtV53IeGP2bZ79XopgJDSRyoBW6xzxUGzq/mBh93I7FGQadDyLqbg27cwJz1oXNOjzhCGO2D4gd9mExP2sEldAumomNYVfhqTeTE7x9Kl14CzN6jsKP0CFaUCvgbepTM4xip9X7kqRWFPzezHoq/n4EgSSRXndyrDrXPZlL0v58UVsMnVGI8OUHhtUZNRR33soMlcenPFlrgm+lQHgVcm0Qio61fNqGYBXU+b02I4X6Pwz34WjEBbYqPJmxX70Y3hQseeAjBtRb4WrQilOCQhrU2R/OJ4pSmfbCvJ8Wo2y8DthAqGUsBVFUsVfb3Z7MNUQIqV6ErAwyyj9zCGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egd83kPXFuc+vWat9+oUmNWk/M8t+fV9ZiwezVyO4XQ=;
 b=lGkWjmPn791viEbk/ZyA2LbwziTBzBv3e8gedbnddRwFF/HVNVpt7whukzudZ09Ou3Kvm95P8yD+GlB1DGP+aOsAiHeaetCIx2kEfBVJ6hLElq1ufdYDXEiSBZb9z16GZ04edtE6y8qWX5hPlLwiOxShfSypmDy4n1IepUd/jpjW8OuZvGGjfJ3u1GRsBYnf09D5CgJqqBsklpyBUBzzkyU0so5EJ7XFn62jw7owxwsgHY7Wbh72N95GqQNpUGyhaw3DrXUPhy77tg6Cq/TWNlrrJMflusAtwhNjwIyrgEET4FQREYZm9L2KUVogfm+kC31rZI3MVcd43X5XkLMQwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egd83kPXFuc+vWat9+oUmNWk/M8t+fV9ZiwezVyO4XQ=;
 b=dK81HxXMNbpbx0Yayee4HSOnTP0M/PFECtlruLjJZ3iwPWOE9G0obbj6xRjMESJe4j67Dd7nRB8ddp9M91Vrl6XDntnQUU+a9tz9InCasxsvZ6MtJUWbke3jS6/nYhoZb8DxOuDQ1+l3r6qG8Bv3FB4rx6guYH+MasAtjxjrak5hy1lZ3sGzgYGBSldrqgyKiKOiiX7JYWPApv1q7qb+IAzxA3aJCnrJdagjI9LotCFuGZCsxXz6Jyq5uQ0qtmvomN6iigq/0sV+7CCGHRItl5XpPECdf19JBd4A3+DvaHmiit4UqxoFpVvwyr8ZZ4GZfuZGVpsH/iazzy7HYMRzeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Wed, 21 Jan
 2026 16:23:31 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9520.011; Wed, 21 Jan 2026
 16:23:30 +0000
Date: Wed, 21 Jan 2026 11:23:24 -0500
From: Frank Li <Frank.li@nxp.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	George Ge <George.Ge@microchip.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v13 2/3] dmaengine: switchtec-dma: Implement hardware
 initialization and cleanup
Message-ID: <aXD9fHOCm4kWyahZ@lizhi-Precision-Tower-5810>
References: <20260121051219.2409-1-logang@deltatee.com>
 <20260121051219.2409-3-logang@deltatee.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121051219.2409-3-logang@deltatee.com>
X-ClientProxiedBy: PH8PR07CA0041.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::29) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e3a393-b8f6-41f7-10ce-08de59096a43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FvXfQCaShbbx0yU2RCYkb8Q7OUgieIov58zz091cs8waiCGcjTIrXD0b8AUl?=
 =?us-ascii?Q?i4zJ3zmw0SPT3z5Cbgd0ugIv2smlP5mk//rWM5iWn71LeJYcsda7lxDxlqmd?=
 =?us-ascii?Q?+WYLRF/IRAvC35EMFW4uJyAjEkCu53WFCijEgq9dT9aAc80N7pmFept+hKG1?=
 =?us-ascii?Q?MxsB+weylSoYDKwD9sH2TArqOzpJtD9/ZN0yJIOm6RB3lm8HGl2O24a/D8JC?=
 =?us-ascii?Q?BKFPaBDoCxZs9sii9pwaFgM3JeHBxiPmiQGHVN6Rusf6rz8o4tXMGPkQv5hw?=
 =?us-ascii?Q?gNaTBIXZ2BO57h1wsqb1vKwo9XJ16oER8fS7GQZSmTX3Cat4OuuB1vVCxmru?=
 =?us-ascii?Q?hDfNqEQyYGV7ZA+wJaciUEjP3Ly9IRmvzKyOVDgcJaIXbVGzFeJWGQRCLyDU?=
 =?us-ascii?Q?04mPgGuMOFbIMff5S91rl/IyMWMnB/Spp5P4s8y9bMZk0ZZvqjfC4fiZptUY?=
 =?us-ascii?Q?kXLw+hFSyTnh/ow0qbwLA5av/j9ME9tOXwelYUMehrySzHlJS83cZeTmUYMe?=
 =?us-ascii?Q?WJ4czy+5G+uRi69vvbYrFysO/EyPmLI+vSEDwqPsBtZfp6kwwck0WO39WDkU?=
 =?us-ascii?Q?Kk706kzwc0NBQntj03/YrPE52EMuNKAgYkS+93w6XPypxiQx35i8Kg4bc9Fs?=
 =?us-ascii?Q?Aft6ubS7yUlRyG7R4L03xfmGreeYQEfEYht+JStljDYdcVyMtGEj62dDc6dw?=
 =?us-ascii?Q?9pYnLhq15Q6KrDcVEcPA1qRdwL/RMarPzbo9s8eEYw+czIhPR/BQCd3LywrP?=
 =?us-ascii?Q?7byHyQi2yXf/yG3Wmczq1I2pF6fUN98YhpYsvHNSFipCK0t9vlJWZv9C5s9z?=
 =?us-ascii?Q?QZb/hEof1MWOF/rPBXgR/ad/9E6wLAJ6/olyjWqvtvHgxpYMZTsXV+hyIRel?=
 =?us-ascii?Q?ViitR/BK1BOTKJ5samVplMgmtQKXGAcO+MSTULQzvT11U7my9o7RRNbeeRZP?=
 =?us-ascii?Q?rE39r9bMEQkVvWCOb033uM7HXblAHO03duJv/J3RbLm3JM1WHLYb5s9pQ5N8?=
 =?us-ascii?Q?jY26ec1TvVcDoS6MvzfrztSWHF+TFgEFhdlkfUeBidgiTueeOc8y2RImfX3B?=
 =?us-ascii?Q?csbg4AFc8RYwEYlMB7GVx109r4Se44wyKwE3ckoIvpAXi5iXDVkgEszMjr5t?=
 =?us-ascii?Q?xvrwr2SuVl3zGF0Fmw9+U+bz5/3+ZvxMrykSX/EGo19ef1i2PjVaviH9t/ty?=
 =?us-ascii?Q?XsWSjq+OnRN8O6IHdy4cnWPfIiBMt9v7p6LQ9p+BiG1OijQAXm3qkI4wFjDa?=
 =?us-ascii?Q?QvP2PypyD0R9aazg+spSw/vOnzDiDsphVkr2LddzZKeKZl3dy31IyBuOKhyX?=
 =?us-ascii?Q?6kRH4cG3q6zLvBw1Jbt1/KwLMP9rA7sfvZ/jWvkDU5QzhyL9/OOUyHIa5+wO?=
 =?us-ascii?Q?D67st9sJ8UKYDIiuKFWgJHWPlkdkM1e5DknT3oQy6AximdajA/RCDKxZxcYw?=
 =?us-ascii?Q?nfkFOxO3hqgzeOcgeASlMP85eOz03bcUugAmwTs5X22OYk8Xw4eJRZ3JWpaU?=
 =?us-ascii?Q?vr9s7Mn8RzTkUNGCE1IOmhPQoCOJHeAWf3rxpD2yxYAzKwc8ZEuH9YImi6U2?=
 =?us-ascii?Q?s5EhetLimKWK8NffL6KDHnQmMppgOl+Yukq0Z+0KaVHcUS3kJsuS+M1DmFjV?=
 =?us-ascii?Q?zKP15LKJ5ZxxDEW4aCVvJHE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DSBHiQZhVL8oqLZttZS6TxPRnOnW93hVf8wHGGhztnwpIjuiZCgUjVC2HNuR?=
 =?us-ascii?Q?vX9mKOGSNN2wjPUEp8A9fKNfwcdX24wrRvb+tW/3sE5f7MENggist9Nhb0HN?=
 =?us-ascii?Q?I9WcpukKvqyCy6dYJfN8JObAGzKm7K2r51V4D9VaIwmFuRsph2na5oLsQ3ut?=
 =?us-ascii?Q?jNEGTd6tt9wHny0Srcbgt0EtMxb7PTLLEaRyMYmR7EknnEqX/G78W3lvkAfN?=
 =?us-ascii?Q?A6KWQd5tZx0jyioEej+1T9wNbtjEphmCdVrsCHQSDh+1u/AcUsqvX/Zxx8+H?=
 =?us-ascii?Q?KFNBmyBV50DbOx2qAiP/+0gKZ36sw3T+9XzpG4mSzeCTYD2H4rdj2t1K6kZO?=
 =?us-ascii?Q?zUeoVWrIW4WUYchpDd0aT16Dteq6Ke0xriPCZ8TPA7gx1IOt+S3jvRe2ZR6B?=
 =?us-ascii?Q?NXtS4bX4BThm+tfd9vcgOGD65NHUtP37wC62DVtdcJZSCOyHJOfPy9rxWP5U?=
 =?us-ascii?Q?IlDPh3B0ILTFJdvVRsTnuTpxjhuhnKg3oiAx94MZtaKd/NDzW3qk+PcGK6tO?=
 =?us-ascii?Q?f2DSUTClhWXT2f69/wT+gST5CWYolKz6v8dwXOs6yQdXJ15bj/nGp5NQaA2e?=
 =?us-ascii?Q?aICjgC2eZytyV9jJjx+n7xxlPVObCBRmZKvo+pKqcXhDmLG72LXYw9lhrG72?=
 =?us-ascii?Q?iNSFeZrzaXB++4aOYg+iGOsxcylEPv+BDEQEN7/KM4SIacsrE6bQ5NOdmZcr?=
 =?us-ascii?Q?Uey9Xro/9UTy9KWRlsps8JnAHGWwZcED+LQOp3A2ENT4F2EP6Z6YEwMV6SDy?=
 =?us-ascii?Q?i+Cpdy89EUNkbH0FJITkU+W6OSrQ0UJs6a+PUkz50sD/Kdnysonmi/knHY9x?=
 =?us-ascii?Q?OwDN+yb/7f3RA99TGZxS7VUYxFGf5q6rCHEni4WautDvLC76EPU0oKvcOCqc?=
 =?us-ascii?Q?w2spetr7TxX9MNK+4HUghNA1kycRi97wRPsUGJ30NjVeNyCOu2q4nvyzKJqo?=
 =?us-ascii?Q?zKcgPFqOnaDjlCj1p/+7/rLVyE2lK9sGk0kH5435/Y1Cp8WXP+IRomaLwOkU?=
 =?us-ascii?Q?EbE38uo0dDvxNO1CLp05DJmBVeOyNRatcgsNbQ/9sS588SQ6OKG4Vb+D4X2o?=
 =?us-ascii?Q?JCfveQUw04FKNFfb7GutLitrk7LEVU3wdXYCKcURXaVwJTc7f9t4kdpXY47K?=
 =?us-ascii?Q?P23whx0jVLpcTNI0oXN80havOTEVv8VmBfB7KzGD2U8n81F1SgZI+Xk9Hq5a?=
 =?us-ascii?Q?1Eu6mEaf2dHW4UMWUNXzNT5jpaAQJGL/5PyFvvYCXanTqcU3h/4We5fHB2FJ?=
 =?us-ascii?Q?jZ7DVG7Wk3tgwMoZXiW3mmu+rCmUJ8MIhuiAO43/09hyewG7N6m0PfyJuoNX?=
 =?us-ascii?Q?hjdjf228Cw2Tp7aI9YE3tLK841p8R8CDnvKZmzrllltn3ku5cI2tVRp5hKFt?=
 =?us-ascii?Q?bxMkQVWgqYMbTirZ0rkNKPfqzSwo/3GqGcBue3I6q7+CR6bGAVXEr8SjT1Ez?=
 =?us-ascii?Q?jK5aUFqm5cGmqIO6y5dnbfuGHe1oJndirtxLktEGTc8sKbeheSis6UrsKone?=
 =?us-ascii?Q?kBOswHAfF1nm4S16m8xkXHTG8jxOk3BzE7Kxb/LlK389IdqD/IE5exkfpD/m?=
 =?us-ascii?Q?mFVB7zbo75LuEM7/87y0LKVj+yM3wFHPx76KgVH4nmx2dxtOFDJtAjHo9Rt2?=
 =?us-ascii?Q?bw2GEHsQP5nEqWVfGrEAm3yLpGdXuOq+JIvRWZXtY1uIe3/WNspYnW6qWr+K?=
 =?us-ascii?Q?PPcjEai4T344KKh6xt9VRkv6cbp1FVqGgw4H6kBMgBCN+bj2MrHfif7oFlKP?=
 =?us-ascii?Q?63Q3YVl0cQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e3a393-b8f6-41f7-10ce-08de59096a43
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:23:30.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tbCoTJGSgcp29rhCypzuu1qgcZYXBQP4k9ZbG+59V3ERf3c/TMT3uLZ6qiYqDHic5qTm0DzUpTIhT+eKoR4YTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Spamd-Result: default: False [0.54 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,microchip.com,infradead.org,wanadoo.fr,lst.de];
	DMARC_POLICY_ALLOW(0.00)[nxp.com,none];
	TAGGED_FROM(0.00)[bounces-8434-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lst.de:email,microchip.com:email]
X-Rspamd-Queue-Id: B97DC5A10F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:12:17PM -0700, Logan Gunthorpe wrote:
> From: Kelvin Cao <kelvin.cao@microchip.com>
>
> Initialize the hardware and create the dma channel queues.
>
> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
> Co-developed-by: George Ge <george.ge@microchip.com>
> Signed-off-by: George Ge <george.ge@microchip.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/dma/switchtec_dma.c | 1007 ++++++++++++++++++++++++++++++++++-

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  1 file changed, 1005 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/switchtec_dma.c b/drivers/dma/switchtec_dma.c
> index bedc72d9c0ef..33c48335d59d 100644
> --- a/drivers/dma/switchtec_dma.c
> +++ b/drivers/dma/switchtec_dma.c
> @@ -19,16 +19,976 @@ MODULE_DESCRIPTION("Switchtec PCIe Switch DMA Engine");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Kelvin Cao");
>
> +#define	SWITCHTEC_DMAC_CHAN_CTRL_OFFSET		0x1000
> +#define	SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET	0x160000
> +
> +#define SWITCHTEC_DMA_CHAN_HW_REGS_SIZE		0x1000
> +#define SWITCHTEC_DMA_CHAN_FW_REGS_SIZE		0x80
> +
> +#define SWITCHTEC_REG_CAP		0x80
> +#define SWITCHTEC_REG_CHAN_CNT		0x84
> +#define SWITCHTEC_REG_TAG_LIMIT		0x90
> +#define SWITCHTEC_REG_CHAN_STS_VEC	0x94
> +#define SWITCHTEC_REG_SE_BUF_CNT	0x98
> +#define SWITCHTEC_REG_SE_BUF_BASE	0x9a
> +
> +#define SWITCHTEC_CHAN_CTRL_PAUSE	BIT(0)
> +#define SWITCHTEC_CHAN_CTRL_HALT	BIT(1)
> +#define SWITCHTEC_CHAN_CTRL_RESET	BIT(2)
> +#define SWITCHTEC_CHAN_CTRL_ERR_PAUSE	BIT(3)
> +
> +#define SWITCHTEC_CHAN_STS_PAUSED	BIT(9)
> +#define SWITCHTEC_CHAN_STS_HALTED	BIT(10)
> +#define SWITCHTEC_CHAN_STS_PAUSED_MASK	GENMASK(29, 13)
> +
> +#define SWITCHTEC_DMA_SQ_SIZE	SZ_32K
> +#define SWITCHTEC_DMA_CQ_SIZE	SZ_32K
> +
> +#define SWITCHTEC_DMA_RING_SIZE	SZ_32K
> +
> +static const char * const channel_status_str[] = {
> +	[13] = "received a VDM with length error status",
> +	[14] = "received a VDM or Cpl with Unsupported Request error status",
> +	[15] = "received a VDM or Cpl with Completion Abort error status",
> +	[16] = "received a VDM with ECRC error status",
> +	[17] = "received a VDM with EP error status",
> +	[18] = "received a VDM with Reserved Cpl error status",
> +	[19] = "received only part of split SE CplD",
> +	[20] = "the ISP_DMAC detected a Completion Time Out",
> +	[21] = "received a Cpl with Unsupported Request status",
> +	[22] = "received a Cpl with Completion Abort status",
> +	[23] = "received a Cpl with a reserved status",
> +	[24] = "received a TLP with ECRC error status in its metadata",
> +	[25] = "received a TLP with the EP bit set in the header",
> +	[26] = "the ISP_DMAC tried to process a SE with an invalid Connection ID",
> +	[27] = "the ISP_DMAC tried to process a SE with an invalid Remote Host interrupt",
> +	[28] = "a reserved opcode was detected in an SE",
> +	[29] = "received a SE Cpl with error status",
> +};
> +
> +struct chan_hw_regs {
> +	u16 cq_head;
> +	u16 rsvd1;
> +	u16 sq_tail;
> +	u16 rsvd2;
> +	u8 ctrl;
> +	u8 rsvd3[3];
> +	u16 status;
> +	u16 rsvd4;
> +};
> +
> +#define PERF_BURST_SCALE_MASK	GENMASK_U32(3,   2)
> +#define PERF_MRRS_MASK		GENMASK_U32(6,   4)
> +#define PERF_INTERVAL_MASK	GENMASK_U32(10,  8)
> +#define PERF_BURST_SIZE_MASK	GENMASK_U32(14, 12)
> +#define PERF_ARB_WEIGHT_MASK	GENMASK_U32(31, 24)
> +
> +#define SE_BUF_BASE_MASK	GENMASK_U32(10,  2)
> +#define SE_BUF_LEN_MASK		GENMASK_U32(20, 12)
> +#define SE_THRESH_MASK		GENMASK_U32(31, 23)
> +
> +#define SWITCHTEC_CHAN_ENABLE	BIT(1)
> +
> +struct chan_fw_regs {
> +	u32 valid_en_se;
> +	u32 cq_base_lo;
> +	u32 cq_base_hi;
> +	u16 cq_size;
> +	u16 rsvd1;
> +	u32 sq_base_lo;
> +	u32 sq_base_hi;
> +	u16 sq_size;
> +	u16 rsvd2;
> +	u32 int_vec;
> +	u32 perf_cfg;
> +	u32 rsvd3;
> +	u32 perf_latency_selector;
> +	u32 perf_fetched_se_cnt_lo;
> +	u32 perf_fetched_se_cnt_hi;
> +	u32 perf_byte_cnt_lo;
> +	u32 perf_byte_cnt_hi;
> +	u32 rsvd4;
> +	u16 perf_se_pending;
> +	u16 perf_se_buf_empty;
> +	u32 perf_chan_idle;
> +	u32 perf_lat_max;
> +	u32 perf_lat_min;
> +	u32 perf_lat_last;
> +	u16 sq_current;
> +	u16 sq_phase;
> +	u16 cq_current;
> +	u16 cq_phase;
> +};
> +
> +struct switchtec_dma_chan {
> +	struct switchtec_dma_dev *swdma_dev;
> +	struct dma_chan dma_chan;
> +	struct chan_hw_regs __iomem *mmio_chan_hw;
> +	struct chan_fw_regs __iomem *mmio_chan_fw;
> +
> +	/* Serialize hardware control register access */
> +	spinlock_t hw_ctrl_lock;
> +
> +	struct tasklet_struct desc_task;
> +
> +	/* Serialize descriptor preparation */
> +	spinlock_t submit_lock;
> +	bool ring_active;
> +	int cid;
> +
> +	/* Serialize completion processing */
> +	spinlock_t complete_lock;
> +	bool comp_ring_active;
> +
> +	/* channel index and irq */
> +	int index;
> +	int irq;
> +
> +	/*
> +	 * In driver context, head is advanced by producer while
> +	 * tail is advanced by consumer.
> +	 */
> +
> +	/* the head and tail for both desc_ring and hw_sq */
> +	int head;
> +	int tail;
> +	int phase_tag;
> +	struct switchtec_dma_hw_se_desc *hw_sq;
> +	dma_addr_t dma_addr_sq;
> +
> +	/* the tail for hw_cq */
> +	int cq_tail;
> +	struct switchtec_dma_hw_ce *hw_cq;
> +	dma_addr_t dma_addr_cq;
> +
> +	struct list_head list;
> +
> +	struct switchtec_dma_desc *desc_ring[SWITCHTEC_DMA_RING_SIZE];
> +};
> +
>  struct switchtec_dma_dev {
>  	struct dma_device dma_dev;
>  	struct pci_dev __rcu *pdev;
>  	void __iomem *bar;
> +
> +	struct switchtec_dma_chan **swdma_chans;
> +	int chan_cnt;
> +	int chan_status_irq;
> +};
> +
> +enum chan_op {
> +	ENABLE_CHAN,
> +	DISABLE_CHAN,
> +};
> +
> +enum switchtec_dma_opcode {
> +	SWITCHTEC_DMA_OPC_MEMCPY = 0,
> +	SWITCHTEC_DMA_OPC_RDIMM = 0x1,
> +	SWITCHTEC_DMA_OPC_WRIMM = 0x2,
> +	SWITCHTEC_DMA_OPC_RHI = 0x6,
> +	SWITCHTEC_DMA_OPC_NOP = 0x7,
> +};
> +
> +struct switchtec_dma_hw_se_desc {
> +	u8 opc;
> +	u8 ctrl;
> +	__le16 tlp_setting;
> +	__le16 rsvd1;
> +	__le16 cid;
> +	__le32 byte_cnt;
> +	__le32 addr_lo; /* SADDR_LO/WIADDR_LO */
> +	__le32 addr_hi; /* SADDR_HI/WIADDR_HI */
> +	__le32 daddr_lo;
> +	__le32 daddr_hi;
> +	__le16 dfid;
> +	__le16 sfid;
> +};
> +
> +#define SWITCHTEC_CE_SC_LEN_ERR		BIT(0)
> +#define SWITCHTEC_CE_SC_UR		BIT(1)
> +#define SWITCHTEC_CE_SC_CA		BIT(2)
> +#define SWITCHTEC_CE_SC_RSVD_CPL	BIT(3)
> +#define SWITCHTEC_CE_SC_ECRC_ERR	BIT(4)
> +#define SWITCHTEC_CE_SC_EP_SET		BIT(5)
> +#define SWITCHTEC_CE_SC_D_RD_CTO	BIT(8)
> +#define SWITCHTEC_CE_SC_D_RIMM_UR	BIT(9)
> +#define SWITCHTEC_CE_SC_D_RIMM_CA	BIT(10)
> +#define SWITCHTEC_CE_SC_D_RIMM_RSVD_CPL	BIT(11)
> +#define SWITCHTEC_CE_SC_D_ECRC		BIT(12)
> +#define SWITCHTEC_CE_SC_D_EP_SET	BIT(13)
> +#define SWITCHTEC_CE_SC_D_BAD_CONNID	BIT(14)
> +#define SWITCHTEC_CE_SC_D_BAD_RHI_ADDR	BIT(15)
> +#define SWITCHTEC_CE_SC_D_INVD_CMD	BIT(16)
> +#define SWITCHTEC_CE_SC_MASK		GENMASK(16, 0)
> +
> +struct switchtec_dma_hw_ce {
> +	__le32 rdimm_cpl_dw0;
> +	__le32 rdimm_cpl_dw1;
> +	__le32 rsvd1;
> +	__le32 cpl_byte_cnt;
> +	__le16 sq_head;
> +	__le16 rsvd2;
> +	__le32 rsvd3;
> +	__le32 sts_code;
> +	__le16 cid;
> +	__le16 phase_tag;
> +};
> +
> +struct switchtec_dma_desc {
> +	struct dma_async_tx_descriptor txd;
> +	struct switchtec_dma_hw_se_desc *hw;
> +	u32 orig_size;
> +	bool completed;
>  };
>
> +static int wait_for_chan_status(struct chan_hw_regs __iomem *chan_hw, u32 mask,
> +				bool set)
> +{
> +	u32 status;
> +
> +	return readl_poll_timeout_atomic(&chan_hw->status, status,
> +					 (set && (status & mask)) ||
> +					 (!set && !(status & mask)),
> +					 10, 100 * USEC_PER_MSEC);
> +}
> +
> +static int halt_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_HALT, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, true);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static int unhalt_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +	u8 ctrl;
> +	int ret;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		ret = -ENODEV;
> +		goto unlock_and_exit;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	ctrl = readb(&chan_hw->ctrl);
> +	ctrl &= ~SWITCHTEC_CHAN_CTRL_HALT;
> +	writeb(ctrl, &chan_hw->ctrl);
> +	ret = wait_for_chan_status(chan_hw, SWITCHTEC_CHAN_STS_HALTED, false);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +unlock_and_exit:
> +	rcu_read_unlock();
> +	return ret;
> +}
> +
> +static void flush_pci_write(struct chan_hw_regs __iomem *chan_hw)
> +{
> +	readl(&chan_hw->cq_head);
> +}
> +
> +static int reset_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writel(SWITCHTEC_CHAN_CTRL_RESET | SWITCHTEC_CHAN_CTRL_ERR_PAUSE,
> +	       &chan_hw->ctrl);
> +	flush_pci_write(chan_hw);
> +
> +	udelay(1000);
> +
> +	writel(SWITCHTEC_CHAN_CTRL_ERR_PAUSE, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +	flush_pci_write(chan_hw);
> +
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static int pause_reset_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct chan_hw_regs __iomem *chan_hw = swdma_chan->mmio_chan_hw;
> +	struct pci_dev *pdev;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	spin_lock(&swdma_chan->hw_ctrl_lock);
> +	writeb(SWITCHTEC_CHAN_CTRL_PAUSE, &chan_hw->ctrl);
> +	spin_unlock(&swdma_chan->hw_ctrl_lock);
> +
> +	flush_pci_write(chan_hw);
> +
> +	rcu_read_unlock();
> +
> +	/* wait 60ms to ensure no pending CEs */
> +	mdelay(60);
> +
> +	return reset_channel(swdma_chan);
> +}
> +
> +static int channel_op(struct switchtec_dma_chan *swdma_chan, int op)
> +{
> +	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
> +	struct pci_dev *pdev;
> +	u32 valid_en_se;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	valid_en_se = readl(&chan_fw->valid_en_se);
> +	if (op == ENABLE_CHAN)
> +		valid_en_se |= SWITCHTEC_CHAN_ENABLE;
> +	else
> +		valid_en_se &= ~SWITCHTEC_CHAN_ENABLE;
> +
> +	writel(valid_en_se, &chan_fw->valid_en_se);
> +
> +	rcu_read_unlock();
> +	return 0;
> +}
> +
> +static int enable_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	return channel_op(swdma_chan, ENABLE_CHAN);
> +}
> +
> +static int disable_channel(struct switchtec_dma_chan *swdma_chan)
> +{
> +	return channel_op(swdma_chan, DISABLE_CHAN);
> +}
> +
> +static void
> +switchtec_dma_cleanup_completed(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct device *chan_dev = &swdma_chan->dma_chan.dev->device;
> +	struct switchtec_dma_desc *desc;
> +	struct switchtec_dma_hw_ce *ce;
> +	struct dmaengine_result res;
> +	int tail, cid, se_idx, i;
> +	__le16 phase_tag;
> +	u32 sts_code;
> +	__le32 *p;
> +
> +	do {
> +		spin_lock_bh(&swdma_chan->complete_lock);
> +		if (!swdma_chan->comp_ring_active) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			break;
> +		}
> +
> +		ce = &swdma_chan->hw_cq[swdma_chan->cq_tail];
> +		/*
> +		 * phase_tag is updated by hardware, ensure the value is
> +		 * not from the cache
> +		 */
> +		phase_tag = smp_load_acquire(&ce->phase_tag);
> +		if (le16_to_cpu(phase_tag) == swdma_chan->phase_tag) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			break;
> +		}
> +
> +		cid = le16_to_cpu(ce->cid);
> +		se_idx = cid & (SWITCHTEC_DMA_SQ_SIZE - 1);
> +		desc = swdma_chan->desc_ring[se_idx];
> +
> +		tail = swdma_chan->tail;
> +
> +		res.residue = desc->orig_size - le32_to_cpu(ce->cpl_byte_cnt);
> +
> +		sts_code = le32_to_cpu(ce->sts_code);
> +
> +		if (!(sts_code & SWITCHTEC_CE_SC_MASK)) {
> +			res.result = DMA_TRANS_NOERROR;
> +		} else {
> +			if (sts_code & SWITCHTEC_CE_SC_D_RD_CTO)
> +				res.result = DMA_TRANS_READ_FAILED;
> +			else
> +				res.result = DMA_TRANS_WRITE_FAILED;
> +
> +			dev_err(chan_dev, "CID 0x%04x failed, SC 0x%08x\n", cid,
> +				(u32)(sts_code & SWITCHTEC_CE_SC_MASK));
> +
> +			p = (__le32 *)ce;
> +			for (i = 0; i < sizeof(*ce) / 4; i++) {
> +				dev_err(chan_dev, "CE DW%d: 0x%08x\n", i,
> +					le32_to_cpu(*p));
> +				p++;
> +			}
> +		}
> +
> +		desc->completed = true;
> +
> +		swdma_chan->cq_tail++;
> +		swdma_chan->cq_tail &= SWITCHTEC_DMA_CQ_SIZE - 1;
> +
> +		rcu_read_lock();
> +		if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +			rcu_read_unlock();
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			return;
> +		}
> +		writew(swdma_chan->cq_tail, &swdma_chan->mmio_chan_hw->cq_head);
> +		rcu_read_unlock();
> +
> +		if (swdma_chan->cq_tail == 0)
> +			swdma_chan->phase_tag = !swdma_chan->phase_tag;
> +
> +		/*  Out of order CE */
> +		if (se_idx != tail) {
> +			spin_unlock_bh(&swdma_chan->complete_lock);
> +			continue;
> +		}
> +
> +		do {
> +			dma_cookie_complete(&desc->txd);
> +			dma_descriptor_unmap(&desc->txd);
> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> +			desc->txd.callback = NULL;
> +			desc->txd.callback_result = NULL;
> +			desc->completed = false;
> +
> +			tail++;
> +			tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
> +
> +			/*
> +			 * Ensure the desc updates are visible before updating
> +			 * the tail index
> +			 */
> +			smp_store_release(&swdma_chan->tail, tail);
> +			desc = swdma_chan->desc_ring[swdma_chan->tail];
> +			if (!desc->completed)
> +				break;
> +		} while (CIRC_CNT(READ_ONCE(swdma_chan->head), swdma_chan->tail,
> +				  SWITCHTEC_DMA_SQ_SIZE));
> +
> +		spin_unlock_bh(&swdma_chan->complete_lock);
> +	} while (1);
> +}
> +
> +static void
> +switchtec_dma_abort_desc(struct switchtec_dma_chan *swdma_chan, int force)
> +{
> +	struct switchtec_dma_desc *desc;
> +	struct dmaengine_result res;
> +
> +	if (!force)
> +		switchtec_dma_cleanup_completed(swdma_chan);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +
> +	while (CIRC_CNT(swdma_chan->head, swdma_chan->tail,
> +			SWITCHTEC_DMA_SQ_SIZE) >= 1) {
> +		desc = swdma_chan->desc_ring[swdma_chan->tail];
> +
> +		res.residue = desc->orig_size;
> +		res.result = DMA_TRANS_ABORTED;
> +
> +		dma_cookie_complete(&desc->txd);
> +		dma_descriptor_unmap(&desc->txd);
> +		if (!force)
> +			dmaengine_desc_get_callback_invoke(&desc->txd, &res);
> +		desc->txd.callback = NULL;
> +		desc->txd.callback_result = NULL;
> +
> +		swdma_chan->tail++;
> +		swdma_chan->tail &= SWITCHTEC_DMA_SQ_SIZE - 1;
> +	}
> +
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +}
> +
> +static void switchtec_dma_chan_stop(struct switchtec_dma_chan *swdma_chan)
> +{
> +	int rc;
> +
> +	rc = halt_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_chan->swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return;
> +	}
> +
> +	writel(0, &swdma_chan->mmio_chan_fw->sq_base_lo);
> +	writel(0, &swdma_chan->mmio_chan_fw->sq_base_hi);
> +	writel(0, &swdma_chan->mmio_chan_fw->cq_base_lo);
> +	writel(0, &swdma_chan->mmio_chan_fw->cq_base_hi);
> +
> +	rcu_read_unlock();
> +}
> +
> +static int switchtec_dma_terminate_all(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +
> +	return pause_reset_channel(swdma_chan);
> +}
> +
> +static void switchtec_dma_synchronize(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +
> +	int rc;
> +
> +	switchtec_dma_abort_desc(swdma_chan, 1);
> +
> +	rc = enable_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rc = reset_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	rc = unhalt_channel(swdma_chan);
> +	if (rc)
> +		return;
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->head = 0;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = true;
> +	swdma_chan->phase_tag = 0;
> +	swdma_chan->tail = 0;
> +	swdma_chan->cq_tail = 0;
> +	swdma_chan->cid = 0;
> +	dma_cookie_init(chan);
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +}
> +
> +static void switchtec_dma_desc_task(unsigned long data)
> +{
> +	struct switchtec_dma_chan *swdma_chan = (void *)data;
> +
> +	switchtec_dma_cleanup_completed(swdma_chan);
> +}
> +
> +static irqreturn_t switchtec_dma_isr(int irq, void *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = chan;
> +
> +	if (swdma_chan->comp_ring_active)
> +		tasklet_schedule(&swdma_chan->desc_task);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
> +{
> +	struct switchtec_dma_dev *swdma_dev = dma;
> +	struct dma_device *dma_dev = &swdma_dev->dma_dev;
> +	struct switchtec_dma_chan *swdma_chan;
> +	struct chan_hw_regs __iomem *chan_hw;
> +	struct device *chan_dev;
> +	struct dma_chan *chan;
> +	u32 chan_status;
> +	int bit;
> +
> +	list_for_each_entry(chan, &dma_dev->channels, device_node) {
> +		swdma_chan = container_of(chan, struct switchtec_dma_chan,
> +					  dma_chan);
> +		chan_dev = &swdma_chan->dma_chan.dev->device;
> +		chan_hw = swdma_chan->mmio_chan_hw;
> +
> +		rcu_read_lock();
> +		if (!rcu_dereference(swdma_dev->pdev)) {
> +			rcu_read_unlock();
> +			goto out;
> +		}
> +
> +		chan_status = readl(&chan_hw->status);
> +		chan_status &= SWITCHTEC_CHAN_STS_PAUSED_MASK;
> +		rcu_read_unlock();
> +
> +		bit = ffs(chan_status);
> +		if (!bit)
> +			dev_dbg(chan_dev, "No pause bit set.\n");
> +		else
> +			dev_err(chan_dev, "Paused, %s\n",
> +				channel_status_str[bit - 1]);
> +	}
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +
> +static void switchtec_dma_free_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	size_t size;
> +	int i;
> +
> +	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
> +	if (swdma_chan->hw_sq)
> +		dma_free_coherent(swdma_dev->dma_dev.dev, size,
> +				  swdma_chan->hw_sq, swdma_chan->dma_addr_sq);
> +
> +	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
> +	if (swdma_chan->hw_cq)
> +		dma_free_coherent(swdma_dev->dma_dev.dev, size,
> +				  swdma_chan->hw_cq, swdma_chan->dma_addr_cq);
> +
> +	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++)
> +		kfree(swdma_chan->desc_ring[i]);
> +}
> +
> +static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
> +	struct switchtec_dma_desc *desc;
> +	struct pci_dev *pdev;
> +	size_t size;
> +	int rc, i;
> +
> +	swdma_chan->head = 0;
> +	swdma_chan->tail = 0;
> +	swdma_chan->cq_tail = 0;
> +
> +	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
> +	swdma_chan->hw_sq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_sq,
> +					       GFP_NOWAIT);
> +	if (!swdma_chan->hw_sq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
> +	swdma_chan->hw_cq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_cq,
> +					       GFP_NOWAIT);
> +	if (!swdma_chan->hw_cq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	/* reset host phase tag */
> +	swdma_chan->phase_tag = 0;
> +
> +	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
> +		desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
> +		if (!desc) {
> +			rc = -ENOMEM;
> +			goto free_and_exit;
> +		}
> +
> +		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
> +		desc->hw = &swdma_chan->hw_sq[i];
> +		desc->completed = true;
> +
> +		swdma_chan->desc_ring[i] = desc;
> +	}
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		rc = -ENODEV;
> +		goto free_and_exit;
> +	}
> +
> +	/* set sq/cq */
> +	writel(lower_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_lo);
> +	writel(upper_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_hi);
> +	writel(lower_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_lo);
> +	writel(upper_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_hi);
> +
> +	writew(SWITCHTEC_DMA_SQ_SIZE, &swdma_chan->mmio_chan_fw->sq_size);
> +	writew(SWITCHTEC_DMA_CQ_SIZE, &swdma_chan->mmio_chan_fw->cq_size);
> +
> +	rcu_read_unlock();
> +	return 0;
> +
> +free_and_exit:
> +	switchtec_dma_free_desc(swdma_chan);
> +	return rc;
> +}
> +
> +static int switchtec_dma_alloc_chan_resources(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	u32 perf_cfg;
> +	int rc;
> +
> +	rc = switchtec_dma_alloc_desc(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	rc = enable_channel(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	rc = reset_channel(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	rc = unhalt_channel(swdma_chan);
> +	if (rc)
> +		return rc;
> +
> +	swdma_chan->ring_active = true;
> +	swdma_chan->comp_ring_active = true;
> +	swdma_chan->cid = 0;
> +
> +	dma_cookie_init(chan);
> +
> +	rcu_read_lock();
> +	if (!rcu_dereference(swdma_dev->pdev)) {
> +		rcu_read_unlock();
> +		return -ENODEV;
> +	}
> +
> +	perf_cfg = readl(&swdma_chan->mmio_chan_fw->perf_cfg);
> +	rcu_read_unlock();
> +
> +	dev_dbg(&chan->dev->device, "Burst Size:  0x%x\n",
> +		FIELD_GET(PERF_BURST_SIZE_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "Burst Scale: 0x%x\n",
> +		FIELD_GET(PERF_BURST_SCALE_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "Interval:    0x%x\n",
> +		FIELD_GET(PERF_INTERVAL_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "Arb Weight:  0x%x\n",
> +		FIELD_GET(PERF_ARB_WEIGHT_MASK, perf_cfg));
> +
> +	dev_dbg(&chan->dev->device, "MRRS:        0x%x\n",
> +		FIELD_GET(PERF_MRRS_MASK, perf_cfg));
> +
> +	return SWITCHTEC_DMA_SQ_SIZE;
> +}
> +
> +static void switchtec_dma_free_chan_resources(struct dma_chan *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan =
> +		container_of(chan, struct switchtec_dma_chan, dma_chan);
> +
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->ring_active = false;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +
> +	switchtec_dma_chan_stop(swdma_chan);
> +	switchtec_dma_abort_desc(swdma_chan, 0);
> +	switchtec_dma_free_desc(swdma_chan);
> +
> +	disable_channel(swdma_chan);
> +}
> +
> +static int switchtec_dma_chan_init(struct switchtec_dma_dev *swdma_dev,
> +				   struct pci_dev *pdev, int i)
> +{
> +	struct dma_device *dma = &swdma_dev->dma_dev;
> +	struct switchtec_dma_chan *swdma_chan;
> +	u32 valid_en_se, thresh;
> +	int se_buf_len, irq, rc;
> +	struct dma_chan *chan;
> +
> +	swdma_chan = kzalloc(sizeof(*swdma_chan), GFP_KERNEL);
> +	if (!swdma_chan)
> +		return -ENOMEM;
> +
> +	swdma_chan->phase_tag = 0;
> +	swdma_chan->index = i;
> +	swdma_chan->swdma_dev = swdma_dev;
> +
> +	spin_lock_init(&swdma_chan->hw_ctrl_lock);
> +	spin_lock_init(&swdma_chan->submit_lock);
> +	spin_lock_init(&swdma_chan->complete_lock);
> +	tasklet_init(&swdma_chan->desc_task, switchtec_dma_desc_task,
> +		     (unsigned long)swdma_chan);
> +
> +	swdma_chan->mmio_chan_fw =
> +		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET +
> +		i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;
> +	swdma_chan->mmio_chan_hw =
> +		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET +
> +		i * SWITCHTEC_DMA_CHAN_HW_REGS_SIZE;
> +
> +	swdma_dev->swdma_chans[i] = swdma_chan;
> +
> +	rc = pause_reset_channel(swdma_chan);
> +	if (rc)
> +		goto free_and_exit;
> +
> +	/* init perf tuner */
> +	writel(FIELD_PREP(PERF_BURST_SCALE_MASK, 1) |
> +	       FIELD_PREP(PERF_MRRS_MASK, 3) |
> +	       FIELD_PREP(PERF_BURST_SIZE_MASK, 6) |
> +	       FIELD_PREP(PERF_ARB_WEIGHT_MASK, 1),
> +	       &swdma_chan->mmio_chan_fw->perf_cfg);
> +
> +	valid_en_se = readl(&swdma_chan->mmio_chan_fw->valid_en_se);
> +
> +	dev_dbg(&pdev->dev, "Channel %d: SE buffer base %d\n", i,
> +		FIELD_GET(SE_BUF_BASE_MASK, valid_en_se));
> +
> +	se_buf_len = FIELD_GET(SE_BUF_LEN_MASK, valid_en_se);
> +	dev_dbg(&pdev->dev, "Channel %d: SE buffer count %d\n", i, se_buf_len);
> +
> +	thresh = se_buf_len / 2;
> +	valid_en_se |= FIELD_GET(SE_THRESH_MASK, thresh);
> +	writel(valid_en_se, &swdma_chan->mmio_chan_fw->valid_en_se);
> +
> +	/* request irqs */
> +	irq = readl(&swdma_chan->mmio_chan_fw->int_vec);
> +	dev_dbg(&pdev->dev, "Channel %d: CE irq vector %d\n", i, irq);
> +
> +	rc = pci_request_irq(pdev, irq, switchtec_dma_isr, NULL, swdma_chan,
> +			     KBUILD_MODNAME);
> +	if (rc)
> +		goto free_and_exit;
> +
> +	swdma_chan->irq = irq;
> +
> +	chan = &swdma_chan->dma_chan;
> +	chan->device = dma;
> +	dma_cookie_init(chan);
> +
> +	list_add_tail(&chan->device_node, &dma->channels);
> +
> +	return 0;
> +
> +free_and_exit:
> +	kfree(swdma_chan);
> +	return rc;
> +}
> +
> +static int switchtec_dma_chan_free(struct pci_dev *pdev,
> +				   struct switchtec_dma_chan *swdma_chan)
> +{
> +	spin_lock_bh(&swdma_chan->submit_lock);
> +	swdma_chan->ring_active = false;
> +	spin_unlock_bh(&swdma_chan->submit_lock);
> +
> +	spin_lock_bh(&swdma_chan->complete_lock);
> +	swdma_chan->comp_ring_active = false;
> +	spin_unlock_bh(&swdma_chan->complete_lock);
> +
> +	pci_free_irq(pdev, swdma_chan->irq, swdma_chan);
> +	tasklet_kill(&swdma_chan->desc_task);
> +
> +	switchtec_dma_chan_stop(swdma_chan);
> +
> +	return 0;
> +}
> +
> +static int switchtec_dma_chans_release(struct pci_dev *pdev,
> +				       struct switchtec_dma_dev *swdma_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
> +		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
> +
> +	return 0;
> +}
> +
> +static int switchtec_dma_chans_enumerate(struct switchtec_dma_dev *swdma_dev,
> +					 struct pci_dev *pdev, int chan_cnt)
> +{
> +	struct dma_device *dma = &swdma_dev->dma_dev;
> +	int base, cnt, rc, i;
> +
> +	swdma_dev->swdma_chans = kcalloc(chan_cnt, sizeof(*swdma_dev->swdma_chans),
> +					 GFP_KERNEL);
> +
> +	if (!swdma_dev->swdma_chans)
> +		return -ENOMEM;
> +
> +	base = readw(swdma_dev->bar + SWITCHTEC_REG_SE_BUF_BASE);
> +	cnt = readw(swdma_dev->bar + SWITCHTEC_REG_SE_BUF_CNT);
> +
> +	dev_dbg(&pdev->dev, "EP SE buffer base %d\n", base);
> +	dev_dbg(&pdev->dev, "EP SE buffer count %d\n", cnt);
> +
> +	INIT_LIST_HEAD(&dma->channels);
> +
> +	for (i = 0; i < chan_cnt; i++) {
> +		rc = switchtec_dma_chan_init(swdma_dev, pdev, i);
> +		if (rc) {
> +			dev_err(&pdev->dev, "Channel %d: init channel failed\n",
> +				i);
> +			chan_cnt = i;
> +			goto err_exit;
> +		}
> +	}
> +
> +	return chan_cnt;
> +
> +err_exit:
> +	for (i = 0; i < chan_cnt; i++)
> +		switchtec_dma_chan_free(pdev, swdma_dev->swdma_chans[i]);
> +
> +	kfree(swdma_dev->swdma_chans);
> +
> +	return rc;
> +}
> +
>  static void switchtec_dma_release(struct dma_device *dma_dev)
>  {
>  	struct switchtec_dma_dev *swdma_dev =
>  		container_of(dma_dev, struct switchtec_dma_dev, dma_dev);
> +	int i;
> +
> +	for (i = 0; i < swdma_dev->chan_cnt; i++)
> +		kfree(swdma_dev->swdma_chans[i]);
> +
> +	kfree(swdma_dev->swdma_chans);
>
>  	put_device(dma_dev->dev);
>  	kfree(swdma_dev);
> @@ -37,9 +997,9 @@ static void switchtec_dma_release(struct dma_device *dma_dev)
>  static int switchtec_dma_create(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev;
> +	int chan_cnt, nr_vecs, irq, rc;
>  	struct dma_device *dma;
>  	struct dma_chan *chan;
> -	int nr_vecs, rc;
>
>  	/*
>  	 * Create the switchtec dma device
> @@ -58,18 +1018,51 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>  	if (rc < 0)
>  		goto err_exit;
>
> +	irq = readw(swdma_dev->bar + SWITCHTEC_REG_CHAN_STS_VEC);
> +	pci_dbg(pdev, "Channel pause irq vector %d\n", irq);
> +
> +	rc = pci_request_irq(pdev, irq, NULL, switchtec_dma_chan_status_isr,
> +			     swdma_dev, KBUILD_MODNAME);
> +	if (rc)
> +		goto err_exit;
> +
> +	swdma_dev->chan_status_irq = irq;
> +
> +	chan_cnt = readl(swdma_dev->bar + SWITCHTEC_REG_CHAN_CNT);
> +	if (!chan_cnt) {
> +		pci_err(pdev, "No channel configured.\n");
> +		rc = -ENXIO;
> +		goto err_exit;
> +	}
> +
> +	chan_cnt = switchtec_dma_chans_enumerate(swdma_dev, pdev, chan_cnt);
> +	if (chan_cnt < 0) {
> +		pci_err(pdev, "Failed to enumerate dma channels: %d\n",
> +			chan_cnt);
> +		rc = -ENXIO;
> +		goto err_exit;
> +	}
> +
> +	swdma_dev->chan_cnt = chan_cnt;
> +
>  	dma = &swdma_dev->dma_dev;
>  	dma->copy_align = DMAENGINE_ALIGN_8_BYTES;
>  	dma->dev = get_device(&pdev->dev);
>
> +	dma->device_alloc_chan_resources = switchtec_dma_alloc_chan_resources;
> +	dma->device_free_chan_resources = switchtec_dma_free_chan_resources;
> +	dma->device_terminate_all = switchtec_dma_terminate_all;
> +	dma->device_synchronize = switchtec_dma_synchronize;
>  	dma->device_release = switchtec_dma_release;
>
>  	rc = dma_async_device_register(dma);
>  	if (rc) {
>  		pci_err(pdev, "Failed to register dma device: %d\n", rc);
> -		goto err_exit;
> +		goto err_chans_release_exit;
>  	}
>
> +	pci_dbg(pdev, "Channel count: %d\n", chan_cnt);
> +
>  	list_for_each_entry(chan, &dma->channels, device_node)
>  		pci_dbg(pdev, "%s\n", dma_chan_name(chan));
>
> @@ -77,7 +1070,13 @@ static int switchtec_dma_create(struct pci_dev *pdev)
>
>  	return 0;
>
> +err_chans_release_exit:
> +	switchtec_dma_chans_release(pdev, swdma_dev);
> +
>  err_exit:
> +	if (swdma_dev->chan_status_irq)
> +		free_irq(swdma_dev->chan_status_irq, swdma_dev);
> +
>  	iounmap(swdma_dev->bar);
>  	kfree(swdma_dev);
>  	return rc;
> @@ -120,9 +1119,13 @@ static void switchtec_dma_remove(struct pci_dev *pdev)
>  {
>  	struct switchtec_dma_dev *swdma_dev = pci_get_drvdata(pdev);
>
> +	switchtec_dma_chans_release(pdev, swdma_dev);
> +
>  	rcu_assign_pointer(swdma_dev->pdev, NULL);
>  	synchronize_rcu();
>
> +	pci_free_irq(pdev, swdma_dev->chan_status_irq, swdma_dev);
> +
>  	pci_free_irq_vectors(pdev);
>
>  	dma_async_device_unregister(&swdma_dev->dma_dev);
> --
> 2.47.3
>

