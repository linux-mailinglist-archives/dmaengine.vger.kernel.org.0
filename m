Return-Path: <dmaengine+bounces-6381-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB44B43FE2
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 17:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF6005A5AEA
	for <lists+dmaengine@lfdr.de>; Thu,  4 Sep 2025 15:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C774305E3F;
	Thu,  4 Sep 2025 15:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="YEUpf00L"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011063.outbound.protection.outlook.com [40.107.74.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667C3002C3;
	Thu,  4 Sep 2025 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998145; cv=fail; b=gbWqJxOnw3S/tOI3G8bdVvfn23sIYrUBZn2Jr7Cobs1atIL5NGGUy6L/qWr28G3fUR3zYjBXpvq15UtzimWR5+J/jP1QEs8wtZXnUzRROiM1+lhgy8v5Z2LYbbxAG4ZimiHsqKlzQuy0jbHag4aRK1z2CDwP9dOy1/3NVFJXEsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998145; c=relaxed/simple;
	bh=DSalUdFn4et00KiciUjZwJZfVxdkth0XWQzop++r5nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YItmmyNkHEIf2a2B9oC0i9KJbC755tkgvwO5RFMXlsWUpmm65zdCFdYyJ3QVH+MBNpfxAaABRlSQuf3xHoy+XbpRJJXMW6OdLZsVepBF12aGQ5d7GkYyvSZUaLjedOFBPH5l0Xst62hekLNlbCd2uGMTbJGF6qDPsqw5Vp30jX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=YEUpf00L; arc=fail smtp.client-ip=40.107.74.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORt8EFwhs0ZZUyHCTZnmnktG+t1d38ughcQRjBEgwkeT8+KRRq22lBayWLhc0iNaMMrMmTmu1UejmgxvrT5r3CnNfF++tlxp/1MjMN8+E30qyLbDvbQjm5IoGl85oDTYxY6qPCGGIUjcVp4k36rRc7ehixR78/tp126uI7ipXSZhZ6wGcm3DgqDx2xL2DyJhvLoAycskFScqIyMhDfhX7jWZlfdawZq5IpzcHQhsjSVsXXKiXlHpHb8zH6th6U15EJGan/mwFfq0bwUWujlMoUVGVT5WBYh1XQPm4rhqtXB+SUwOH7eCi4urNwfJnFdR0prA5YWqr+/qwQ3LzuPT9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CelRwr8g+PBWa5JWgtlI/vdXQjZG6nkMcAsrEC5asms=;
 b=yb8jTCFb4LJ1MS9bzNAQmrlfvvdaCXOiyGk60WBgcdAnl9ivfd1UIRrRqXS65Pn25aHGmw8YCB50Qd3JcvDwsrim3ird8wmqR6kfaQZpNafA5gWu+b6oQsxv4o2Ua1Geq7vT1r/h97QHur2IUyjAlRZOkA+J8BUBXZRRl6NB31KUS0pBtPdRG8MW8Yguj6WTS8UH//KPSxDEKKrDGaEw4pJhLIG8QWYNwFSvjv/i5aGcAxLdNWqBDXr9lc45YXZXGo5xrsoVbTp3cqnTKZO29faf6NTLrETV3vbgRXjP/KzXJyTenPxu57wB/7k4Py8wL/XaCsSJkB91CVByhgU5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CelRwr8g+PBWa5JWgtlI/vdXQjZG6nkMcAsrEC5asms=;
 b=YEUpf00Lkam0dmES1fhzKk/rzcCeSfHrB8vVdD3I3L9q4P4n60erGarK2ChBKV5PFaPuh2hIHWvVXiwFdMueFj9A4/jEBKBENGy4xvovYAFhBeIqtxGL8HEeoaqwRFWSXNBllKVwVshNoVVfdfFlcCQqMvnlM+gIUT0b37DWFKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB11241.jpnprd01.prod.outlook.com (2603:1096:400:3d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 15:02:16 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9073.026; Thu, 4 Sep 2025
 15:02:16 +0000
Date: Thu, 4 Sep 2025 17:01:56 +0200
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
Message-ID: <aLmp5ILqhiWYJrw5@tom-desktop>
References: <20250903082757.115778-1-tommaso.merciai.xr@bp.renesas.com>
 <20250903082757.115778-6-tommaso.merciai.xr@bp.renesas.com>
 <CAMuHMdU8WQsA_tXTpDvv0HQ1j=mawyJ2sMk3nuJJXgJxHOTeoA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdU8WQsA_tXTpDvv0HQ1j=mawyJ2sMk3nuJJXgJxHOTeoA@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0092.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::13) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB11241:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb10f2d-103d-4a33-12f9-08ddebc4097d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IPnBJxL72aBeP5AFzCrn625q9wlv4hs+mxtKQ+N3P1V86zEaxYxbwIcj1Fh9?=
 =?us-ascii?Q?6w8cJ45zNf0enjrXv1FR/yzEHWiSpL1x7rLLDooth9Nw2YSEJq0RB/lXWSD/?=
 =?us-ascii?Q?RcWjQ7H9wVwy9jjN8EMbVG9eyFx9onp9Kx9XB7ENqTasQWMEiq0+JrmhurxY?=
 =?us-ascii?Q?+ofBJ68mh/6yo5olLwbAUmse5GyVMHsyg/Jrm+nXJYOFQU9LXIUY/pEjXAjt?=
 =?us-ascii?Q?tt0Lcy70CqCMeZ8cKN8CM+AT3oMVmDoHJvVfbUdbaL+6BWmfWO6bRt7GhKRU?=
 =?us-ascii?Q?6EIrmDpi6nYR0ISfAYHnNzHqAO8pU6mF1phDo/TMeltzdeKotLEbeVgultFl?=
 =?us-ascii?Q?jCOk+2fbeTom7O0aThG6cxCD2ekNO9l0eV9auDGQBo/QCDRau7FK9XmKkURT?=
 =?us-ascii?Q?L19nq2o8IN6MFpW4nMyaM8ULVENVFZAZyzv0+1rKxY0eFD/yf3kX2YWd9lS4?=
 =?us-ascii?Q?ySnx6LKRVU37/bCicoKHar1jFlfCaC2lylK7bD6VGWuEDf+yImOIte9wYdtk?=
 =?us-ascii?Q?mS5bQTHEpy3W9xOOKW4IOV9cZtot/7Q/2mfwwbii4ntt/5RkLGa2lc+jwFAC?=
 =?us-ascii?Q?ffvOaxvDCojEHjki8ZpdUSRCYF9O3v3CvTIKZofWCldpS9bqqlB8VBTb1crI?=
 =?us-ascii?Q?ySCF9bca+S10/iSHPlLKAMWPNxvDw68JkrkMz7XSI/ibwvNkcImymeQK46ZM?=
 =?us-ascii?Q?iSkaZ7s+kf4+Q15WON2rOfJSYJvrZohePA+rXpssvxHu8oRVdqDnhc/IV650?=
 =?us-ascii?Q?DgZ0IZmMp/n6LM0WVjy6J5gTsXymJ+1BNP4tpKTfvBOpuoZnXswOBPGud5WB?=
 =?us-ascii?Q?G6X3wo6LbCM5hlzhGa+a+suKe5aKw9+FSR4oz8VdQ/Vii8h84WGWV6JkJuAa?=
 =?us-ascii?Q?8gPSV6JjvQrnGS/HWyMU41pIVqZsxH64yl/+f8wY+f5HUkihtTHKm9P23L0W?=
 =?us-ascii?Q?zi4IX9p2I32XF4qxzjltklj3UkGuQHsbafNiPWsuYG4kLoXAMFVUlr2n22B9?=
 =?us-ascii?Q?OSUZC+cAXNtrC1+TheHsBjCceXMuidq12Fqq4vcwZcq2Ye+SJbpAvnTHQ2Xl?=
 =?us-ascii?Q?5zAylVqSz0S4YWInsqlYFIkW6KIdS3lFK2bECRcTnhdcoq5lTHov6RncnDEm?=
 =?us-ascii?Q?ZQcCSExB8db9E6CAyHAOgMZD7UxDhUfadvR6+53tmnxMj52MID77L9+2HGKf?=
 =?us-ascii?Q?NUUOp8xoMt4xMcHXaS8403rgdUBX6LVuDS5rXujJ1+kSRcBdK1ffXH2oqwva?=
 =?us-ascii?Q?f067wYVN+bBBiRnVBYNYKa7UvMq7429Bsohbztl+9Td6IpmSRBAruxvymU7K?=
 =?us-ascii?Q?yHAk+K2ofU7djVkNGMZ+K1rzEntbNtsh/6bi0/8t78Sz4fXQ/hPk2exVgkzC?=
 =?us-ascii?Q?JneCNfvHHku/r+syGwRrP6mhsp27VDvcPuWnrfzCFqDMDSJPsPvu4rfbb4eH?=
 =?us-ascii?Q?UV/IU1yE9xKlJDfm5Onria3l28u0qkODB5IcGRPLpVzmMzlKFZfPeg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2dlNm2pFPUASqFTgNvvTHw7tvCC039LHYnsj9lGN+cd3UE487hs68e3yDD2i?=
 =?us-ascii?Q?0ZGHBj2gHlJhb3ew+ySrzt5ArwigHLd85Z/1DEEOCiu6NgKk441McpAFGdgL?=
 =?us-ascii?Q?Z+p0G3nbrhNVasoCuAeSnEgZjUOe3UQR3dvzYx0EYpNciksXN244YaNyfZfe?=
 =?us-ascii?Q?XYUOBKFxGRwpUGi2EFj4+M4IX2WTgRbq3U6J7mKH9bMON6o3S2XG7mZhq1aE?=
 =?us-ascii?Q?ZaEXLs91yJCV2UdbFTHmZgfUdC8V+NNARCb/g/J+GlDuV2U0qTSSFSFSc8ki?=
 =?us-ascii?Q?Zo2w6Tc5AywAoFu9TZakh1naq1LIqQU9GXfFTVXlp5QM3S05DeK4U0HIbitw?=
 =?us-ascii?Q?5buwtJ2es3wgi7eY1Vn1jD9ECJVCuGYdoKWePUBrd+mYl7E9foFvgliGjL7P?=
 =?us-ascii?Q?L/yUohJkagnvCbtcoG4CaZcTCCr8JpEuaToaKy0gdvJBmFbCmf7cWZgnrqmO?=
 =?us-ascii?Q?i/ZMBo/eaklDZR0SlksptLzenYgcBtBJTU5eP3ToDzSsTEwXxr91RSqByaKZ?=
 =?us-ascii?Q?flSvte/jvGG0+8RXmsKf2pug8FSylTHLxrzTiIPEL10xaCAl9+iqJ6cdLOv4?=
 =?us-ascii?Q?8R5oU5zT1UKO9AOn1Fl4P5mwWW3Ncu+cBo4gB4yH2zVnZLx7yOJu6M7iS2pC?=
 =?us-ascii?Q?2ZYp4cjFHUCxjn+3EV76z3/LtV/9ApO32bFMhcWHp6h1OuYjRkO5bu+6rPf1?=
 =?us-ascii?Q?K/vcfOhsCGN56PB2/1URuzihsaBKG/zV/h4f+XIU8ehIyhm///09pcdY6zFU?=
 =?us-ascii?Q?j3hNTjGOsrovBG7526TUuULOgt+MeILUzLpypYaRDqlYHl5XuUgWjYd9rBX7?=
 =?us-ascii?Q?aN0C5YK3tIu+ueXun5r/y1lJLzsEAuD4JOFfkVCQtyiLZEAZ1ypZ0aY41MHC?=
 =?us-ascii?Q?ZsuOocoFjxOCMPsCtyrM8Z5gVyfiS0/QRsdOxH9/VHpNvqpEAs9PoQhCr6CR?=
 =?us-ascii?Q?Xy3MPJIgzKP3NPP2WISYaVhKPbE3V8E1BYnVkXSN7wIONYbynTrdzljCBphj?=
 =?us-ascii?Q?7Ded9XTrQ9TiNngkBPeQqXdmv1aXS/vf+LL9jp3Tx2Apt+U2Q9ggYIE3qS5b?=
 =?us-ascii?Q?W3/UNxPZY1O9qIAZF4h9vCNWCg5A5qjaoICUwigmqc4+eJeYX4VnFnk6AkqE?=
 =?us-ascii?Q?Qe9tKvV6JWkQet6XGxnIUo2+W4IybsP7AcktrYyqyffndFRss4onIWgkktwS?=
 =?us-ascii?Q?Tg8fc4JbhY36kJu4BrGb04SV4egDVefSGdThoU9CcywFqyFLhX7IjbSmVWfE?=
 =?us-ascii?Q?xnrDbbIE/ujjC1Vx8gCO1Eq9rTuNhVdGRpu20wkHs3v/7QgIfLJA3g4Z4IAe?=
 =?us-ascii?Q?eVdLHtfNNHfT8gQeeNvhNDavuuzx3JutGjc6bF8IJtFZfIGGv0hCBM0JSxT5?=
 =?us-ascii?Q?9O5jHX/4VN+criOMhEQyQ0EitCJEl/nNeun8wFnEd33jaYIhEjdwHehWC0Yr?=
 =?us-ascii?Q?ZRSoN4+/Xjs47oonlrucMhzlIhi9BxwOjQhigwhS8xeQ0eC00zRt+ALjqR6X?=
 =?us-ascii?Q?zzso0TydpFrAlQptntxHu2BlYYmSNgRQLvL3/oddymk41rc8odpkxZccvNnR?=
 =?us-ascii?Q?CKc92cIB8mekfxqK6Vmhy/FflVatGknQcm1w+uNp9t59eZivDFoy0SDH0Yo/?=
 =?us-ascii?Q?/wzKMIbLOF2B0GZ/Y/TEJG0=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb10f2d-103d-4a33-12f9-08ddebc4097d
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 15:02:16.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +MYauuIbuPLGhNZX+wGEHT3bervGtuOTRPWDThdT1GiQivWluIpTfk4G2ycHZQs02K7LfAFBGWu55vRey3kLsjzXwlbo3zUWH9t/PMql7BkR3RYEQcbB8DJJlRFmh/v2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11241

Hi Geert,
Thanks for your comments!

(And sorry for the delay :) )

On Wed, Sep 03, 2025 at 02:17:53PM +0200, Geert Uytterhoeven wrote:
> Hi Tommaso,
> 
> Thanks for your patch!
> 
> I don't understand why you included this patch in a series with clock
> patches. AFAIUC, there is no dependency.  Am I missing something?

I was working on pm support for RZ DMAC when I wrote previous clk
patches, sorry. For that I've included also this one. :'(

> 
> On Wed, 3 Sept 2025 at 10:28, Tommaso Merciai
> <tommaso.merciai.xr@bp.renesas.com> wrote:
> > Enable runtime power management in the rz-dmac driver by adding suspend and
> > resume callbacks. This ensures the driver can correctly assert and deassert
> 
> This is not really what this patch does: the Runtime PM-related changes
> just hide^Wmove reset handling into the runtime callbacks.

Agreed.

> 
> > the reset control and manage power state transitions during suspend and
> > resume. Adding runtime PM support allows the DMA controller to reduce power
> 
> (I assume) This patch does fix resuming from _system_ suspend.
> 
> > consumption when idle and maintain correct operation across system sleep
> > states, addressing the previous lack of dynamic power management in the
> > driver.
> 
> The driver still does not do dynamic power management: you still call
> pm_runtime_resume_and_get() from the driver's probe() .callback, and
> call pm_runtime_put() only from the .remove() callback, so the device
> is powered all the time.
> To implement dynamic power management, you have to change that,
> and call pm_runtime_resume_and_get() and pm_runtime_put() from the
> .device_alloc_chan_resources() resp. .device_free_chan_resources()
> callbacks (see e.g. drivers/dma/sh/rcar-dmac.c).

Thanks for the hints!
So following your hints we need to:

 - call pm_runtime_get_sync() from rz_dmac_alloc_chan_resources()
 - call pm_runtime_put() from rz_dmac_free_chan_resources()

With that then we can remove pm_runtime_put() from the remove function
and add this at the end of the probe function.

> 
> > Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> 
> > --- a/drivers/dma/sh/rz-dmac.c
> > +++ b/drivers/dma/sh/rz-dmac.c
> > @@ -437,6 +437,17 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
> >   * DMA engine operations
> >   */
> >
> > +static void rz_dmac_chan_init_all(struct rz_dmac *dmac)
> > +{
> > +       unsigned int i;
> > +
> > +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
> > +       rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
> > +
> > +       for (i = 0; i < dmac->n_channels; i++)
> > +               rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
> > +}
> > +
> >  static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
> >  {
> >         struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
> > @@ -970,10 +981,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
> >                 goto err_pm_disable;
> >         }
> >
> > -       ret = reset_control_deassert(dmac->rstc);
> > -       if (ret)
> > -               goto err_pm_runtime_put;
> > -
> >         for (i = 0; i < dmac->n_channels; i++) {
> >                 ret = rz_dmac_chan_probe(dmac, &dmac->channels[i], i);
> >                 if (ret < 0)
> > @@ -1028,8 +1035,6 @@ static int rz_dmac_probe(struct platform_device *pdev)
> >                                   channel->lmdesc.base_dma);
> >         }
> >
> > -       reset_control_assert(dmac->rstc);
> > -err_pm_runtime_put:
> >         pm_runtime_put(&pdev->dev);
> >  err_pm_disable:
> >         pm_runtime_disable(&pdev->dev);
> > @@ -1052,13 +1057,50 @@ static void rz_dmac_remove(struct platform_device *pdev)
> >                                   channel->lmdesc.base,
> >                                   channel->lmdesc.base_dma);
> >         }
> > -       reset_control_assert(dmac->rstc);
> >         pm_runtime_put(&pdev->dev);
> >         pm_runtime_disable(&pdev->dev);
> >
> >         platform_device_put(dmac->icu.pdev);
> >  }
> >
> > +static int rz_dmac_runtime_suspend(struct device *dev)
> > +{
> > +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> > +
> > +       return reset_control_assert(dmac->rstc);
> 
> Do you really want to reset the device (and thus loose register state)
> each and every time the device is runtime-suspended?  For now it doesn't
> matter much, but once you implement real dynamic power management,
> it does.
> I think the reset handling should be moved to the system suspend/resume
> callbacks.

Agreed. With above changes maybe we can move all into
NOIRQ_SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
With your suggested changes I'm not sure if pm_runtime_ops are really needed.


Thanks & Regards,
Tommaso

> 
> > +}
> > +
> > +static int rz_dmac_runtime_resume(struct device *dev)
> > +{
> > +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> > +
> > +       return reset_control_deassert(dmac->rstc);
> 
> Shouldn't this reinitialize some registers?
> For now that indeed doesn't matter, as reset is only deasserted
> from .probe(), before any register initialization.
> 
> > +}
> > +
> > +static int rz_dmac_resume(struct device *dev)
> > +{
> > +       struct rz_dmac *dmac = dev_get_drvdata(dev);
> > +       int ret;
> > +
> > +       ret = pm_runtime_force_resume(dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       rz_dmac_chan_init_all(dmac);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops rz_dmac_pm_ops = {
> > +       /*
> > +        * TODO for system sleep/resume:
> > +        *   - Wait for the current transfer to complete and stop the device,
> > +        *   - Resume transfers, if any.
> > +        */
> > +       NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, rz_dmac_resume)
> > +       RUNTIME_PM_OPS(rz_dmac_runtime_suspend, rz_dmac_runtime_resume, NULL)
> > +};
> > +
> >  static const struct of_device_id of_rz_dmac_match[] = {
> >         { .compatible = "renesas,r9a09g057-dmac", },
> >         { .compatible = "renesas,rz-dmac", },
> > @@ -1068,6 +1110,7 @@ MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
> >
> >  static struct platform_driver rz_dmac_driver = {
> >         .driver         = {
> > +               .pm     = pm_ptr(&rz_dmac_pm_ops),
> >                 .name   = "rz-dmac",
> >                 .of_match_table = of_rz_dmac_match,
> >         },
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

