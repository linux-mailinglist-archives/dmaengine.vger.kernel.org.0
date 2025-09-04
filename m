Return-Path: <dmaengine+bounces-6383-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D3CB44036
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04C1E1C2591A
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A223128DE;
	Thu,  4 Sep 2025 15:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="JUK4tbBA"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011062.outbound.protection.outlook.com [40.107.74.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF39030C620;
	Thu,  4 Sep 2025 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998792; cv=fail; b=ayy8uqd/8/ZE+tGucswhlhVqcXtaxYvcYS2QJQ9JqRQExGTMoMrgrrv0LhZqTRHba/lzS0b0zUUqGlAXOuAjGQBatiqdDnBrpPiG5J8ISJ+UA009ugAjA/spviDsKs+xxpKPPXPzVkejelagtJytfSZIdq0QAxnax8GYtc/SYPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998792; c=relaxed/simple;
	bh=WSy+qQqAdKtcFUOk4OdMgTHaDptnSXvD3OGIB9Y68dg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z6yx9taZ9HoJRCCw2rC0jLKAguNtmBZkSQXlmSWxw8DCars/7vyxBA1KahFm2/9IxjsjdN8NoMOtx6t+Z448xhLADs/tiE0fTMZXpb+Oy6GXQcvZ8KcajCI9nrPnQ+AMADNQ7u8wXUjCh+8MPFZPud0/jinPplctoWiYsFIU8rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=JUK4tbBA; arc=fail smtp.client-ip=40.107.74.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKo2kZQ4XR3RwOVCxcKjdI2Xt17OybCYBolP/HyC7VnW1yAWDKwcvCnBH+VCK5PpMByKL2QxFACfa5eQoKBkjOLiQsbAjnRBH0aIE2j44btXcE0U48O6ri6FH6m5lVviiKkqwJMCj31FhUtbRHwPlrnkbN1qiYdmc/Sjt7R/MxJ0JI164mC/6+eD53iXdftIWeokDVDriPBkb79laQkwknTldTPjMuIu7pLdxAb5hLjewRAHf3DDeB/8bncBBHPRulctoqw6B744Lp7muuDGzGBKV1u5L2Rc0uT8gWWaUHFw8MWjgbtB831oPb/Zpk9r/kYx/yDBxfbFVtyPkFNCeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moAq644tBNp1ephrH8wH/S7BOp+9BBReImtUaVPz1Gs=;
 b=CmTUPsG1K5d4vGst1GZnzvuYerDoFTdUeRR65H8IH/d9ANEGXd1H0ArBh01RF2RQTo8N58ennFoRdW6A+nuKydHsdjZjjzLlDVaiQ9hEZTKSYetGo9wk4hJhX4FgrpOU7YStWIehnHPX53gZSBlxC8vNJxN55c28FaBokJbRfqtx8h/QEONMACvfX3mduqvA+q0jSHPQjNH2Uq8JS/jcE9vhDNABMc1qoV31Xa2RU+1shD+wbu3YIWS2T/qcQbrxDz7UkwXedphjR6eU4kMijB3kjgkzCFJBFU9GxV1iHd0AsSjoi4SLYmvEPOjrAuDhHI6sFEKoxj9liXXoj4duhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moAq644tBNp1ephrH8wH/S7BOp+9BBReImtUaVPz1Gs=;
 b=JUK4tbBAFGTTERi2/FsHqlVamgdCtMj52kFGZ/gP1+Sy2TnLhrnczjmaxemPtz5hAqBInUvPqWIsHD5+e+AadSJKM9BrJfPMFaeb6SYJMM2jAGryFpntiTOyNcLXEqQJDwIV8xA1OJmRKu7V+uJ4DGMaY5VoCrxmRROwQlWeEa8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYYPR01MB12225.jpnprd01.prod.outlook.com (2603:1096:405:fa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 15:13:04 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 15:13:04 +0000
Date: Thu, 4 Sep 2025 17:12:48 +0200
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: tomm.merciai@gmail.com, linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 5/5] dmaengine: sh: rz-dmac: Add runtime PM support
Message-ID: <aLmsX1un1tXwILH0@tom-desktop>
References: <20250903082757.115778-1-tommaso.merciai.xr@bp.renesas.com>
 <20250903082757.115778-6-tommaso.merciai.xr@bp.renesas.com>
 <CAMuHMdU8WQsA_tXTpDvv0HQ1j=mawyJ2sMk3nuJJXgJxHOTeoA@mail.gmail.com>
 <aLmp5ILqhiWYJrw5@tom-desktop>
 <CAMuHMdVn1NHdD=23wfpXQHaR48kcZwiDzb4xQhuCENqL3X_EDw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVn1NHdD=23wfpXQHaR48kcZwiDzb4xQhuCENqL3X_EDw@mail.gmail.com>
X-ClientProxiedBy: MR1P264CA0156.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYYPR01MB12225:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd9faf0-2b36-47f0-d7a6-08ddebc58bf4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TvrVb/dzINZ2EOlin/u6jwLx3ESBGZ6iix5gEcBU0TLC/Oh9+MPqDhr+1FbL?=
 =?us-ascii?Q?VoCWlyeLKYs72AMETns+a5eyhruBwRuEzjjh+uQlgKDa2vKc62DvfxiM0VOW?=
 =?us-ascii?Q?+KAynVSVHTD4ebNEwZd87BWsfxi6BDncwtQRYUpUv/4Fed0mQOP0+Y9UEoDV?=
 =?us-ascii?Q?iuHum4P8ZnLxSj5/tNvaLTaWAywSjuXfExslSylXI9Ca9DpLJPgx1xyO0MFB?=
 =?us-ascii?Q?xZ7wmQDKbeaEN+QkyXZ3xCqnYd/7VHs9lSqKD47Wg8hpUv28xti4fKCL794W?=
 =?us-ascii?Q?Y2EOjofWBMBAYDxm8htri9pq6KJRJAw2ykW04i53OaJLGKVhXh8KqNq9Iu5Q?=
 =?us-ascii?Q?FTVR0P3E6cewmhtbdgrIB18CxCFyX8IWCC7f0sR/WL+a/Q/ahMICAWT/yTZ/?=
 =?us-ascii?Q?tSPyErZ/U8RKAkrNVe102Iose13QT4mG17eOFr3uTbtzfLoFfw3iI7iSjhWp?=
 =?us-ascii?Q?RoKZxKW1xcd8wH2lqDGEUvMHGG3s6wYl27H+NXkmZ8lylI9YMfqiqWfMy8w5?=
 =?us-ascii?Q?nzLRW3MeSIL4CK1QnS4QyuP8C5eLdYILB4LmZN5+m3JA3Usricll96JNbJMo?=
 =?us-ascii?Q?BHLBsFOWIgBoj/Q6tPIOAUYfuxjZuq1FuVHKUbAXjn25INUJj+0rhGWw3fbC?=
 =?us-ascii?Q?O2/t9D9paBdgoll5Mh1kTmhlCIguEOBLAMR9zvzslfpqqM3qj85hvCnyh18y?=
 =?us-ascii?Q?XURQVxqPlBk/x7+7skm8i0hKaWwpuy4pms70tpI3SgoiS+5VmQ2Fsa1MiUbx?=
 =?us-ascii?Q?+9RUfZ8VCJW8VpSTFAFHgbhwsDgXmaP7eZZxvyO/BgVZSyotiVkVIAoaD6fx?=
 =?us-ascii?Q?6ludiPGmEe1SNCgkr0I/buexJyQSWkixCgQ3ED5HYSdB1iFa2ry2/oTddCOz?=
 =?us-ascii?Q?4I8PASckeFQB3fNuhyOMJHT3iFARVfsMKaJmYTUguznGXMckFSQdMxbJ4VFx?=
 =?us-ascii?Q?JLjnxRefuu1jztZYrUiVZlMnt+bFqXu+hFnyfl+lKaHid4/O70nf+UMrzNOq?=
 =?us-ascii?Q?d7FHqoLw8KSF7Dzjb6IL+e8whT0HA8w9M8EWzuTxZ2CR8gCl8rh22niw0xe/?=
 =?us-ascii?Q?48Cowty2ftvH66UjzVlO/mw7kT8pb07iQi6zOeigIoQLSCehISJ3GxZSFNko?=
 =?us-ascii?Q?xJhVoupSMwnrsaWGroBR1N3njV6kAXMSVAF5be3KhIVgAub8e5Vgk1YGO6ex?=
 =?us-ascii?Q?kXV3hUBRtANJuys2JdxNCmmEQNkDU951Pgz9uGUcUXjwGAx4hH94xUR2W6Gr?=
 =?us-ascii?Q?/qatL1ZjMu+3WEi53ntkEMR43fH1ifoJ74+6A3YvqihMRAas3+KOZ9pnmzqi?=
 =?us-ascii?Q?QvpEFUCdJwrnmtke73+7NvSNdjkUOLLx6f30qHv/jduuvqeaEOnGsPlWKLF8?=
 =?us-ascii?Q?Ws6lF053NdI03Ak0GNjL70c7RsG6uzVTBcTQiaT7ul6Hdrnkjk6pBmTnbcZH?=
 =?us-ascii?Q?jl8fv05LX7+Fuap1iMPG1/T+hpIsoWCksQ1EAT7CXSlMqVH7mSAv0g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DZdnuv92b3T+gFDi/p6zYPu/56wvgk5A+aXR7nPOwT8HLIEQn6WFuNxl+qbB?=
 =?us-ascii?Q?29t5qD/m9DFS0PsSgAiDA5kqYgpOqWuwu5BJaLLAPGDoHXxrkMzy+QeCBGpj?=
 =?us-ascii?Q?E1z10TXOgtClfB2rNflVoQM7P/M9rZUBC1dfMDLWbD0S7rg2WtqC03NhIQy1?=
 =?us-ascii?Q?VsAq/mZTWnIRZo3eKxeUd4z+Knu+l4dVJIyu48KLFI1xDqaB+M3Sc5EYekHj?=
 =?us-ascii?Q?+hubB3HrYq3cNZan9DNJiv8RnY2DsWqHOcGwgkBiW5rPvTrcin0Z3h2QuOR2?=
 =?us-ascii?Q?SyujyW49ZDevFP4uDQ9MZviex9amdbBbW5DeBYD5b3fXde30SvyUQ3KQmF63?=
 =?us-ascii?Q?QGaCJ2PDBNGdW+kvHdmuIL6xlczM1axx4Wq7nE4TDTaxNij3gh+dYPOSYtwT?=
 =?us-ascii?Q?+lf/u1721M7GsY01dmjmcJsO1GTpNg8C505nEioQJ5B5YI1SA0TtrM+zXWgY?=
 =?us-ascii?Q?a4LNs8YCZWCRv4D1UNr8xGnR3OoBqovEgsAHP5baV+e3K8rLlUhJNYMeiua3?=
 =?us-ascii?Q?C6wdyQY2nQIUgCfPxVWN7cFzOUYJuwwvXilMEqqBtISCvv0MZiUTuMdAM72X?=
 =?us-ascii?Q?dDxg/Vr88S+LX2tDrL4RfHUIqiJ7baBnnozClzsfimrq7uOQRvrrW6roBRiD?=
 =?us-ascii?Q?MN785FmrHgqkt+8wr+4YSGRkuy7XSeiIrNKMd14ZsvDBqi143OSXcqd3xe1e?=
 =?us-ascii?Q?U20AiyKlSlFV36sRbtqIC6ImQycQRrHd8rhBGvYdCcsjsBY2118XKyWfeJR+?=
 =?us-ascii?Q?rqWLsJJPYwUW7tGakGbLyEynXRNU2Eo27GUqusjujQ3+HAnC8R00kGJUalMw?=
 =?us-ascii?Q?SSic556FInByDetqZsVu4kONRhzVCmvWhZv0kSLp9D77S2Bx+cUd9xXcXjET?=
 =?us-ascii?Q?W5g7gttdFIkDUGT06XN+m8OuX0TnXXue5Ks+Ka9SvSWr4eRzaQb/NSYntZko?=
 =?us-ascii?Q?qtmQRrEO5zIlkvoy7pR8m8w/Yy8mcZ1gnRmwL1aN7IOZH3S5ycVwmE0UV+bV?=
 =?us-ascii?Q?4iavRkU2atgI4VdmYrlrPYP8nMYixkJC352HZJR9mmD0Unaie8hSD4DjOwCD?=
 =?us-ascii?Q?a4y1LMEIdp/8Qa/USP4skgh7SvY8ZLBxyCD/RRxpfPncrOpzpL8AC8XaL0yl?=
 =?us-ascii?Q?FKIfey+e3/gOi9qpHTtFDU8074866aa/kLDKbgJR2uK/iVP81dkAJQUiDpK0?=
 =?us-ascii?Q?VjBiZOIE0a1tC1qL5p0JzkxRhAadg4V7dSPFKDPB71FN8ND6XXfl48Hr7beU?=
 =?us-ascii?Q?Hh/qRSZPjIYsEqIJajy1WeT887oOhTqluCuXbVDVyPfvOPzuCvl4QpJZK6vz?=
 =?us-ascii?Q?EfDiCkJysryS5194iVV8oqGDL+Td5iKhB0y8aOCH1Lv5OCutYod0Dy0RiQOG?=
 =?us-ascii?Q?R5nvW/Xe+gIUFaQV2QAjugnAhlvg1HCSFvKmPeNM1xMEExGJIIHIE2MpHCBM?=
 =?us-ascii?Q?FKSMHkbACd/eDAdjYPDDkywobVqnpbMouWHmMpAlHXcPkhYI1MMyAsil0e3e?=
 =?us-ascii?Q?/4bquiTYapxWU6ST+ibxGYWDK3TGkR4AiKbVoBVFqkfb8PJFLhdhL4oXyEhY?=
 =?us-ascii?Q?NhNFG387S3CMZDpXVQmzrJPUMU85w24ueRxggr5VrvSMhezmnKKWmX3WAGUQ?=
 =?us-ascii?Q?nQE6RBYdmaW/Pwhx6xsAHzc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd9faf0-2b36-47f0-d7a6-08ddebc58bf4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:13:04.9102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +7HfYxzD8cPSbDgsKOa0arDjCFqb2ZSluIA+AUwDb1r0esUilqtTSHI+RgS7qs0e+eAamIr/lS9Butn8sdxpEzKu12hvSOOq8b6ggOGJ8REq1RRdT1YqpCmDdDzUWZN9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB12225

Hi Geert,

On Thu, Sep 04, 2025 at 05:10:41PM +0200, Geert Uytterhoeven wrote:
> Hi Tommaso,
> 
> On Thu, 4 Sept 2025 at 17:02, Tommaso Merciai
> <tommaso.merciai.xr@bp.renesas.com> wrote:
> > On Wed, Sep 03, 2025 at 02:17:53PM +0200, Geert Uytterhoeven wrote:
> > > On Wed, 3 Sept 2025 at 10:28, Tommaso Merciai
> > > <tommaso.merciai.xr@bp.renesas.com> wrote:
> > > > Enable runtime power management in the rz-dmac driver by adding suspend and
> > > > resume callbacks. This ensures the driver can correctly assert and deassert
> > >
> > > This is not really what this patch does: the Runtime PM-related changes
> > > just hide^Wmove reset handling into the runtime callbacks.
> >
> > Agreed.
> >
> > > > the reset control and manage power state transitions during suspend and
> > > > resume. Adding runtime PM support allows the DMA controller to reduce power
> > >
> > > (I assume) This patch does fix resuming from _system_ suspend.
> > >
> > > > consumption when idle and maintain correct operation across system sleep
> > > > states, addressing the previous lack of dynamic power management in the
> > > > driver.
> > >
> > > The driver still does not do dynamic power management: you still call
> > > pm_runtime_resume_and_get() from the driver's probe() .callback, and
> > > call pm_runtime_put() only from the .remove() callback, so the device
> > > is powered all the time.
> > > To implement dynamic power management, you have to change that,
> > > and call pm_runtime_resume_and_get() and pm_runtime_put() from the
> > > .device_alloc_chan_resources() resp. .device_free_chan_resources()
> > > callbacks (see e.g. drivers/dma/sh/rcar-dmac.c).
> >
> > Thanks for the hints!
> > So following your hints we need to:
> >
> >  - call pm_runtime_get_sync() from rz_dmac_alloc_chan_resources()
> >  - call pm_runtime_put() from rz_dmac_free_chan_resources()
> >
> > With that then we can remove pm_runtime_put() from the remove function
> > and add this at the end of the probe function.
> >
> > > > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> > >
> > > > --- a/drivers/dma/sh/rz-dmac.c
> > > > +++ b/drivers/dma/sh/rz-dmac.c
> > > > @@ -437,6 +437,17 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
> > > >   * DMA engine operations
> > > >   */
> > > >
> > > > +static void rz_dmac_chan_init_all(struct rz_dmac *dmac)
> > > > +{
> > > > +       unsigned int i;
> > > > +
> > > > +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
> > > > +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> > > > +
> > > > +       for (i = 0; i < dmac->n_channels; i++)
> > > > +               rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
> > > > +}
> > > > +
> > > >  static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
> > > >  {
> > > >         struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> > > > @@ -970,10 +981,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
> > > >                 goto err_pm_disable;
> > > >         }
> > > >
> > > > -       ret = reset_control_deassert(dmac->rstc);
> > > > -       if (ret)
> > > > -               goto err_pm_runtime_put;
> > > > -
> > > >         for (i = 0; i < dmac->n_channels; i++) {
> > > >                 ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
> > > >                 if (ret < 0)
> > > > @@ -1028,8 +1035,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
> > > >                                   channel->lmdesc.base_dma);
> > > >         }
> > > >
> > > > -       reset_control_assert(dmac->rstc);
> > > > -err_pm_runtime_put:
> > > >         pm_runtime_put(&pdev->dev);
> > > >  err_pm_disable:
> > > >         pm_runtime_disable(&pdev->dev);
> > > > @@ -1052,13 +1057,50 @@ static void rz_dmac_remove(struct platform_device *pdev)
> > > >                                   channel->lmdesc.base,
> > > >                                   channel->lmdesc.base_dma);
> > > >         }
> > > > -       reset_control_assert(dmac->rstc);
> > > >         pm_runtime_put(&pdev->dev);
> > > >         pm_runtime_disable(&pdev->dev);
> > > >
> > > >         platform_device_put(dmac->icu.pdev);
> > > >  }
> > > >
> > > > +static int rz_dmac_runtime_suspend(struct device *dev)
> > > > +{
> > > > +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> > > > +
> > > > +       return reset_control_assert(dmac->rstc);
> > >
> > > Do you really want to reset the device (and thus loose register state)
> > > each and every time the device is runtime-suspended?  For now it doesn't
> > > matter much, but once you implement real dynamic power management,
> > > it does.
> > > I think the reset handling should be moved to the system suspend/resume
> > > callbacks.
> >
> > Agreed. With above changes maybe we can move all into
> > NOIRQ_SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
> > With your suggested changes I'm not sure if pm_runtime_ops are really needed.
> 
> After these changes, you indeed no longer need any pm_runtime_ops.

Thank you for the quick feedback!

Kind Regards,
Tommaso

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

