Return-Path: <dmaengine+bounces-8887-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j1EMEYRIjWnM0gAAu9opvQ
	(envelope-from <dmaengine+bounces-8887-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 04:27:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D32A12A2B3
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 04:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6CB613000FCC
	for <lists+dmaengine@lfdr.de>; Thu, 12 Feb 2026 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3324BBE4;
	Thu, 12 Feb 2026 03:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mPqpIhzA"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020143.outbound.protection.outlook.com [52.101.228.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264EF1DD525;
	Thu, 12 Feb 2026 03:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.143
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770866816; cv=fail; b=Pj5H6Hc8/YrZPT58MdROdjydNF/k8+q93YLS9cDQyNZNJtH6Ous2Bgb6C/EXG2vzTGTO8KmrCBrp0CcRJFZhs38XkoYdfYq7cblNu5ilzY2rCT3IyxybyIe86yVfW6nUBDP0LO14B84qGQBHwmXqaVP0eeXawjAsxYqN41C/A/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770866816; c=relaxed/simple;
	bh=VoZ35TpJFAFcKZCCHuhPgz/FfmRa82U9qdYX9r3x50c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WuwQ3OkIepp3gG6v4emwoWpypSc4cTza96HZsJqKP2ENDOMrxf6fNXQSXtI7D/4GVXKWGuXzi7iv25PEu48wEiFKhs5szbR+2hK13ERFCwMUUr/wEfaDAJJ8BGzRS5L4eLwx/3f6OfeXh6kE7RA3nU1XzkCF8h88HuSGiRu7ohI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mPqpIhzA; arc=fail smtp.client-ip=52.101.228.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UiloHYpfjrKpwfU9q7LzvxFyM+4RKMTYlu23Ap8i8kg/kh3Nt8icuInHuf4x+Zq2QZyOqnMNa34n18lAuV0TIY3p3oXxRQxkYjV1rrBDoiWhDv+Ic4ae4Qh36UETp5Ib27EFJIMhYYsWrgDFrDdLPPJFnCrXw4950S+wZsUIVkDf/7676k+Vxib+075L7Snb4EiDZZxkIcUVFIbFoyutHKJ4cEzZ1pwGFQGL8SSsuWLZbGTGVBNCHvR7qSvllZAjO2+VGo0paQQaBbsI7I3avlxDmxCopflSE8OqRg3Ibj1LyRow002wNMPu5HuXayRNX+ImYqoo1uVhYoImEmkNFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=grUo6QMPC5ha+CZJ19I3yUxIftiEbj+1/48Me0e+jfE=;
 b=RRoC6Cv/ff2pjeHEbe4PbG9YKuG+K05eJjSW5S7r+Gmi4BEfREA4s4c4CMUNKu/+ojudS8w02InAe64/BEvlAmr8oacmzO/Cm/dDTEpnQNr2knuII7CGJ1jg+FPZps54BgFrGSQGd/PC0ljYMZVI5Isphh2/6uhS8ZnAzuiFte2izy/kT8R14/TKBme6LRQ7iafQzyZEI8cqmFKDKVoGDmuUTVJ3bih+aZDoWenU9nOmWyt9fyfijRxtPTwNgrpUpdbMN+Y4lVvANHZMpyd8hGGgpkbvNdKSZ7C384sRuKgFzGODThXhR22o237qcZ22SvNkFzhFyac913IpHeKX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=grUo6QMPC5ha+CZJ19I3yUxIftiEbj+1/48Me0e+jfE=;
 b=mPqpIhzAJYqcwwSFSs/EthHyTs5VDOrKbl80SwkNJ3BFWwmsWnUzFwPolXU6LzJKSHAcjH/NrChx1Le5lo2YYYwBu6Wz5cJYmFo6AHc+4iFZYhpRtmgC+ExJRj06WUqtSZy2cqrQzrQBgvk+m2QrypF4D2PSo/50wQ2I/bw912A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7190.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.11; Thu, 12 Feb
 2026 03:26:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 03:26:50 +0000
Date: Thu, 12 Feb 2026 12:26:49 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <fblyz2hldxgqo2i7fywpgzuaqxzxsbavme7pfahj3uftgloeqq@pxeddjzm4sdj>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
 <aYtdEnZM5mnmcgtY@ryzen>
 <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
 <aYyz5WF_iJuNwA35@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYyz5WF_iJuNwA35@ryzen>
X-ClientProxiedBy: TYCP286CA0328.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e43a6e-f283-4116-5fd4-08de69e68f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t3t/hjOpdzMiqbUDLP91qkQQ+VXaETozS3eEt54vAPv3G+vhNnmMQkLNrv6y?=
 =?us-ascii?Q?0grIkhi6OoDVDsAI6cCgbaxsbIFr6tz2irpVT53StN8QroEsZ9XzEoSgr4a/?=
 =?us-ascii?Q?8q3Z3/CPcSF8FZLBIFh1rcA7lrKYCEgmWQGG1SFNtd8CoxXMHw0Mrz+pv86G?=
 =?us-ascii?Q?9l0bZx3K+K4VT5nhkEkn6fSHpSNSXZMJ2yT7ju48++QlpZmv5P9DcvC6/dav?=
 =?us-ascii?Q?dYfLEvcpCyeoiWdcluB9BitYHOT+LQxl5Wme/ALeIK+6WsipYelM4aUxYH9F?=
 =?us-ascii?Q?N/X0BcxVHQEkq5YN7PIhlN47PWXwsVEjkZ1TODl4s5SwoObz1Wr9Rwc743tW?=
 =?us-ascii?Q?J5dXvwmqe0Ir7GfU8QW6hMri2JmCmVpGV96lzJzk1a5L+20xqQSfDws8AlLI?=
 =?us-ascii?Q?9BleCzJQ3O85M6KLXLqOxb3339otO1ES19imKyIH1o8Y2EVBplSuzTrV0Jwa?=
 =?us-ascii?Q?t5vfCQaeTyRkKOALnwxlwmJauqyA6lRT/gGlZXFpmNzzcog/H6QK5GSD/LLE?=
 =?us-ascii?Q?04jf3/bFF6o2vN3VjwlYWOFyJjDuBoDpBEFZC77aY1K32oSmAQdf2p5FQe8Y?=
 =?us-ascii?Q?cw913o5XsWFQu9zsqfqz/2nI8/pMlWmJV3P9OH4GJPOPk5G6S4G0y+9YeBBp?=
 =?us-ascii?Q?+eKTM32zAS9k+Or7XSoPBWvpPMLzsUbnaTGDID/4p7I5ZbfUfu8N/s2m7d2H?=
 =?us-ascii?Q?r5fRrwF5NQx/Pn0pyLMmCZEwqi+7gqkX4vzl8dEyhbpXcmdQxGxmwVSa6F8Y?=
 =?us-ascii?Q?0oqRwMa054K1xotekMT//WG4EpZ0npb1PZPfV3Slg/MRjcaJ+1VWOm0v2+mY?=
 =?us-ascii?Q?EW3PbEYiyBvN6Wl/I35yIjy79uzmVjxyR+cjKllIcvqXLjVEoH+u6skLK0Wk?=
 =?us-ascii?Q?jm+VGpFmqIKT0IoV2cvpjwPkGUWJwemKUaWXs24F7T/utBKPDvjKZRNg83wT?=
 =?us-ascii?Q?hRJGawyHneqPeRQhd5s4ObiDu+LTmnG67m8+k+bUFMqYbgOyDJIpkmGU+ns8?=
 =?us-ascii?Q?LutJWG4JkzU70JWWyFToY5X0+hAFHybdHdx/3SOnGKqSdJEjU6XmvWtfqz7g?=
 =?us-ascii?Q?vYW+yDomLf2k7HIk7B+b0DBTRESdvpxpDrAkI1GPm8M7NGbiTLQvmf7jcP1D?=
 =?us-ascii?Q?nmArz2Hvmc9JViv9idhDVrZpdIc4Cu+1eUkGd2FFIVJII4rVG7+7i5if0EdA?=
 =?us-ascii?Q?tztgivEys5W0MZzpvyYm1fYFnxM/XtJngI/IpEwmZ8o3RPv65io0O4K/Qn+3?=
 =?us-ascii?Q?lwIT4C+WShMjQFC1CR97cXIrOv63Iu97HHz5SkQUdE9JE27TLZHpYxOJLANP?=
 =?us-ascii?Q?EKm24kzS2vCfl6sVmMd01G4uY7mbXiYBupplBv5PqLbyVVzxvxnhuH9QmE7S?=
 =?us-ascii?Q?z9CTB4qTd3an8qPA2r2ZxmNRFE9U4iFWCkfBKTywj2eNqMDrBpelbPMK4hx+?=
 =?us-ascii?Q?mnYeghvQ1Ty8wRk3jU0w2FiQGModiYcxsKtzvoJjgYZCxWVhV/V8twfS3+nh?=
 =?us-ascii?Q?gb/Eod9fPOA9WfJpR22CgSu6deelC7ID8lF8jnhCJ8hvCpmS/XAisWz3CQdX?=
 =?us-ascii?Q?02T+1UnKvnPiv9CT7M4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G6n5HE+puT3kFQy/6wNWv2bSpPWGrknhERK6wZomIMKVjOsAIKT2W6QuofGJ?=
 =?us-ascii?Q?z8YsEAy1PYXhGuvPzKyVlKcCVkndO57LMreOf/Em9eAnwJv9TIPXhm8b1H7I?=
 =?us-ascii?Q?x0vvwOZf2kXJ53p5hah2qAk+InUSuffh5idTOOZmbrgl5fwmMkrM5bHKLyqp?=
 =?us-ascii?Q?T/SsvHHQYOzvs8J4LWr9+4SuypSzvB+KWcNBKdJlUycxE6ulZWKEHwTZGx2I?=
 =?us-ascii?Q?qmk3LCcOkh5zKiFCNJXFXj6nj/77RnPMa4eRyQgjQ1Y9ZLfOs1BH0qUX/Y3P?=
 =?us-ascii?Q?z0c9+9EyG47h0wwmJC67j1l02+on4a07mQepPQAKI3brHVORRF07d5X0Sbwr?=
 =?us-ascii?Q?kwtjKNkZiDQ8S/lDpqvZvi7wm3JuK5yMVt+yXIHbAFcImDVB4AettPVJxQCq?=
 =?us-ascii?Q?ZQwwup0EC6cVadmCEQtNn5guAHi41bC8U03I+R3uZqU57Cb7MCrzpHogVJ0X?=
 =?us-ascii?Q?GzAHyfCuezwk6b5vxpdqyA1cC4uwbqTeJmy75OT7WdteTglf6Jgxt5zPOGdj?=
 =?us-ascii?Q?7yIxaIs3Bcz+HyRh8Mn2qwcIjQFSI6x/j2QrWS/2/KixmD/No5i3D8pN7ORs?=
 =?us-ascii?Q?w4b/NCWi6oMrpL6Mpe1dgEwVGKp/4VMKOKDSpR2eIE6LEIv+XV2bTFc6z/ye?=
 =?us-ascii?Q?b4i9Q3GBosqPgATzgtpkNUXQuCQFRZP1gLdzq6D/pIz6NxBTjavzWV1MnVWA?=
 =?us-ascii?Q?u7Eiwyl5uqYV3amBK9gxHtReefZYRO9UX3JHgUu3CAEQspybjCUZvDbV8DdU?=
 =?us-ascii?Q?pgCGab1X2nF6moivIyIdczQSNt31NN+sBvSq6Tlerk8K/z4ZQyzMMVu1ASKO?=
 =?us-ascii?Q?R5psLVZTe/0859hnfRGtZCAPYdmLYV5l6iBqqcvWc+iSFYmYB7gt6Rz+ScSq?=
 =?us-ascii?Q?avitzK38jyhkj6h1JXbBmAlZGNb/t2OdYKgREpGzg98Kpp77aSzhAeocvw7G?=
 =?us-ascii?Q?6hD9HTYkTOXco2rVc9VcppEgM+5a523iwB3hfGp9gcOgRoHFA+3T5ebJ7Hfi?=
 =?us-ascii?Q?JTeKXfaWmy7WuILS6Hu9OIMPc1WtDVTMW/mIZ6c/H9c2lPPP5fQdDaGhlJvo?=
 =?us-ascii?Q?3aplHCiLFfHUohBhFbggrvus/sJxR0G0vAA+OFhZ6q/5mkbSqSMxnFLgEfd7?=
 =?us-ascii?Q?gWEnjnOL5Rs3ScpFHStloGp9lhOqOFM9NXtTIqs5VaZcbqRnrt8lhixzGBb1?=
 =?us-ascii?Q?yFRBIAeATv09W72+A3qNO9DPFs5X/JjuiacQV5DjxJMAxC7axjm7uDfAzUnS?=
 =?us-ascii?Q?G+fNZFyy1s3NXJ+dlsSW+AHuT75enEw9X8Eo0rF1y0/Moia8oE9e6nbhwlba?=
 =?us-ascii?Q?RROV8vqXnwEBQ93wuGwGCzL0Ynp3+sWcZKGJN5pVv+ndSt3/Zi/S08UwGr2X?=
 =?us-ascii?Q?/h+fYuopxTLhwemWOHdEVEAQGX1caar2mWHO/NgK78dF7kMgUK/CVdjKYeTt?=
 =?us-ascii?Q?SqT30rCo/vNw5YA8EMoO4hh63TLANsX2K8WsAxxBMhUZxWPkhIEAN4zM9Wo0?=
 =?us-ascii?Q?9KMd8iEiUAvx4JL1HIk8IFdQNJStcYSdEfDwS30at8/cM2Si8ZmuzGa6QNEu?=
 =?us-ascii?Q?L5dclOfmmzc9/9f/Oinzv6VZC88SIzYTKAOeDMs+ETjug2clGgRhO1ICeQTJ?=
 =?us-ascii?Q?6OKne6E1LBpBmGPhTtmhVL+wktM9AMaXHqgcgclI2MlrTQvPE2eP5DCZP5dO?=
 =?us-ascii?Q?v5+NTnd93nLq6xDVDY20cAnamhqt4yjq+L5HTbHAqPMpE9mWDjZgb2c8ObbE?=
 =?us-ascii?Q?jrYhu8Yf62+NJQkEB5unlOV/x/ZgYoqXIUqXL2B4iXzu468B6dmk?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e43a6e-f283-4116-5fd4-08de69e68f3f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 03:26:50.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7dOaAc9xd+Pxt2uQtyzKX1+bVn4HUBF9byInvUeTqpThji0O/Jp2EeaJV8WaNlBXL8hU3oaNRL8fdhB+aZytg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7190
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8887-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev,nvidia.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D32A12A2B3
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 05:52:53PM +0100, Niklas Cassel wrote:
> On Thu, Feb 12, 2026 at 12:57:52AM +0900, Koichiro Den wrote:
> > Could you try a quick experiment on the Rock 5B EP side?
> > 
> >   devmem 0xa403800a0 32 1
> >   devmem 0xa403800a0 32 2
> >   devmem 0xa403800a0 32 4
> >   devmem 0xa403800a0 32 8
> 
> Here it goes:
> 
> # cat /proc/interrupts | grep edma
>  53:          0          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
>  54:          0          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
>  55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
>  56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
> # devmem 0xa403800a0 32 1
> # cat /proc/interrupts | grep edma
>  53:          0          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
>  54:          1          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
>  55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
>  56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
> # devmem 0xa403800a0 32 1
> # cat /proc/interrupts | grep edma
>  53:          0          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
>  54:          2          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
>  55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
>  56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
> # devmem 0xa403800a0 32 1
> [  104.217632] pci_epf_test_doorbell_primary
> # cat /proc/interrupts | grep edma
>  53:          1          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
>  54:          2          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
>  55:          0          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
>  56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
> # devmem 0xa403800a0 32 1
> # cat /proc/interrupts | grep edma
>  53:          1          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
>  54:          2          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
>  55:          1          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
>  56:          0          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
> 
> 
> Seems very random if you ask me.
> 
> Same randomness is observed when I write other values, e.g. 2.

Thanks for the testing and sharing the actual behavior. That helps a lot.

> 
> 
> Could this randomness be because I do not have:
> https://lore.kernel.org/dmaengine/20260105075904.1254012-1-den@valinux.co.jp/
> 
> Or do you think that is completely unrelated?

I didn't clearly answer this in my previous response, apologies.

I believe that patch is unrelated. It addresses MSI data handling for
multi-vector IMWr generation (i.e. remote interrupts), whereas here we are
dealing with the emulated interrupt path for the embedded doorbell.

If applying that patch changes the emulated interrupt behavior in your
environment, please let me know. That would be very interesting.

> 
> 
> 
> > > RK3588 (pcie-dw-rockchip.c) exposes the DMA registers in BAR4 by default.
> > > If I hack pci-epf-test on top of your patch to unconditionally return BAR4 with
> > > offset 0xa0, it works. So my best guess is that the fixed inbound translation
> > > in BAR4 (to the eDMA registers) somehow messes with the inbound translation if
> > > another BAR tries to use an inbound translation to the eDMA registers as well.
> 
> Adding Manikanta to CC.
> 
> RK3588 is not the only SoC that has the eDMA registers exposed via a BAR,
> some other SoCs like Tegra234 also has the eDMA registers exposed via a BAR.
> 
> Me and Manikanta were discussing this a few days ago:
> https://lore.kernel.org/linux-pci/aYsQu9lQi4IzfBiP@ryzen/
> 
> 
> > 
> > Thanks a lot for letting me know that. I see two possible ways forward:
> > 
> >   (a) extend PCI_EPC_AUX_DMA_CTRL_MMIO to optionally describe that the DMA
> >       MMIO window is already mapped to a fixed BAR and should be reused, so
> >       EPFs avoid creating a second mapping to the same target. I guess it
> >       could be treated as a quirk for "rockchip,rk3588-pcie-ep".
> 
> I do like the idea that an EPC driver can somehow provide the BAR number
> which the eDMA registers are already exposed in, together with the offset
> and the size within that BAR. After that pci-epf-test could still work with
> the emulated doorbell (only difference is that it would not program the iATU).
> 
> (This would also require Manikanta suggestion of having both a BAR_RESERVED and
> a BAR_DISABLED type, and support in pci_endpoint_test to ignore RESERVED BARs.)

Thanks for the additional context.
Even if we introduce the distinction between BAR_RESERVED and BAR_DISABLED,
as I understand it, we currently lack a way to describe what actually
resides behind a BAR_RESERVED region.

Perhaps extending pci_epc_bar_desc to describe what a reserved BAR
contains (e.g. DMA register block) might allow us to handle this in a
cleaner and more generic way. It would at least be cleaner than treating it
as a quirk and hard-code the reserved BAR+offset+contents.

> 
> 
> > 
> >   (b) alternatively, clear the default BAR4 mapping on RK3588 at least
> >       temporarily when using the pci-epf-msi doorbell fallback.
> 
> So for these SoCs like RK3588 and Tegra234, it appears that the option to
> expose the eDMA registers in one of the BARs is a Synopsys DWC config that
> you set when you synthesize the DWC core.
> When you do this, it appear that that BAR will always some kind of fixed
> inbound address translation (i.e. even when you disable all inbound iATUs
> this translation for BAR4 to eDMA registers is still there).

Thanks a lot for this input, so (b) would not be viable from the beginning.

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas

