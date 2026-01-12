Return-Path: <dmaengine+bounces-8225-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C63DAD15331
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 21:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7622630248B6
	for <lists+dmaengine@lfdr.de>; Mon, 12 Jan 2026 20:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E563B3242C0;
	Mon, 12 Jan 2026 20:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aKj8bAwk"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62605224AE8;
	Mon, 12 Jan 2026 20:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768249397; cv=fail; b=GUJH9nsmjBAvhH9Mk+kcUoNkV4WI0xjDwDAz0+yVc1IVkiy6WbloxebHZ1WhMivhFf4hsjDOPVbo++aEX2nGAmMv8SWhiefLvfUWCnUKHTAL4aGD2pntQ8epGcxYSImT7MlNOcT4tgO+0zxIFqvC7ca/qKWyqm76CwaGhxewRuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768249397; c=relaxed/simple;
	bh=9PolfyCkD301hIUI3S+RLPnY8GlNt0EaMGxAJ3eksxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BWVuyMMc7EV2FMJDJ6IjxN632Rth3IVaF3zWG/mDWUhEEMm/sWdutOjqk2/leNfdMIgtwNoKwpiHm61a4QhCq3DPU/OJiB508Y9VjlLW8Q8/pvlmh0O9DAneJGBSa16zPcMj+ZM7HbrxUB/rE5ByElrknTHvJIcrkxJyccBLh9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aKj8bAwk; arc=fail smtp.client-ip=52.101.70.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PRl4+VJmy6OmKDszCrEWCTCF8s4sQ2MgKjqUKy1VVPfQHwsCl/FkeY36Ad5WueBkZpz1n8K+fVt42awAKfNMmlCziFH7ZK/jEiH+wMlCeaK6KEVq+3aTE0nbAsxSLV7SgtJrTo2nrcJLsDUQeglg9wUkgGaJ6kErpF9FdX/pVlnTeYD7zVh6Vr3wAZ2kowgJjsJHNmBwcvMttFWjQ/ecBFVugrobP4oqYPJRTAq04WFuHyUHeQA2cRNDuAVJ5eGGCGjDPJeMmhhz1NXwPGVzUtXhvL3HsbefIidUrZ4m08HySiWlzBpEEss8YC7C/xl5iV9evksjZdeOGFXXQuil6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pGLBGtYN5Sn7ivM/AFs5WukCPO7FbPAi6/Aj/lfVv9o=;
 b=ddTi0h81gDdMVjz2vMEaYY74l4mbqy3d9rg3gWn17IZ5wV/DhoZrpnU+3phu24HhcvOVDRIZ4XhrJU1nZdkKl0G/1hilhipze6/0UG5WRcNEdcqHDBQx4qcQrahPpImbqCq9c+ruwiUmHbSDhUbFnMQs5d8LCiZc50sgAzLCy9fSC8petLoHl9PyKfTJIEQvzw4gU7vc0Z6lj2TqKl91CMp4f5KojfH57X391N/CNRq04ik1nJIawngXq2LflfJtFhaI7Dvz1FbFHg0/N75OXL/CIV5gBjRHePDCcr/+V5l2sR2m7CP23/ufKnTk27A/BFJMhOOFR0xXKHMupJ6ffg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pGLBGtYN5Sn7ivM/AFs5WukCPO7FbPAi6/Aj/lfVv9o=;
 b=aKj8bAwkC6zwUQTSNzq0uvaV7vmUugvCRmPXzW1Q1l+0xG4pXGJLfSa9Fohf8egHk/1fgNK7PPlIoZ7dkc6SBd058o0NRwWWMCxFVU7FhlwKe0XYbG5hc+rTc8ljXzzizPjsvSSjpg88JHVXZ+OKrZZfZ4WyQF8P9xd61H1vrzfipfYG0ztttjLw1mOfJH/ebTldATVHi5MdMFBeNks7rduVrRJmdPZoqeObTt2PpiIYIZXoRMyNCQ7X8ICaZp3CM9dt55/DH9EP+Hwuc3MfHpDbSb2CNnfKHu6e98QfAPIYMGrB9lxVm9fRXHbZOb7bLyL/RK+9u90LFYjCJapTyg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by AS5PR04MB11369.eurprd04.prod.outlook.com (2603:10a6:20b:6ca::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 20:23:14 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Mon, 12 Jan 2026
 20:23:14 +0000
Date: Mon, 12 Jan 2026 15:23:07 -0500
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 0/3] dmaengine: A little cleanup and refactoring
Message-ID: <aWVYK6zywigycNCT@lizhi-Precision-Tower-5810>
References: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109173718.3605829-1-andriy.shevchenko@linux.intel.com>
X-ClientProxiedBy: BYAPR21CA0014.namprd21.prod.outlook.com
 (2603:10b6:a03:114::24) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|AS5PR04MB11369:EE_
X-MS-Office365-Filtering-Correlation-Id: cb55fe6e-873c-4176-d65c-08de521869ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rgwUs6rlRDgQR3bw5U4PtJrcFE8wF541WmzHkAPzoWACP9SccJOFIRXFbCSm?=
 =?us-ascii?Q?/Jmf64HwaE7i+3ou6jrC43hI1AfN7CILmErvW4Juk8lz4bPyRgtihKK3CAvq?=
 =?us-ascii?Q?DsBC/ND7YpDhjmTf/ISdGF6K5uat7einC/8V/TJmhdTIfppa+UkjJ2Qh1nSY?=
 =?us-ascii?Q?LjAv+zWt0lCNrRvl9Ao5HYhpzaV0XaEgB8K073g2sIf9uJaYPVf6PjPBF3Rp?=
 =?us-ascii?Q?luu3HZ+OMF1dKk3kgQCw84vtmNyT9HVeY+4eAwk7Iy45nI86XCxONHNFpCzq?=
 =?us-ascii?Q?Ha9jQolhxgeEiwJOWS6JL307K6U8mudOaQZFj7snEl5POr2zA0SwApFu/6A0?=
 =?us-ascii?Q?QmwHdhnYIvx5IZQ1h3kKNl9tEuUcqr0X2EYendtEznu61mdg4YL4mv0h+WMs?=
 =?us-ascii?Q?YUTmjuulaWiPBtYqKSStV6MOLt1fx3stdqUQcU86GF7J9boqeWkBfK0qQxt0?=
 =?us-ascii?Q?yq714KgPnlII5vJ7ffaCUV61eYt03EaaO4zii9D8ZoWo6bbz8fhRr7aGdF45?=
 =?us-ascii?Q?SGsAWavVfW+XvEImIjMPmXQWnxg8YpCIzdcFdSNIQbBRQblcUH9hWbWsfwlH?=
 =?us-ascii?Q?IoKozsb3jjPv6hu+5fwpBDsz+r9Xll9dbC5JH7JFUIHZQpqocfYp5NS0Go1L?=
 =?us-ascii?Q?qB88uKai8vjlNTHL9DYS5Wvfbo4vb/gilMyjtXW+efPWTH7Zr3yzDpXo3ioj?=
 =?us-ascii?Q?MslMcUfQcpqXudH/D+/gm7vyezTTig0SorMNdianNrr/ay+RyCqZhvnpeI4K?=
 =?us-ascii?Q?c1P7KGWKELlguyDX+TOHE0sQla7Ty8j/M6SKxE0JLv9zPSjRbbi+vWGNo/qB?=
 =?us-ascii?Q?fTaObM+7UPC0IqT2L0KMQ7Hp61TeeiO/3lE+ogbjU2csbBLVxm4S0kNd7ETS?=
 =?us-ascii?Q?gShlT7aFWaS7BObNzU++dA81sWs1xe9AHEnAluzPGLbnd/I50Efn9CtkiPSV?=
 =?us-ascii?Q?HqV54emGYaAP1NjRXdZ0UTVSxHUe8R4IKMmJoqeenRxWeJjq4WTUScpYYafa?=
 =?us-ascii?Q?WOC0udpQUiT3Ihk+Nf0Jhre4WMst5Y6T3SDGCLq8kHbsFe3N3Fq/0cFPp5gb?=
 =?us-ascii?Q?i+3traDn3no7Ki73tCwBB2EbM0NEBTZKU5EaPrQEahX2+MB3qT418ave4BP3?=
 =?us-ascii?Q?lYg1iFdkGqd2l84/OBH1/HEB/NaClg/9Lt+PHqmrmnNfBOeznjPJ88A8uq3i?=
 =?us-ascii?Q?QqL4CAQAVY90IYlFcU8kiFdTkwFCAcVZQcfSIZ6QNLlOK0XBaCytkZ4fIozF?=
 =?us-ascii?Q?ozpfz8hVUWSbxRF3ZRG6MOvhRaaJy924g3TP95aCo6IQHsPNIWoyUfHt8nrj?=
 =?us-ascii?Q?DiXDzWe7vj6t2nOpf+ZbbXWa5SQcjBtbOENSZ1bEscw/eLpP/w7yQxXSPO8M?=
 =?us-ascii?Q?lfEcC4Dg+D2X6wzKb5ArO1qcZTlHCPkol/8t6T0iH7JorHXhLBOkqVablBFE?=
 =?us-ascii?Q?rR+exNlNKdHEfWHarswf+ROMp1L0qLs/jP/uF3krf801dZCgZSqf37xqBs9M?=
 =?us-ascii?Q?oIqtjvRcdhU5qiCIUpMgAT/JPXVDbBQ9/Vwt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fkIalIFdnvtuQmkDLycV1IF4hDwvg8W5K6cwx56s8ultNBIM22idP3hbDapd?=
 =?us-ascii?Q?dSNYAhhyiJ3zVpZ8dgc4vExMAmfapaT95z/0x+Td88tOCqW+WKnx44F5jQF3?=
 =?us-ascii?Q?kYHGdJSUsBUY6GjA/SjWEBo1onKvuaGbjK9Kc/ebAU8j/jz9rYLuBNgHL2t1?=
 =?us-ascii?Q?njw2R+TJGwTcykmQy9uSJ67ooA0+5DORsOsUrcU94l0CXDaR3MqMjlq8pAjC?=
 =?us-ascii?Q?yUqmvEhUPMjWqGi5XU9DJDqr/2W/+fU2rJ743mVkMykLYHYDZx0nAwF5k2w+?=
 =?us-ascii?Q?08U6APuETMdutsu81UxnqRVYq5f2T6WdSTR2XSX32TtozKcDBVCnIPjJA+0Q?=
 =?us-ascii?Q?sX1MjjQ7qk4HxvWCl/oigp61KGTi90+xH7FfBirNE+ZtV+lBPLF2Jpez1c09?=
 =?us-ascii?Q?oZQT6aMk1MNFRnkMneSSZWtzwEQgVLkD7GTe8gWgOvPPYCKVOXCfJbFJCG/3?=
 =?us-ascii?Q?1QdDVfo4b2uXZ0BJYzrIxdfPfngz1uqzkZJXLNWDaxiwoi35/a1N53hNaMEQ?=
 =?us-ascii?Q?1RYVIGyvrNkcBeSsFMiogk594REJ8jye9rWx2KjE2aspeL2a+rhBin8CcmUq?=
 =?us-ascii?Q?sSEX/ERfEnzXsHT4rSYlBW9cJ9kxn/4sq6CkYWZkx8Vq3VPkb7oTTBHSwOol?=
 =?us-ascii?Q?qPrpBjf4sHylIZBGmDqj8JvOJjgRKgr9jju7AMizD1j5rxSMwSS92uLc11aJ?=
 =?us-ascii?Q?DcMTacFMhDFpeVCkz1Kj/xEn+fU/4HGEe3yhNn/+ECs0fLiu8lXMurmYG4k1?=
 =?us-ascii?Q?G4fhosPh2Cr+QfaHkTjED//wtsihYc8XWYfV3k9k5/pn2fe0zlfrDaVtezRA?=
 =?us-ascii?Q?0LkQVjYi88V/a16GJYnLnZ5PEfTLBXM1/4ea2Pex48smQTfK0SWdaSd7rBgU?=
 =?us-ascii?Q?Cz/LAJov43hHQsm4bHS6vBPL/lLtFdIO5ex8Xew+SDZyi/XcRwGLcoqfXSpv?=
 =?us-ascii?Q?QUwndo1MgQtp1or7PRxPMSf/x4597JbfZ4Si8DlbF0qKT7uAG7tT1gEN1D2m?=
 =?us-ascii?Q?X/2wv9lUJzMkG3SNN9IPNCdGSYts6+Pr2LDjTLm7dHxiFuZiXsl2a3o1OI44?=
 =?us-ascii?Q?jWcVHULojVLiNz8tGVl29ppjT2ibMYdWfcmQho84prDOrkfD5z0guHW9z+wx?=
 =?us-ascii?Q?ylBKkctH5HMeTvyB+NFMmRXmuICRQoEh0RQUCSBP6NVlvGLmpnaDjPNpMVx2?=
 =?us-ascii?Q?Wc5fWHAedzfa4GdRCNG8Q2SvJFL12G6BWWEUFAk3AXGPTNLNckqn1f4OIMgM?=
 =?us-ascii?Q?+YS5LTiiIJbf8Tc2STZO9pSQ+wnSz5doMNBQ0rUZb0e8QsPOPclWZNqeADzy?=
 =?us-ascii?Q?9T8wHE0YLQGQDTOsvwKdO5Pgo62apaYcndibXG04E2TuRepJ9Whk+WI8rSd5?=
 =?us-ascii?Q?BlA2ws+GkvGOjk/b5lqF/2xejYeUF+gqgF9NiuqrWiOsVbAE+SDM7TmHP2SD?=
 =?us-ascii?Q?pwkhvGS/aPgmgc7vg95BF7qpqob+KzP2ss3FIMSFtMqlnkdwqXdhZ1YmNn8d?=
 =?us-ascii?Q?RAYmHlYDfGAXaCMfkKyNtymeJ3G0RnOPiFMZfpqXWGamMXC4iMX905C2kkcp?=
 =?us-ascii?Q?W0eT7wxQsNom+9yIJbaJ4MkftouNIXV7qCb0xxcR7A5BHfclLtihfpRZRgiY?=
 =?us-ascii?Q?ON9TY3vd4nD/yfsj3q8fmSI8O+eUwSbqkWEZYFECvzjEtQiFOijaxPw5L7a6?=
 =?us-ascii?Q?4/v2kp/RLe0iGoDCfhHPyxEkS9Df3TDXPOuWj1I11qsXPwAF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb55fe6e-873c-4176-d65c-08de521869ba
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 20:23:14.0712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BqokH+3kFVwjCepq/Q4aV4XIWd5N0vQcCbMgnnj/ajE/eosYu8/XLPTP4boBFuWncmO9qiLmH3d+Td0020E/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11369

On Fri, Jan 09, 2026 at 06:35:40PM +0100, Andy Shevchenko wrote:
> This just a set of small almost ad-hoc cleanups and refactoring.
> Nothing special and nothing that changes behaviour.
>
> Changelog v3:
> - fixed checkpatch warning (mixed tabs and spaces) (Vinod)
>
> v2: 20251110085349.3414507-1-andriy.shevchenko@linux.intel.com
>
> Changelog v2:
> - dropped not very good (and not compilable) change (LKP)
>
> Andy Shevchenko (3):
>   dmaengine: Refactor devm_dma_request_chan() for readability
>   dmaengine: Use device_match_of_node() helper
>   dmaengine: Sort headers alphabetically

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>
>  drivers/dma/dmaengine.c | 50 +++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> --
> 2.50.1
>

