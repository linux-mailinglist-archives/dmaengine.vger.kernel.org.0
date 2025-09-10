Return-Path: <dmaengine+bounces-6439-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34165B516F1
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCFF63B725E
	for <lists+dmaengine@lfdr.de>; Wed, 10 Sep 2025 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3451CD15;
	Wed, 10 Sep 2025 12:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vhP+Wid7"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9A30596B;
	Wed, 10 Sep 2025 12:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757507444; cv=fail; b=CaJtFPca/bn2OEqoi99FPGXbEV15D5K8uG3Yi/kdTdirQB/OsXXOyJatSJ9tcj/52MVRU1FTWXIMYjf6POU8o6QoPnUtrrr0KxrKtQRaInO5ku7k7YVcAFcFE1V7/pgVPanYxYRsMADTLnkryJ2SNbxRXnj60Kleto0BDqEe0Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757507444; c=relaxed/simple;
	bh=Yx0A323RLBdE7ksJUkTn95A+2Mvr7mt2haDx0c5MU0k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FYzP306l10Wv60PnDT26BpW4bEeWae8rXUPrzkNGr7wxwaxUusk5deZ0TzmFUYa2lJaYoAX/7+2gmxj4CsDbbrE60MTNBlDZWqFeaiCOHjnpkIFPjVXRt/9A+YqNu/W2ik3Qq/8W83YI3FrZf95jnaA46ATzqBAWAyxuazTaOnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vhP+Wid7; arc=fail smtp.client-ip=40.107.223.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R/voWlJ/NoTP27Xyhh6WvWHBUiqHSIMGQ8FPe3KrnvhS+1hv8Ann/5lv6w3twdHejmlqGqR4ji9PlV0EhAt1UDncy6y+IXMWZYiDDUSmciomcxKz+Ou0ON78PUSlcNXjjAWz7sQavZEdUBr+5YmtiHOdBjR4BMKl9Pv1kcdDHZGGOcRG2ZkUNtqnewCOfIt10YGbuK66H9dqbP0+786OSy83Km78++YJZmMCUoPQZJ8zxri4oCL4s7XDIxZYhjp4fBhflZlgUyO+eeXPouAmP41y3gych9IvN99mqRY10dGeM/iinBoyBiBiJGjdFIj+nf3pCLEY/k/ItQEIUfKJUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uGnfxX0ElXx5c97T6+NitXDb2u2bWZKkAZG2GveSmE=;
 b=Q3GLSPTlSJprvw/JASkcdBnNuiOpp/d+xCqRlfy/Q5Ik1uB6gXiwl4gLwV15oFt/4JFM2A3SuO5DZZBwiCB+Y/o91Oi2Lmhe+PASi3IuVRYVvOgAHb0K0iJJD3W7OwKKaygdy8J4WrbumVU7n7+M/OmQJ98Motw8f/fALkHMBIa+VY9aHTkNL+nmKsW3iTGuJQUEqTHpxaziyI/fCoI+U8cE6KONaaLSj505PhNlzoAFDqDee3cagQQB0F/B9DgbjRzjgzQBoBiQpyrVMKXgCcrcL6WGEI0ayYmtMhO3LljGuPg4SUD/R3hlExGY8YxIGrhXYteS34E96ljBI+1yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uGnfxX0ElXx5c97T6+NitXDb2u2bWZKkAZG2GveSmE=;
 b=vhP+Wid7GUYVxUWDxgwZ8KFbKD3hZu7SbRj67GDC1+Os/3GnHEl++2BDXM7Aaa+EXSEQIPsdob9uzHyB+ZX4Ob4V/rRRIW4NglJpc/fs4lqJC0LEm1Idtt9yuH+pFboeOdW3VS64dgMY60LljEv+ZAvY7rhI0aYq2FvZL0BTj3s=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 12:30:39 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::a160:b30e:1d9c:eaea%7]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 12:30:39 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
Subject: RE: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcHpgus9635/jJ7UqyWh/j4Mmvg7SMBtGw
Date: Wed, 10 Sep 2025 12:30:39 +0000
Message-ID:
 <SA1PR12MB81200F594C9B842C563F3DFE950EA@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20250905101659.95700-3-devendra.verma@amd.com>
 <20250905190621.GA1306997@bhelgaas>
In-Reply-To: <20250905190621.GA1306997@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-10T07:10:35.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|SA3PR12MB8045:EE_
x-ms-office365-filtering-correlation-id: 9213274e-c70e-4d04-bf54-08ddf065d9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tbH1I8ayQCUX1suei4FQ7tFfVQ7Nra9zfY4YmdjU2bLjU3LM6Dgxnxaghyy2?=
 =?us-ascii?Q?uXtgiqtFKZv4tbUdxuAM3xfwXXRbNQ3k0MBSKDmjCj2VW/FZCp7Jl0jcuZvW?=
 =?us-ascii?Q?D5KoOSH6hrYVBsYDFnKHdUD6srikKQoKgGtoscWnbIYe4HSGx71lOO7P0NxL?=
 =?us-ascii?Q?lcknPLg60nGJvCJ/yATYrzYGxuzAQP2jnuG/7pwvjXFFms/ir53HA6H0f+gN?=
 =?us-ascii?Q?SEL1FBbOqKlDqOR3VoUM11OdgRfEfRyXMkEiVat0UTnV5JuHbnP96R1RCSxT?=
 =?us-ascii?Q?Ts+bAx9ecqpmPmS2FaJAxudp7i5CPD/wrk7QEmOHxFEXuGehMTIbta4RWhDs?=
 =?us-ascii?Q?oZUhS2CEU3SX1TgJVYAj0jtB1n0jIc2zqgI7Ayw3EAOVYtSM8T3+kwXinFEa?=
 =?us-ascii?Q?a+VGacdpyVlU323vS1K2iyy+bCw/ViaEE2HpByh4BRv/GekxM833ECRKUxvm?=
 =?us-ascii?Q?YiQV6Obt4Bp3t6EZSClAd9lMwfjsLHeQ5INTABDIfxbgZhoihCx4ti3UcoNR?=
 =?us-ascii?Q?Qz88alVdPoIOaWlwdyAx6gKwGSt5/0xJvDlpbivouszm70L0EctU6kePk0E1?=
 =?us-ascii?Q?UAXxjxYA8rHMJogXA/yyQCFlY9wd+yDaMxkMch1OXmvC9wK6IsfoWPKcgfnD?=
 =?us-ascii?Q?WpgTyyumQW1gCQSwnKeIjiqzHGkbvYOB3kAKlEHBZG1kgL79eRDfGod2m5WQ?=
 =?us-ascii?Q?oLs5R5qW1Cy1qOnLItqH2SwlfsjoJ860RlI+ElT3qhdFeh2KMyboUA0L+Ubk?=
 =?us-ascii?Q?hs6Y9cj5nHuzafcHs38xxLcXl/V9yPmJ5gM4NsUIxlAAD9UAaXxeHWYoxxWJ?=
 =?us-ascii?Q?aMuolYcnVScsUwoPAXr47hUTZ87vMk0UJOpeirFtpLsEUWH7AVWcJvDscl+d?=
 =?us-ascii?Q?WLSwg4Olgk0h4qQznM4cuIxRkOvJff85kWQNXZ9SAQDXElSODkUYy83ct0Iv?=
 =?us-ascii?Q?20/8L/Qp8sCEZFAaFC+WjNVD72Cx3oqy74vKKJBa4HVOHKQAIiWyS6+3gpAe?=
 =?us-ascii?Q?cKhPK9Q0ba4XN+OdmKARxaSQd4QfEsODBSVPslfMCfFUpoPchQ1dKtjtHIYt?=
 =?us-ascii?Q?tJOn5BdBv6YDIU1jg9Djt84AQusmgfQ9WAC0CCK0h5x3dJdriPZZCdJD0myL?=
 =?us-ascii?Q?pr/TlL66uFFWPTYzBEptkT3OLUNJ1hpzHRyvM3SSp+rfo8HhIP7JT0Jq1m41?=
 =?us-ascii?Q?dEK+8z7nFxycF8S9DCCC/BBPkdPRzfjD1oGaZw2ZQGrYzxasw8KDe1mWRC3W?=
 =?us-ascii?Q?iDR3TNVaKXbsw43SMOzU7M/vki/muLgapw+1Wc0OBH9IP9n2whVZlnA0h9pl?=
 =?us-ascii?Q?v3ep5qv7KfLVD0WrNlsHz5wxKHPYq1agwi8BHo85tWjlgBmLhYr3KcFXRB+b?=
 =?us-ascii?Q?jzYG7DDgldgIZGyMi13+iVx10gKw9+JgceUHAM96bmvavWW/iISYqy7rI2ML?=
 =?us-ascii?Q?tK+muKuHUlRJYkvp5vU0KU+pDVXm4xAacSQEJK+GKB/ldLTgZyEJagtFMfh/?=
 =?us-ascii?Q?3gYOXWTFMOCBIOw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5MulwDUqIu+Hc/3GqhTivt2y70NCogboQOIrlh1iYAFOAUe5zs5FmPqKMJ7F?=
 =?us-ascii?Q?2Pzgh/jZTN4Aq9+H/TJX3MHeUrHIFWpvDGe0p24WIS43xMR1odXKs/hIc9u/?=
 =?us-ascii?Q?A17ICJ5YeiBufDeosnq9hoNEjDiOBjUbVupfcbEUKBrndRSZQRZiFC1MXx07?=
 =?us-ascii?Q?bmBMaFFutC2q+mprtTVhUUJqorjYnBpU6AGZ0PSXrPbpjv++YmYnS8XPlrX/?=
 =?us-ascii?Q?efbTHRi8AcFH7RXqmdAIoL1mqTrqpW0I3GER6iCbnEFKERMaf4p8fewaTdBG?=
 =?us-ascii?Q?ep3zGI9LMGT9CJT5WBPpyu6XamDWeO6hyZjQmY51Jn/rslYWG4JMbI8+WLsW?=
 =?us-ascii?Q?Rr/CO4/IudBx0jMK52vdSLcarB897XxIXB6XPwJ+IsPeEPpAydh1TVhrVFo3?=
 =?us-ascii?Q?dXf41EOcFYKRYnfHI33CPvg1DxQDLYv9U0hEmrwwT5pZq7IIzZuXZmuwH7Xz?=
 =?us-ascii?Q?YGmV/+JvuNsvAzs+8nu7SIpdXumKuLWSdZN/7n8Z3805TLU57DtfPcwOYzlo?=
 =?us-ascii?Q?SAA79tTu/iejSf5x+MF0dp/7BK+lSHnxbxHYqQ6KaE+H6rAJBlH9co2uHfDs?=
 =?us-ascii?Q?pHwca9qzyKUKFqQ5GiCy/9c7/n9QyumE9IYa0Hftvb/FuL7hwfM1FXIYdxjW?=
 =?us-ascii?Q?3LDZK4DCuwI8Gj/8gNzJsN3dvb8k4z3LE4hDpkkuDGtDB3wBq0Q0ixFADOB8?=
 =?us-ascii?Q?BYESWfJZRU0roUL//U/Mqjsuc4rpaMnEkEI98ofsUFY17kZyiry5DOiWg9hw?=
 =?us-ascii?Q?YFk+YgJt14ZcPo6M4aIOirb7C4ccKlURcwVvDHn+Lee/ofnRloPlhSmhKPm9?=
 =?us-ascii?Q?a8rLW/fMUlb7TdQMiQIhhuSwhx41wgWEGk2jKuHvYCJw53WTU7gN9kPTePpW?=
 =?us-ascii?Q?BRsVOhN1nT51TENUPRI6yqJshDZ+x6m51s9Zid5GwD9mAQDl0WJH4WmraZQ9?=
 =?us-ascii?Q?sbCsGSWpuQKYMIFvXVppAPc7IRG0b++9vIAuJT84GtOOkFIPbTMe8CZhJQMm?=
 =?us-ascii?Q?EpB2e8100aaqQXGjAkyc+wGjxYdrnrVtyneJ4R5bYrarzLyAiX10GxJ/voUL?=
 =?us-ascii?Q?WR2GjPttQVJ2zTkcgfdCzVPV9KFHM8nMoNkp7tyHmNVlb5w8lhucdeq9XW6H?=
 =?us-ascii?Q?GdH7FFgyoeVjEniV+d6xtzAzd1V2u7Ae/bidX8jfslgUfg3JTLZSkgxqkVvf?=
 =?us-ascii?Q?DmqndgiQvETEtrTj8tvxH2hZlUv97heE6sx6FKLhTtQDi3kXsznVWywGo2AK?=
 =?us-ascii?Q?MTbE3EuLGQrUR2GNFet44pyd+dmIcSh1OfTfslNOoSzDC6jcaPrxH+1wI4Gy?=
 =?us-ascii?Q?JZ12mrectQ46DwluA6Depp/CmDTXk8wAnXJsipPMLSOfoWeQbFtVkQrFTTS4?=
 =?us-ascii?Q?KzT3qUoMncJ771H62beJmuuDoG6kP0eGrjqUqbeLqMQNr4Ub9rxC6+N3Pd4t?=
 =?us-ascii?Q?jJU7eV7Wzq36deOT+FF2peZx/27FrQH00tIMt8PMtSlmv96kSLqsh0Exzd7f?=
 =?us-ascii?Q?MTV5TFSxxZT4/sj39IPE4Mpy6QdoEETdZE3c24wFDU9XGEi/tdpmfyUlKpVn?=
 =?us-ascii?Q?kjZ4eHF6bJytc8ZFVkc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9213274e-c70e-4d04-bf54-08ddf065d9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2025 12:30:39.6198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjnQzWLxU67lEhQIhQNy9l5LKxusLueP9y1OeoAESI2l6tK9lsjmnUBJmyqgKUZ+bfFINEb1J34NnQif8kROFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you Bjorn for reviewing the patch.
Please check my response inline.

Regards,
Devendra

> -----Original Message-----
> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Saturday, September 6, 2025 00:36
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Fri, Sep 05, 2025 at 03:46:59PM +0530, Devendra K Verma wrote:
> > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > The current code does not have the mechanisms to enable the DMA
> > transactions using the non-LL mode. The following two cases are added
> > with this patch:
> > - When a valid physical base address is not configured via the
> >   Xilinx VSEC capability then the IP can still be used in non-LL
> >   mode. The default mode for all the DMA transactions and for all
> >   the DMA channels then is non-LL mode.
> > - When a valid physical base address is configured but the client
> >   wants to use the non-LL mode for DMA transactions then also the
> >   flexibility is provided via the peripheral_config struct member of
> >   dma_slave_config. In this case the channels can be individually
> >   configured in non-LL mode. This use case is desirable for single
> >   DMA transfer of a chunk, this saves the effort of preparing the
> >   Link List.
>
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -223,8 +223,28 @@ static int dw_edma_device_config(struct dma_chan
> *dchan,
> >                                struct dma_slave_config *config)  {
> >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > +     int nollp =3D 0;
> > +
> > +     if (WARN_ON(config->peripheral_config &&
> > +                 config->peripheral_size !=3D sizeof(int)))
> > +             return -EINVAL;
> >
> >       memcpy(&chan->config, config, sizeof(*config));
> > +
> > +     /*
> > +      * When there is no valid LLP base address available
> > +      * then the default DMA ops will use the non-LL mode.
> > +      * Cases where LL mode is enabled and client wants
> > +      * to use the non-LL mode then also client can do
> > +      * so via the providing the peripheral_config param.
>
> s/via the/via/
>
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -224,6 +224,15 @@ static void dw_edma_pcie_get_vsec_dma_data(struct
> pci_dev *pdev,
> >       pdata->phys_addr =3D off;
> >  }
> >
> > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > +                              struct dw_edma_pcie_data *pdata,
> > +                              enum pci_barno bar) {
> > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > +             return pdata->phys_addr;
> > +     return pci_bus_address(pdev, bar);
>
> This doesn't seem right.  pci_bus_address() returns pci_bus_addr_t, so
> pdata->phys_addr should also be a pci_bus_addr_t, and the function
> should return pci_bus_addr_t.
>
> A pci_bus_addr_t is not a "phys_addr"; it is an address that is valid on =
the PCI side
> of a PCI host bridge, which may be different than the CPU physical addres=
s on the
> CPU side of the bridge because of things like IOMMUs.
>
> Seems like the struct dw_edma_region.paddr should be renamed to something=
 like
> "bus_addr" and made into a pci_bus_addr_t.
>
> Bjorn

In case of AMD, it is not an address that is accessible from host via PCI, =
it is the device
side DDR offset of physical address which is not known to host,that is why =
the VSEC capability
is used to let know host of the DDR offset to correctly programming the LLP=
 of DMA controller.
Without programming the LLP controller will not know from where to start re=
ading the LL for
DMA processing. DMA controller requires the physical address of LL present =
on its side of DDR.

