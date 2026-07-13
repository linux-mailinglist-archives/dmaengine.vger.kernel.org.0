Return-Path: <dmaengine+bounces-12404-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pfRQKIMaVWrtjwAAu9opvQ
	(envelope-from <dmaengine+bounces-12404-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A10974DD66
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 19:04:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=oyMXuKmQ;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12404-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12404-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D1DB23011E8A
	for <lists+dmaengine@lfdr.de>; Mon, 13 Jul 2026 17:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB687318EC5;
	Mon, 13 Jul 2026 17:03:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013011.outbound.protection.outlook.com [40.107.159.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1AB33A9FF;
	Mon, 13 Jul 2026 17:03:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962225; cv=fail; b=BzZRweejcxjWDlXUR4uqDrqYDh1fxTmJPOQ4/8CEEwtGzpQVrbt9vSnq2GeyOnML7tnN9EG4DOn+tJjEWIl7rFcEo41dWrN9pGKNriyCAFdETb0+N2JM5PPndAmGmxvFNHk5Ig3Ei1zyLP4XJShQLFW+pmIyAnkxRUqQD4Seun0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962225; c=relaxed/simple;
	bh=cpz8GRuPExru71006rn59M+A7p0//p6E6JrZ0/eoEas=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=QDOoDoDFdjLxT9mTCaXz0KnuFB2k5cYCoKJf6HU7PdguVuBATkyP8OVk4d4sb7kYDh887jcKawsM75B16Okk23Go3qAN3hwwilmF74GErrBs04OGh7cBS0FYaBBxuCO7Q8o0n5LVxB8Nn8vva5uUuveCRjIadXDxDzFFG/kQ4ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=oyMXuKmQ; arc=fail smtp.client-ip=40.107.159.11
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+lJRdfR/BwAJGl8NJ3WlO4ryAPs8ObGYdCKf5Hk/D+nR+WablBza7iLEJm08i7asbZFsxFWdqPvtET3FG8ppTBS6dx8wxygHYI/oknNIt3Gke3Y2nPKP9s/s6ubAvd2ztfJ82CVNT0zti8VHC2yxDQefkvHa1iXtKjz9pm0HjkbglHfiwd0589JdtER+j1rO8sjgsTZBgghxvRdVxQVZI5Rwd0ChjRFHG1YlLoSZe+ZUpxgeeDb/1mY+aoyjIW5c6QP1oM+vckxN++aQwsPqEWXzqiMQ4GHDhRweTzPNyKrSst7baafJ896q4Qro7LygTIPJcX0/Xd95CuQmEpUAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DzDtQseMZuX5sKjUD/UA/dKyLglmBLXWmetx1QwKEE=;
 b=DSKwAPokojKrzykF6+Tv3Qlyx1uwFJB6127Ppjghp9K3B9tr7e0GiLMCpcVzzrnjkht9fwVR12JSYknGQIVzGkCgE65nzG+Hnb4kDDYRaZeo//UtTP5olF+tCxFB86fwHKoH4wlDRVNotywxcJcy0r9zG6/OLyLb2+E4ih60hsAdTS3fL2+Z396T1eDQNQpLFB/3l0spqHa5rL2FET5x1kgEDd+S2YQ84t6+Q3bt4efp84SD2gcZp0y646hc6VLLLmRvq/P1mkw4M65oO/N3Z8InYcoA+vx7JyhYxzoX3Vz6cJt/rTMnT2Ssc5HPekGH55JNkQbGJIwXUMa57Yf0Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DzDtQseMZuX5sKjUD/UA/dKyLglmBLXWmetx1QwKEE=;
 b=oyMXuKmQJe2v+7ADTPse2Oj8K4GIzIzhFTrNKKGydniSfx7Z6d2WcbtthWZD2UkSTCdHOqb90EQN+ddKbj+ZPCsD6WLzrSk4opiMkVahUO1x5L8mBlPeC/b/A23YpUPgCoL0nvhVC04hNsuu97ZMYrrfU0Ft9gKXx5i/eBtEE54IolAwSGUEq5dTVF5uPj8xvT6b9gHvHIPKFirPbZ31i7GZfF+fCRvjcEixQovDuZgLrAJxSIKO+cmyDg0LOrEz9bVe4WpKbVi6FjXFiKCSFTH4IlDZUcwtS8r6Y8GgupErxFdb0WpANjI3xaN4UndiMx5LX8N6VhEUQFQ3QA1DWg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB10228.eurprd04.prod.outlook.com (2603:10a6:102:454::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:03:41 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:03:40 +0000
From: Frank.Li@oss.nxp.com
Date: Mon, 13 Jul 2026 13:03:21 -0400
Subject: [PATCH v7 03/10] dmaengine: dw-edma: Move ll_region from struct
 dw_edma_chunk to struct dw_edma_chan
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-edma_ll-v7-3-6fb7498c901e@nxp.com>
References: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
In-Reply-To: <20260713-edma_ll-v7-0-6fb7498c901e@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, Koichiro Den <den@valinux.co.jp>, 
 imx@lists.linux.dev, "Verma, Devendra" <devverma@amd.com>, 
 Frank Li <Frank.Li@nxp.com>, Devendra Verma <devendra.verma@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783962202; l=9193;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Ws1k9Bkmc89qdSWIsue5sq1t1ypebd+jQq6YLRGMxhY=;
 b=7pa9pM5qdsjpq3nzgDR7pZ6LrNVhPq3evnVaTELhA67j7gpXyN+gMYgk6Krv3U3jcUeBBtgVu
 LFq2KluOWN+AapQq4oYhfPAtmAAY5900m0WSA4dQp69H5LoMuWWNmh3
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::16) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB10228:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aced37f-372c-4991-2bc7-08dee100b03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|19092799006|1800799024|921020|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	ywldRhHbNCDcTDRKPNjKHwOwFvH8bvqIW+iIVwnWsNCZLjh7PBX/0oyRNpvE0oUdL8znKsG78Yym29369CVXxT5Mrh3X/Ir5/krIKPgAN6Bg9eFzQVgozFdjezH15H3DL7vnCRHTYDinm3VILqohwS53q56z+Zz5p0tRZSr9Oy+9GuV/jPYDZJnM6b0phHP9ldSmED61spN5T+iXu0GgYd9cbxOt8I1ipO5vIgy9nry8AclY105XZSQrtP3b4Ewk1iMthnFTvcwI3Qok6lPBVA7b39djyVGJatET7ObsEFQEmCmT3ahWXDiPZK2ELndc21d5J/XgQevshLEYsfbfb8mMhAbtXHpoYMUKMvjn5mBKE1O0mSNm+McAuXu6HZvYSsVDslHZoRrJVtVAI2fZcwuhMIJNlPc/wlQkvHtOkU2kbpic7RUTG0PAJLbTyqN6jWnLnFP3CO4c+y1zO6mKLU3txtoCAMw5u/SmEuXdTbKtTkcI8mxaNjNjs2YnDaF96mmUWCbzXycB/4XXAr8ZoXudUeXY7pzD+1u+LbX6GrdYExogn2RTwJzZz1XuDX7dyQNfdGmPcBlKJNbz7lkAUJ2/qdiMgLIkTTUgz6PrxpTeCmF3UPIB87mNqJWf2CCPbRWKOBTacwr7XV+IomHo7XZkl/F1VA/hebdZsc6o9DIgkFWPoPptMBQv2kwNFYe9QAHZ3V2LdWscQuPSgWiR4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(19092799006)(1800799024)(921020)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTZXVmE2UzEyYXVCR1ZlY20rRjB6K1d0bnFEMTN6MWhxYjVQV25TaDZjU0FY?=
 =?utf-8?B?Q0xBZklxNUpTK2VuVXVISjZOSnJxdlk1REZJcXFQcmxFd0pZbU91ME4xYlN0?=
 =?utf-8?B?aWJPK3o5NCs3cjQ5dnpaZzFEVFdMeHE1L0M1OXJRSTF6VjlwL1lKVUtoY1ds?=
 =?utf-8?B?WkRrbCtOWFZYYXNoMUJGS1VVb1prSkw3cEtDcDhoOUVCQWQyNUhxME5OK2FD?=
 =?utf-8?B?Q040SG9RSWtHcEpxU1lxTUJ3cFlIM2gwZXRGK1dtelhnc3R3NzhsZW5hbVNE?=
 =?utf-8?B?TkpnY1JDL1FHM0l5SVViY0tnWWRPdkg3WllxWFlabGtzSEVqbzlhWDF4TjVt?=
 =?utf-8?B?T1IyU3dFb0RRMy96ZG42NC8zV2FZZmpNLzVGeUVQcHJ1bFZqQWxVRWYrN0Jp?=
 =?utf-8?B?NURJcnNKWlFUakZxUDdqQ0ZNZXV5RmtSYTNwQkNNY3cyM3dzaWw3eDNKTmNs?=
 =?utf-8?B?N2w0MU1oc3R4R2xNUDJDdExZQUc3VWNVRnZGM2JEaCtkcDhvWGZvcU9QOG1Z?=
 =?utf-8?B?K3M2RmRYYml5MjJKZWI3U1J3UGpILy9HZXFSQUNKbFVuM1FGdGVsTUxWbEdP?=
 =?utf-8?B?ZVpDeStoQ1VDMUcwdlhFeUN4YXNGTlV3cElaWDhUZFMrRk11NWJOZXgwL3g1?=
 =?utf-8?B?SmNsZlF1bEF1NndCUWNYL1VaWGQyNTYyakdmdXE1dzROZFd0ZE9STjJVbmpv?=
 =?utf-8?B?T1N5ZDZCRXVydEVtbGdkRUMxWUdHU2NsSXFIS00rVUZEb0NpZVdhZ3BVVWNE?=
 =?utf-8?B?RzlyT2JZejFKUVU0UkY1QmVkV2pBdHhEK0krNjlmQlNGTnpjZ1VERStBQlht?=
 =?utf-8?B?U2ZzMC9hcDY5WWNZUHBOUkxOTExkZDEzSFNYN3ZyTngycXJLOGZCcVlkbXJM?=
 =?utf-8?B?amZJaWhCUTlrV3orZDJSRGhVWGpGQUc2OHY5ZUp5UmtORkZrK2E5Vi84b0Q1?=
 =?utf-8?B?MFl4L01SNkZ4bU5JQlY1RUFRSjZOdWljQzB4OXU1NHhONGk3T0RnNjNGR05a?=
 =?utf-8?B?Y1lhZTMxb1kvUUVSdEhxTlBNcUdFdWRaU0hLMG5FaDNVRFNxQW4rSFpRZWE5?=
 =?utf-8?B?Z2NaTGFxc3ZvNXlkOG13V2gyblYxNWI3QUlxbkpuWTZpSjM5U0R1Y0c3K0JJ?=
 =?utf-8?B?NWFENXhvS2MvWUN0L3dYOFExc0JhaGYzRzlyOUVoNGszV0RsT3pVWVp6OGxK?=
 =?utf-8?B?eHZBSEt0ckVDekxJdEFUNXVveWROL1pPSnlxVTBtN0FkeVpTZENqMFA3UTZn?=
 =?utf-8?B?V05KRVhJcVc0aitDclhQemNjL1BsSGwxTTljL3prcEpIMHg1NUcyNE56eVhh?=
 =?utf-8?B?cmp1OFgrU28vMU8wb3NZaWxIczkxendJd28rT1B5QmRYN294bW5SN2RSK1gx?=
 =?utf-8?B?cW9SNU80RFYrRHpjSi9EYzJYNTVmclgzd0l2MXZYY2trTHMvd2pjaXhvQzVa?=
 =?utf-8?B?VHNHcC82RkZYUDE1MUQvenFPYlgwdGNMU1dYSllBTUVXMzdZNzRUcktkTlBL?=
 =?utf-8?B?ZjBsS0NEOEs4a2pWRk9nbElBUlp5Z2NoRGFYNGtzQThPOHhsZis2UzZHSmp6?=
 =?utf-8?B?cWZuOERuMWM4Ny81UGZvazBEZ1pJUmNyYUxEY1Q0ZFNLQUE3RFFXSmxRaWVT?=
 =?utf-8?B?bjJZWCtPdmpidmJrN29zaFVDcmNkL0VrRU1TeS91TnV0a29IVW9ob21McGcr?=
 =?utf-8?B?YnpjRFRsS01SNnZQL1lnMEZvT2tzMjZyanpQSnJRZzdLbjVQbm9EVEtReXNY?=
 =?utf-8?B?c0dYa1MvOWZhK3hFK2ZMWTRSem5odFhaN3J1S2FwdzZTNlJoR2RCWlB3aXRh?=
 =?utf-8?B?S2IzcWdrTi9WMmVvMmx3ZzU1b2xIeUZPbEpieHExOUtxUERCT1d2ZXl4c21G?=
 =?utf-8?B?WEVDdXZGaGFOWG9HQVA2N0s4RzFzdGRqcytnd3g3UDAyNGc5Sm1HWmtaZHFt?=
 =?utf-8?B?bnBzeWlSb0tVMitVcW5iTjYvRk9ld1FUellGRkw3djlCR2NoL2JBV0grMUpr?=
 =?utf-8?B?eWRxbUt0d0w5V0s5cVY2Zm1iZEJGUis5QnRMck5IRDZiWlZHbGRZRVFGR1NQ?=
 =?utf-8?B?RGhlSzFwQURZRHlZVHF2cFlEdG9WWnNxSWVzOExXMWkrZE5mSHg0RkZwcmh4?=
 =?utf-8?B?Qm1YUmk1U0taejhUdmtJZ3VNaHRIakErYWRJN2xXUVR3QnQrOXE1UGIzWFpD?=
 =?utf-8?B?S0lEczVaWVo5SmkzbjQxclV4cWppZWlmbzZQaGgzaXA4SzdVaUIxSU9xdkd2?=
 =?utf-8?B?Uk5NWGk3MGIrKzRwVVNEMTEzZFBzU1p0SjUvditSendvQ0UrdURLb3JhdDRi?=
 =?utf-8?B?VURJL3A4b08yUEpqMkF4ZGx5TUtadzY5SWxJcFRuVzFPZFpleWpBWkkzQk40?=
 =?utf-8?Q?bZcQZt4ihhmNWOwanCke9rrU57nN+AWX+A6BL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aced37f-372c-4991-2bc7-08dee100b03c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:03:40.9215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6s4emM+Ohc+vqBWyrc+OwLgVfADaP6O9iawvCDmWcID/6BvpsvKIR7ejAAzerWek8QHZ+7vtjKDPvTBgDzpvts5iQGXbBHbgr/HPg5LmBl275UfX5z7bFj4SGEBXtRAH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10228
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12404-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:gustavoars@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:cassel@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:den@valinux.co.jp,m:imx@lists.linux.dev,m:devverma@amd.com,m:Frank.Li@nxp.com,m:devendra.verma@amd.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:email,nxp.com:mid,NXP1.onmicrosoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.nxp.com:from_mime,vger.kernel.org:from_smtp,valinux.co.jp:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A10974DD66

From: Frank Li <Frank.Li@nxp.com>

ll_region is identical for all chunks belonging to the same DMA channel,
so there is no need to copy it into each chunk. Move ll_region to
struct dw_edma_chan to avoid redundant copies.

Tested-by: Koichiro Den <den@valinux.co.jp>
Tested-By: Devendra Verma <devendra.verma@amd.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v4
- collect Koichiro tag
---
 drivers/dma/dw-edma/dw-edma-core.c    | 15 ++++-----------
 drivers/dma/dw-edma/dw-edma-core.h    |  2 +-
 drivers/dma/dw-edma/dw-edma-v0-core.c | 18 ++++++++++--------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++++++--------
 4 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 53469c8c8b82e..2652ad8e7a8f6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -64,7 +64,6 @@ static struct dw_edma_burst *dw_edma_alloc_burst(struct dw_edma_chunk *chunk)
 
 static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 {
-	struct dw_edma_chip *chip = desc->chan->dw->chip;
 	struct dw_edma_chan *chan = desc->chan;
 	struct dw_edma_chunk *chunk;
 
@@ -81,13 +80,6 @@ static struct dw_edma_chunk *dw_edma_alloc_chunk(struct dw_edma_desc *desc)
 	 *  - Even chunks originate CB equal to 1
 	 */
 	chunk->cb = !(desc->chunks_alloc % 2);
-	if (chan->dir == EDMA_DIR_WRITE) {
-		chunk->ll_region.paddr = chip->ll_region_wr[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_wr[chan->id].vaddr;
-	} else {
-		chunk->ll_region.paddr = chip->ll_region_rd[chan->id].paddr;
-		chunk->ll_region.vaddr = chip->ll_region_rd[chan->id].vaddr;
-	}
 
 	if (desc->chunk) {
 		/* Create and add new element into the linked list */
@@ -925,10 +917,11 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->status = EDMA_ST_IDLE;
 
 		if (chan->dir == EDMA_DIR_WRITE)
-			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
+			chan->ll_region = chip->ll_region_wr[chan->id];
 		else
-			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
-		chan->ll_max -= 1;
+			chan->ll_region = chip->ll_region_rd[chan->id];
+
+		chan->ll_max = chan->ll_region.sz / EDMA_LL_SZ - 1;
 
 		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
 			 str_write_read(chan->dir == EDMA_DIR_WRITE),
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index db5f45bf048c3..b96089baf0f9c 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -58,7 +58,6 @@ struct dw_edma_chunk {
 
 	u8				cb;
 	u32				xfer_sz;
-	struct dw_edma_region		ll_region;	/* Linked list */
 };
 
 struct dw_edma_desc {
@@ -79,6 +78,7 @@ struct dw_edma_chan {
 	enum dw_edma_dir		dir;
 
 	u32				ll_max;
+	struct dw_edma_region		ll_region;	/* Linked list */
 
 	struct msi_msg			msi;
 
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index ee5c3c317557b..51e50f1fdcac4 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -280,9 +280,10 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -290,7 +291,7 @@ static void dw_edma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_edma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -303,15 +304,16 @@ static void dw_edma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_edma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_edma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_edma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_edma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_edma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -345,7 +347,7 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_EDMA_V0_CB;
 
-	dw_edma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_edma_v0_write_ll_link(chunk, i, control, chan->ll_region.paddr);
 }
 
 static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -359,7 +361,7 @@ static void dw_edma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
@@ -430,9 +432,9 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 	}
 
 	dw_edma_v0_sync_ll_data(chunk);
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1201f1ab5f359..20089d57f8ab0 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -156,9 +156,10 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 				     u32 control, u32 size, u64 sar, u64 dar)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_lli *lli = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_lli *lli = chan->ll_region.vaddr.mem + ofs;
 
 		lli->transfer_size = size;
 		lli->sar.reg = sar;
@@ -166,7 +167,7 @@ static void dw_hdma_v0_write_ll_data(struct dw_edma_chunk *chunk, int i,
 		dma_wmb();
 		lli->control = control;
 	} else {
-		struct dw_hdma_v0_lli __iomem *lli = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_lli __iomem *lli = chan->ll_region.vaddr.io + ofs;
 
 		writel(size, &lli->transfer_size);
 		writeq(sar, &lli->sar.reg);
@@ -179,15 +180,16 @@ static void dw_hdma_v0_write_ll_link(struct dw_edma_chunk *chunk,
 				     int i, u32 control, u64 pointer)
 {
 	ptrdiff_t ofs = i * sizeof(struct dw_hdma_v0_lli);
+	struct dw_edma_chan *chan = chunk->chan;
 
 	if (chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
-		struct dw_hdma_v0_llp *llp = chunk->ll_region.vaddr.mem + ofs;
+		struct dw_hdma_v0_llp *llp = chan->ll_region.vaddr.mem + ofs;
 
 		llp->llp.reg = pointer;
 		dma_wmb();
 		llp->control = control;
 	} else {
-		struct dw_hdma_v0_llp __iomem *llp = chunk->ll_region.vaddr.io + ofs;
+		struct dw_hdma_v0_llp __iomem *llp = chan->ll_region.vaddr.io + ofs;
 
 		writeq(pointer, &llp->llp.reg);
 		writel(control, &llp->control);
@@ -210,7 +212,7 @@ static void dw_hdma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 	if (!chunk->cb)
 		control |= DW_HDMA_V0_CB;
 
-	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->ll_region.paddr);
+	dw_hdma_v0_write_ll_link(chunk, i, control, chunk->chan->ll_region.paddr);
 }
 
 static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
@@ -224,7 +226,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 	 * last MWr TLP is completed
 	 */
 	if (!(chunk->chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
-		readl(chunk->ll_region.vaddr.io);
+		readl(chunk->chan->ll_region.vaddr.io);
 }
 
 static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
@@ -251,9 +253,9 @@ static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 		/* Linked list */
 		/* llp is not aligned on 64bit -> keep 32bit accesses */
 		SET_CH_32(dw, chan->dir, chan->id, llp.lsb,
-			  lower_32_bits(chunk->ll_region.paddr));
+			  lower_32_bits(chan->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
-			  upper_32_bits(chunk->ll_region.paddr));
+			  upper_32_bits(chan->ll_region.paddr));
 		/* Set consumer cycle */
 		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
 			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);

-- 
2.43.0


