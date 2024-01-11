Return-Path: <dmaengine+bounces-726-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F273382B27D
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 17:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681B01F25202
	for <lists+dmaengine@lfdr.de>; Thu, 11 Jan 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA6B4F5F2;
	Thu, 11 Jan 2024 16:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jb2fyZuO"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130823B193;
	Thu, 11 Jan 2024 16:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SO86N7X68ksbhpeOmADvtl/JIA7qAPrNhXtw2ctOJYMPpDjNDBae37/qwdu+01nXJOyny1OFVIsdxRdpvNqjFbLP9dXO0rlcsdB53Ge138hP5H1+FNPfqYi0DVcq/36j27Q8kzCcs7f41FJNJfXSXNPZTiGsj42YeBacyNomDGtkjbF62Bv/XDgMRij4mT4qqWdpN/YSSfcD8BLyxnwbHiNwJaYKqDxERWUvUXXxwXuOM5XtoG/YoIB0GH2rxp0Tknen6MBCmi1n1xxvKiDWrrp/Yh2Q7xxY9fjob8XDZP2zPKHMzdg+vvjCve867PPPDaz8t6QaHAtJcVTM3+QqtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTS4IQNsDXHG7aIBJ9ZwW45udhw/kN+YghsHriV55eE=;
 b=jxs93MwMqieg7CBmj7KavvRurOntn2zVSTzrP64ne7wtDZVoxzmmvineL5FmMwWmLifa/ip6d0EAUGhpxYJ+9l8qg64f1sAEIg6elvNRHY+h34kYppudcPI8fK3OFDHef26gQKkE8+UZY5vzHEVV7GqIF0ur06m1BMnbBB6TpbV8onUfmRttr1b5rfjxH4/cmu4NauXEmltCxml2p116Ulp4Plxs8V90/S7AHGpcU72wvR6+WY9Y0rj9VdMilrmvJ+st23WzDur3Jl5k4wugUcUk6fCmWnYnz+oRD3g+y5Df5vQUcg9XIE2NGUV2eGa0ew+5GdZw4eh8Ihh+1JOiRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTS4IQNsDXHG7aIBJ9ZwW45udhw/kN+YghsHriV55eE=;
 b=jb2fyZuO7xvfLvf0tpFvOIWMf802RDJFHdwOsS8V5c1HVhAI6a8UvCeP4S5x9UohT2QipLXeIYq9uY071VKRNs8zWNB4l8LNqLATRRnIWLt1ipwZjXE1aJ93UGjwfoNXQRqj0/Qim9dyn/FZMr08hBEbm/QwtgpWlAvJ0f2eD0w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com (2603:10a6:20b:23f::5)
 by PAXPR04MB8765.eurprd04.prod.outlook.com (2603:10a6:102:20c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 16:09:31 +0000
Received: from AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469]) by AS8PR04MB7511.eurprd04.prod.outlook.com
 ([fe80::8ee3:bac5:a2da:d469%4]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 16:09:31 +0000
Date: Thu, 11 Jan 2024 11:09:22 -0500
From: Frank Li <Frank.li@nxp.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH] dmaengine: fsl-edma: fix Makefile logic
Message-ID: <ZaASsqnq5ZYdcjm6@lizhi-Precision-Tower-5810>
References: <20240110232255.1099757-1-arnd@kernel.org>
 <ZZ8wMWQMo4eGnSuG@lizhi-Precision-Tower-5810>
 <343cedc4-a078-4cf8-ba3b-a1a8df74185b@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <343cedc4-a078-4cf8-ba3b-a1a8df74185b@app.fastmail.com>
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To AS8PR04MB7511.eurprd04.prod.outlook.com
 (2603:10a6:20b:23f::5)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB7511:EE_|PAXPR04MB8765:EE_
X-MS-Office365-Filtering-Correlation-Id: ef9d41f6-e324-4546-232c-08dc12bfb1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IDASIq+du+lFPuMQw3orQvUeDZhDCFr81LlYlMH1I2pZsH+9cIxBAHhvtec9y1KvsnhPkpqLT1G8JVjgblR5qORlV438JAkaKvII/IhKAZQfx4/FS/YOkns73jImbYrbzpSG59DMv6EQeYV4zVyA7DQGxSvtaTSfMMmRSQ8YVpbv7cFJlGAvQxkFhTBYlXOyk9DHUJjUrvPpQh9b1N5CyLQwaTkqHAj0EV2vFgzco941tujcT74KfdyhrVBR/EJe3r4ilZApO6WWaJ4/dX8PVyGr0RP1LrhnYg8XO9v7VSHVaL3NVNFNVVpnNYKliiqBM+k2r3ODn0GIeQ2Es2eD7iZeAbvY0TqaTZC8ZdO0OcSYRBkTfgjBEm6C3mUaXmMuyECf92O8kCNfmFP5DYfKv4E9dTXfj79E0pBgMcoVcbQsWQ799d28IHvvPOmnDbnFOefYJEECyf8NqMk/I39yKrToqYReV3FuMUzPvQCCPRZ3T8X2VWmcxJQg2bY5MlZyal+Nb+zunQJeA/ySuIEk0Mp98UiR4IGDnSywp+0zh3B5AC2kXIDZJaiq6DPpWKDdgfvCLf4Tcpaai/S7zsv9ECZ86+oMhmkmhPNrzgbHpI6DhReLsViDm7Kz0yUs/D7y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB7511.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39860400002)(136003)(346002)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66899024)(2906002)(6666004)(5660300002)(478600001)(6512007)(4326008)(38350700005)(41300700001)(6916009)(8936002)(66556008)(66476007)(316002)(66946007)(54906003)(6486002)(9686003)(8676002)(6506007)(86362001)(52116002)(33716001)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?26cqKAndKbs/gp0Okx6qDlQ4S0/JF/dsbS6sxQAQjnmB8HoN6i+EsON1vs+o?=
 =?us-ascii?Q?/D2+Q8rVShhfM6URFeRhlappwTfwhyRL9hDxCh3JI+IRR+Sl8dEeeasTChHY?=
 =?us-ascii?Q?34mST7KmHoeFVenzHgY9DkTN1mc5knpdYzDSz6A1tbaa3lawq8jGRbgneWHA?=
 =?us-ascii?Q?3it2uSEWg+ryZeyMm7TgMnE1KilTk8+GEq3y1OYB8rME39hVSMty6kmN777S?=
 =?us-ascii?Q?AO6hy20y6Wol8mU2XeeDvNZvwA5zdhaNFUxiZeiO6/eHTtjaJz+ppf4pk7gk?=
 =?us-ascii?Q?Zwz83JpD8gMp0SHLUsHkukhtioXyagvc//eZPbCKeNCG7ndXXjmK+vtBtey4?=
 =?us-ascii?Q?nKFDPvcv38dSCiKYAUfz9Jv6Jer+EJG+tsFquAoallt6LKIMtF5E1NdsxP0S?=
 =?us-ascii?Q?ADVr3L9gsCzHC1HzG9D0y4viDBnUKoa51Yk0g/XpSEUBYtxt/fa/oT5ZazCz?=
 =?us-ascii?Q?92Mg/+1dhWAE8hI+80ffuM7IaxXc9DphfuYRils+D3E2EYtV8mezd7Lw8/q6?=
 =?us-ascii?Q?EAjqGebx5ptLJr0V0AfVUFJlOlP9Dr+wW+aU3GQjKBILOD9YfFXQF7LuzFsz?=
 =?us-ascii?Q?+sHjEAaKJVx1W+ERSX1wxc4azl1ob9IezBrWD29v9pHTDB7dFCQ8ak0RzsPM?=
 =?us-ascii?Q?5iLdS45JBXyfCBjekb39kGWTWATBUd7bXhnD4CsxPM/HtPZnDXCzK+RC+rZc?=
 =?us-ascii?Q?q9OnCPgodUr8WIQ5qfkMuZDCNEC5mwvjKjV6Ck0ekxAMGtk+GcZwFZv9C/A/?=
 =?us-ascii?Q?NygLtT0actYalF7IuDcMmKtPZ22c7etOrYk63Ywc7CNQXxY/Rg9OYx2spzCq?=
 =?us-ascii?Q?qXw6mYsFT8U5dZjeAcRf/QxndQdgWqFF2z8avD7oNz0bhGUjhrKdAF3FUjXA?=
 =?us-ascii?Q?yyanXNVpq/E57uarcAYQIJUaFv7dUY1wqNheBGRjAvDY6QntjfsEsDN8TFZA?=
 =?us-ascii?Q?b6BiNJqk7jTAioGykJP0F+0peqAU9sDlk9lbQ8gvHgK55H+Pt3QXJ9dUOlBw?=
 =?us-ascii?Q?RLjpbE8CAZMLDk+8EaN/MLTmGaM7fg+9kcB879cwDDUkrJGNKMaoSYAQe55A?=
 =?us-ascii?Q?U2v9ctLP34WAHJwNM87Nc9N4QlY2DQe1Y7WVzSidQOKIoBGlJXaqENn5M4Cf?=
 =?us-ascii?Q?745Y9nLUj1KUDBz86grsWs8rRkRl6q4JYTNrN1AhPI+oqANv/ftnek5QTGXa?=
 =?us-ascii?Q?XpcuVYwifBoqa4qXbKZkuY7aCOkHQgaS8rxnSt3KV9xiDuy0IbcOBsOIn2zf?=
 =?us-ascii?Q?cIHE/VdfH57ufcuaq/SjCN3j0D4hze3gqs1d/fJzHGuei7Tq/FKuX4TlW75m?=
 =?us-ascii?Q?64yzI9sQmQrxSIswPVxrDjqBJi/Il6c6vFW0oBPVLcB0sUCO6FR8apLp6Tze?=
 =?us-ascii?Q?RG/DD1bwof11vgyISOZIrHjOxDH/t1mNuGRGgfevZ4u6lRptvj9tgLz2RbsP?=
 =?us-ascii?Q?R+EUJOefAw4YGoqwW3b4S/9/FcYFtOj9lIBa9cM/Usl88YDf/dHm9Cjc4xHx?=
 =?us-ascii?Q?WrP1aFNpMm+4EcpCLT6tWFnDb9qf3bQ2R9LC3y/E+WuTsLLn/ymVD39y4M2H?=
 =?us-ascii?Q?eItWd9N7LmEZYHCXldUm8OEwaMIBsjs1M2A1prar?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9d41f6-e324-4546-232c-08dc12bfb1c2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB7511.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 16:09:31.1700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RjpoCY+H5+wSqI+x967mwBLkEmjFYKzMX0hdBp9jx36Di3FBHCmru2p17OE9ggWVa0QTEWz+Ee8UPXePuRyFlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8765

On Thu, Jan 11, 2024 at 07:23:34AM +0100, Arnd Bergmann wrote:
> On Thu, Jan 11, 2024, at 01:02, Frank Li wrote:
> > On Thu, Jan 11, 2024 at 12:03:42AM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> A change to remove some unnecessary exports ended up removing some
> >> necessary ones as well, and caused a build regression by trying to
> >> link a single source file into two separate modules:
> >
> > You should fix Kconfig to provent fsl-edma and mcf-edma build at the same
> > time.
> 
> That sounds like the wrong approach since it prevents
> compile-testing one of the drivers in an allmodconfig
> build.
> 
> > EXPORT_SYMBOL_GPL is not necesary at all.
> >
> > mcf-edma is quit old. ideally, it should be merged into fsl-edma.
> 
> I have no specific interest in either of the drivers, just
> trying to fix the build regression. I see no harm in exporting
> the symbols, but I can refactor the drivers to link all three
> files into the same module and add a hack to register both
> platform_driver instances from a shared module_init() if
> you think that's better. Unfortunately we can't have more
> than one initcall in a loadable module.

It should be better link into same module because some debugfs and trace
improvement are on my TODO list. Export symbols will make more unnessary
complex. Or simple exclude MCF_EDMA by change Kconfig

config MCF_EDMA                                                            
        tristate "Freescale eDMA engine support, ColdFire mcf5441x SoCs"   
        depends on !FSL_EDMA
		   ^^^^^
	depends on M5441x || COMPILE_TEST 


> 
>      Arnd

