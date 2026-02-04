Return-Path: <dmaengine+bounces-8713-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKAzKKEkg2k/iQMAu9opvQ
	(envelope-from <dmaengine+bounces-8713-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:51:13 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F82E4C8D
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A57F3011123
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 10:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FC23A9DA4;
	Wed,  4 Feb 2026 10:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aAgNSCh6"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013054.outbound.protection.outlook.com [40.107.201.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B627456;
	Wed,  4 Feb 2026 10:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202214; cv=fail; b=ch/JgZdjbR2b2RjSmKXe6wwIen8vleyQLqDm375O0obEPPFhzIxJb4CGoZhy2Ir/s8bBhfTBfSmCQyg2qdkCJexvoRjJZ6R9EQJssnZFQegwel36Qdhvxcvw87pggonVJxJabBZzHBd6ey9amHxX8li9+CxQ8MJW3y34TFtB7fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202214; c=relaxed/simple;
	bh=5bpui69L0OOJ+tcH+7Nj3hRHnDCwlJIsr/U8PLCygqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eDRR43Utx8aYE6O8hAn1r2mArxYdfHtW6XkNxT8ssujhYQHb5pt1CmQk4vpyRNeZiHB9VaOLLDF/TFyHYETrZ3ruJ1vBKkS0VTTG8kyH5wUaNK2dCFJaVnfMv0iqgG0w19sS1WVEhWm8Rhq5uciBurB0cvA1frFATxzcn6isWOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aAgNSCh6; arc=fail smtp.client-ip=40.107.201.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgdkX099wQ9KgZNK6E3GukG6BdXS3Xr8E2ac7swuuuSxg7rrCBCnteclRKwLzAmRulh375qAtXwLtp1hAGuLmNxWsRt6C220MvSL60oyaf8nZaSWDBwz/lJ+xo8Ky9Qb7nr/kp4jD12qJO8hnjB83pS4jfvfmXxYcZ/OoPXhK+2v2aEmqEwpjLLK9RZt+FE3eK8ZSRKsOrtWmdSVk/V20e1H3Jqc3UoO7gAumcM4M4NoyORPqybpjNZ0UJZsWhHWSoEBlsSEERZL4BVDrxy/DPOeoiSRoVXB66i1y6ucGb153LnAYDh3GJtB5NLaNS5Ba9juN3aEEgF5lSHn/KK2hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fH2jXkGpkPFjqSWUsTeUjhq/NOMZq/pPJZ0V5RDfFGU=;
 b=w4mK9WJkplMO7FdcYgyzPQudXYKV0MXQPwqp/mCW0+RHXleLKby4xYvdO2fnqOzhqLLWuTrmJznQxFaE0o1mcC4keqzERJkYn1FTetUprt+hfqTf0aJ0/dqyKJQSRRWzNZxJJLWkGGuhsfnwVERqNF+xeHg1sl+bblolbh6fHPd1zlFJ2/Nts3dUzhR2Ski6KwMlLujIRDxuwCp8gScTcQfZ4oi1OQz5qyFVSaLdwtYlMV8p9BawWyDpRH6BRH43+CTmdZ6CO5L15m+8IfGU4pPSH8ItmHaAFDu3gtHqaPfpota54smJTVb++aYXe1FN0A511yZx/UbIZY6Gxt5n6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fH2jXkGpkPFjqSWUsTeUjhq/NOMZq/pPJZ0V5RDfFGU=;
 b=aAgNSCh6NVuCjUuSJWGoMqlRqdYa2Ge0QTbg58XAp4fvWeY88TMm1/3Yg9IbST56/R+Fu43AGAMxVEtiSAhA3wU/u5SfFlBDLY9dnbX20X189q//BduRdYI+Seol4VQimHKxpMDAPE9buhq2zblrM1FoTTwAwfblLSpcx3X3FKU=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 10:50:10 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 10:50:10 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index:
 AQHcgWAk7pWjXdcU0UqtyDITzRPgzrVTd7gAgAE23OCABQPxgIABMzMAgAILjACAAQilwIAG704AgAJHbSCAAJxAAIABNRTQgAgFXXCAAFD4AIABKTug
Date: Wed, 4 Feb 2026 10:50:09 +0000
Message-ID:
 <SA1PR12MB81204D2B45E1001C00195C169598A@SA1PR12MB8120.namprd12.prod.outlook.com>
References:
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXEKeojreN06HIdF@lizhi-Precision-Tower-5810>
 <SA1PR12MB81203BB877B64C4E525EC0269594A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXe5ts7E6lUF7YRq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120877E05B98E26B022C3669591A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aXomMjSgrCucF/De@lizhi-Precision-Tower-5810>
 <SA1PR12MB812089EE794D987D1AE48A07959EA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <SA1PR12MB8120CEA934BCA561FE860F0C959BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aYIn4PQioFJD7qzK@lizhi-Precision-Tower-5810>
In-Reply-To: <aYIn4PQioFJD7qzK@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-02-04T10:36:38.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|IA0PR12MB8278:EE_
x-ms-office365-filtering-correlation-id: 30529fd1-0c02-4b9d-de97-08de63db2ac7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fc4LRVV9/E7EQmiMBuL7HQQhiY6wksctJC0hhLc0U1nkfq4Wo0W53QkAF2Sk?=
 =?us-ascii?Q?VfJeVRdyNbSLYcYcwcXoksCbL7QjphJD1Igrftx7xNhn0dmw/A8ucatypEM0?=
 =?us-ascii?Q?qknG3XafRnM4mLiVJUVRYE88X5fBBJvRJN40VQH0EIx0TljtzMBoYoTPC1xl?=
 =?us-ascii?Q?pn+6ekQ9lK+DVtRaqvAMGTz7gsO3rDbgY6HlAxBGJcp3XFcVy3oZaQGmL/vZ?=
 =?us-ascii?Q?c8PBOAH26bwC4+VtH7XJ3bWBI6hVf2MiCyQvtmIieCXOuhkwDkAo5uKwcfEh?=
 =?us-ascii?Q?u8twx317dFj4RR+p/36c+f4dThBHsROSwzhM6s9bn9PKpTkXwNssO+dFwCZe?=
 =?us-ascii?Q?Ctf84+5G5BB8t40Aq7uqHfvgkH641TeIitlASVOznybtExVZu9VizOrSTfV+?=
 =?us-ascii?Q?6u1hAU1TyaeO6ek4VTscPaKnpPkBoduc7PgqbqNSYB6Wsh5POki5bGGLTu/q?=
 =?us-ascii?Q?GMh5aBXux8Fw2Y0JO/Ue4tvKRexSFw+tNkTjXM4WQRRvJJysMtkabP5TwiLt?=
 =?us-ascii?Q?Nt2r5yzg7RbtVvbtY6ztWwSJ+m6e9HV8jYCHNcFU1+MxtOIxB8Chq98QB+F/?=
 =?us-ascii?Q?yAZqRvgIqFeKxDkNeT8iIk6FM0/xtcKpMAEnnPZFXJ/ogFKMduNLgxhhTVZK?=
 =?us-ascii?Q?YikOrutRXAjzP76DX5OhOKh5cXWlKNlo71BRfJTY5cV26ftT+5vaJMQqAvcQ?=
 =?us-ascii?Q?5vUrk+0YlEwIkpQ9jTyqFs62RMijpsOxqSJDBV2yb4bIPlSDFf4uBh4vlK2r?=
 =?us-ascii?Q?4N3KmDmiUUQ6qoOQI4goCZGBjjcP4QijipqfvIkFB3s24aNq4wYrMPoH0mFd?=
 =?us-ascii?Q?+z6zrIFh20CxRvezCgz1nM+c2vCVE2UgOgXxN9Gnd1u2Q4cOQjZuGOyLgg/e?=
 =?us-ascii?Q?kNjIC+geNRdZXxNnVyj7Kq4pyciV+JOuJokLOu4eTuWH0NuN/dUrb7xzQwv9?=
 =?us-ascii?Q?1ufEmFJuzlAN04QP4Hfd1PDSR5dnHcw6xqYCpWYK1HjTXw4w7Gys48+HOd46?=
 =?us-ascii?Q?dIWUaPkOC7L/9Hyx0Q7pAPgdp/kN4tguCPVIzAI2xTIYqK3RoE6A7gpJRXoI?=
 =?us-ascii?Q?HTWoDGxkxCvVAHPheFY5PpWHHlMCnt6m5jyRc7umo8+PYPsoX/sOrIJ0cbTk?=
 =?us-ascii?Q?NhwtLRE6aWPs6Y2O+spxAXTYuL8kSoQYkNx/Tj1MGAvoRdAWsmyRaN0z6VRA?=
 =?us-ascii?Q?bgDW4iTKFO2eaX7CVdpZgoXxv4e1IZfBaLajIbaD4LbsnGDXUX/P03gBkOgl?=
 =?us-ascii?Q?J601mdH9m02REt4BgEglUIL8Xpkq3KBFXDJ3KaU1NBGR46QEUFtozoaO9XVu?=
 =?us-ascii?Q?ezx1VJxpul2wsOlDJHxNagncRp8uQZ1G2qK5UTaFT4pOCCmiVDTh/usatzDT?=
 =?us-ascii?Q?95i3fBSmfQbdbrYoZ9XJDGU5FHyTRcbaJhk62UEe64T/2WSIXuxsVonXTpeO?=
 =?us-ascii?Q?93fTUGq8hbDMYN5m88Nfv+oCHr/+0rT4OZWWKNtP8Zk1LoqpgKeEyz2DgLeN?=
 =?us-ascii?Q?rGFh6h/1RCAiquDey/zbNWzzvdUWYbab046ohm3PkzSVZ6fqDVHc7+4IaaHy?=
 =?us-ascii?Q?vePvdTSNLeUcAm4nUWq10rGnwN/NGUrFc+nm2XiL16xzLxLYiePciwQtf7zN?=
 =?us-ascii?Q?DfrS++80qL2ati7XV+3jx48pSHmzPhMbRpe9KtU8h2MS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?kc0jNqZlSKbGQZfSZEcK8kuBDc3cvBe3xsDyx9rNiG1WUVJ+rMN35q2PwbIT?=
 =?us-ascii?Q?fYinoAZO2W403Sr5H9QB1ZpxGTg9pLwIW30zPiMrU8BtgyeB0JP8AQ51iml0?=
 =?us-ascii?Q?QJPLI8bL3j8hZZp9GnpYQc4OYGvYTRxqQmHm93I6kCoYQ6itogY3Yl24LvQd?=
 =?us-ascii?Q?WzDjeq/5NdOhe5qmXCO1kiaqKn2b0ZcOORUhAPKlwdCM6stc0NpmFddMz1Kq?=
 =?us-ascii?Q?eF4HMuGHsfdXxesHSgDRKccdrU5e/iEAMqXcNDDL3h5wyP8YK8tHYSokIRh6?=
 =?us-ascii?Q?TPuFWtcyAqdtmMgigE9b0XlBAJll/+CEkdZXp/PzLMwBEq0W40151hZKSN0Q?=
 =?us-ascii?Q?fxDlGswG72OzqNryANb/BAKUZU/T3CrFkf0feWihbiv1qX9vyd4aOX57Crg5?=
 =?us-ascii?Q?SIDzk2Xx/vtpBqn9GK1tbfUu13UT1d+rzZ5d8uComv1oxMKtpmVKdt299McE?=
 =?us-ascii?Q?k+wsXHu8vU0dPvE0WSA9w92insdfjWOB/xX3nuY3npEHX0oYkxicGjTQY72b?=
 =?us-ascii?Q?H7PMil9JZ/L3HFeTRB/47XmvfG9KVcN8FLoUrrYABfJ2wnKVTCJsrSYrCPR1?=
 =?us-ascii?Q?lfUiN6aas0MFeaYTHeQ7H31LqNrK8mVTtjEeMyxZBT0OMoiaj30gzEwoe+b/?=
 =?us-ascii?Q?/HmUaAc3/3OuTm1LXNMun1KnPfSfxPkTELKHLHRkkrnl436MG5NSTyU8FKoh?=
 =?us-ascii?Q?cFLp/cMLnOZrm+H5/vYHY0agw/A6ZLx6DNDy+IB9Nn9J8u231qc2ljQMyI6o?=
 =?us-ascii?Q?7QLihFKzpyw0IXGTFAir0wLKfmIVOU1LSjLg5sIVm29Kq25+jJeu8rCGac1b?=
 =?us-ascii?Q?Uu+YfC9yDoLMWSpizV/RebsIW4ZZVQnvFyT3G6kExbYSEMV3tqh4S3CYLdpv?=
 =?us-ascii?Q?2SpBV9dxw8YMnWdHMV/3VTEPfsIvxxbDe2n87MSE6YVh6fEAjuV0LRRGxr5r?=
 =?us-ascii?Q?Bg1E3k94dFnadLTGIYEVCXvDDSuaJWZrmwEE0+OkER2mZPYTVLqrMHftOyCM?=
 =?us-ascii?Q?D3YTkcX33ht08Ar5VjyOvn2HB7tdfUtf4/hL+NwgfOddzdv4CPs2Va00HL/b?=
 =?us-ascii?Q?tDQP8PqVVc2L/meR4K86EiijFS03isdEuTwz2wTUPcGWKRK7vffiRuqYzqKG?=
 =?us-ascii?Q?a+TkeKXw4iFE/SJlx2270o/hK+BOp7kJp/hc+CgUFPpabWWdSgelfl+y404m?=
 =?us-ascii?Q?MZRbyGgiHVvVbfA7iEuohvpYpP6YygSWDxmTjnsWhffhrv48S3OJrMqdxQpH?=
 =?us-ascii?Q?+yMsTIeSB0dNf7JCXswmyEqH2rlEibMvy8ngWhtaclxcKOX/5wiS9j9kJ3Bo?=
 =?us-ascii?Q?srCEa4wrO8WLSfYvsNTeIX+lP6Eg0lvSoeFFj01K5Ryj+db2CEeAvhCLrOHG?=
 =?us-ascii?Q?MdUuSQXa729iStA5RI0oSSu05rtJSAuiDJIhPhvNMfEmkVjnB+V/iC3/WGoz?=
 =?us-ascii?Q?R6ZTOPfZuGp1OjP14ldUSYDjmlDpGNEC56MXc5cd0eAd/dpZw5jFc8shIKfh?=
 =?us-ascii?Q?zgeZSLFcHD3C1/q/PNUODa50ZbLZB72lobspQ648Gt+ZXv011XHi3CNPJFKY?=
 =?us-ascii?Q?LGHBMIn0P4JGuaFuKMryf6EWK0hwAmWdYMyeFoeGw+J1riD1C8dwfk/Sh0uN?=
 =?us-ascii?Q?7xu7HYaxfWFBgeR1JtYUKQca0v3AgfmophVLocriqmWSvQid6wOOnTZUFfXK?=
 =?us-ascii?Q?z0j6T0NhJ1NeMY21KNuBqDeOFmdUtqAzMLF7cmfkinAP4HoQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 30529fd1-0c02-4b9d-de97-08de63db2ac7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2026 10:50:09.9470
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: flP2c8NVua19T0ED+lxerxT+IKUhdypd8vPjqdPswLCdke5CzA0FkZ8jXq37ZblDrnR4v6+PnGNT/Gg8Rrgyjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8713-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,outlook.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Queue-Id: 06F82E4C8D
X-Rspamd-Action: no action

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Frank

Thanks for your suggestions, please check my response inline.

Regards,
Devendra

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Tuesday, February 3, 2026 10:23 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
>

 --[ Snipped some headers to reduce the size of this mail ]--


> > >
> > > > > > > > > > > > > AMD MDB IP supports Linked List (LL) mode as
> > > > > > > > > > > > > well as non-LL
> > > > > > mode.
> > > > > > > > > > > > > The current code does not have the mechanisms to
> > > > > > > > > > > > > enable the DMA transactions using the non-LL mode=
.
> > > > > > > > > > > > > The following two cases are added with this patch=
:
> > > > > > > > > > > > > - For the AMD (Xilinx) only, when a valid
> > > > > > > > > > > > > physical base
> > > > address of
> > > > > > > > > > > > >   the device side DDR is not configured, then
> > > > > > > > > > > > > the IP can still
> > > be
> > > > > > > > > > > > >   used in non-LL mode. For all the channels DMA
> > > > > > > > > > > > > transactions will
> > > > > > > > > > > >
> > > > > > > > > > > > If DDR have not configured, where DATA send to in
> > > > > > > > > > > > device side by non-LL mode.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > The DDR base address in the VSEC capability is used
> > > > > > > > > > > for driving the DMA transfers when used in the LL
> > > > > > > > > > > mode. The DDR is configured and present all the time
> > > > > > > > > > > but the DMA PCIe driver uses this DDR base address
> > > > > > > > > > > (physical
> > > > > > > > > > > address) to configure the LLP
> > > > > > address.
> > > > > > > > > > >
> > > > > > > > > > > In the scenario, where this DDR base address in VSEC
> > > > > > > > > > > capability is not configured then the current
> > > > > > > > > > > controller cannot be used as the default mode support=
ed is
> LL mode only.
> > > > > > > > > > > In order to make the controller usable non-LL mode
> > > > > > > > > > > is being added which just needs SAR, DAR, XFERLEN
> > > > > > > > > > > and control register to initiate the transfer. So,
> > > > > > > > > > > the DDR is always present, but the DMA PCIe driver
> > > > > > > > > > > need to know the DDR base physical address to make
> > > > > > > > > > > the transfer. This is useful in scenarios where the
> > > > > > > > > > > memory
> > > > > > > > > > allocated for LL can be used for DMA transactions as we=
ll.
> > > > > > > > > >
> > > > > > > > > > Do you means use DMA transfer LL's context?
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > Yes, the device side memory reserved for the link list
> > > > > > > > > to store the descriptors, accessed by the host via BAR_2
> > > > > > > > > in this driver
> > > > code.
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > >   be using the non-LL mode only. This, the
> > > > > > > > > > > > > default non-LL
> > > > mode,
> > > > > > > > > > > > >   is not applicable for Synopsys IP with the
> > > > > > > > > > > > > current code
> > > > addition.
> > > > > > > > > > > > >
> > > > > > > > > > > > > - If the default mode is LL-mode, for both AMD
> > > > > > > > > > > > > (Xilinx) and
> > > > > > Synosys,
> > > > > > > > > > > > >   and if user wants to use non-LL mode then user
> > > > > > > > > > > > > can do so
> > > > via
> > > > > > > > > > > > >   configuring the peripheral_config param of
> > > > dma_slave_config.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Signed-off-by: Devendra K Verma
> > > > > > > > > > > > > <devendra.verma@amd.com>
> > > > > > > > > > > > > ---
> > > > > > > > > > > > > Changes in v8
> > > > > > > > > > > > >   Cosmetic change related to comment and code.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v7
> > > > > > > > > > > > >   No change
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v6
> > > > > > > > > > > > >   Gave definition to bits used for channel config=
uration.
> > > > > > > > > > > > >   Removed the comment related to doorbell.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v5
> > > > > > > > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > > > > > > > >   In the dw_edma_device_config() WARN_ON
> > > > > > > > > > > > > replaced with
> > > > > > > > dev_err().
> > > > > > > > > > > > >   Comments follow the 80-column guideline.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v4
> > > > > > > > > > > > >   No change
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v3
> > > > > > > > > > > > >   No change
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v2
> > > > > > > > > > > > >   Reverted the function return type to u64 for
> > > > > > > > > > > > >   dw_edma_get_phys_addr().
> > > > > > > > > > > > >
> > > > > > > > > > > > > Changes in v1
> > > > > > > > > > > > >   Changed the function return type for
> > > > > > dw_edma_get_phys_addr().
> > > > > > > > > > > > >   Corrected the typo raised in review.
> > > > > > > > > > > > > ---
> > > > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> > > > > > > > > > +++++++++++++++++++++---
> > > > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46
> > > > > > > > ++++++++++++++++++--
> > > > > > > > > > ------
> > > > > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > > > > > > > > > > ++++++++++++++++++++++++++++++++++-
> > > > > > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > > > > > > > > > > >
> > > > > > > > > > > > edma-v0-core.c have not update, if don't support,
> > > > > > > > > > > > at least need return failure at
> > > > > > > > > > > > dw_edma_device_config() when backend is
> > > > > > eDMA.
> > > > > > > > > > > >
> > > > > > > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > > > > > > >  6 files changed, 132 insertions(+), 20
> > > > > > > > > > > > > deletions(-)
> > > > > > > > > > > > >
> > > > > > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > > index b43255f..d37112b 100644
> > > > > > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > > > > > @@ -223,8 +223,32 @@ static int
> > > > > > > > > > > > > dw_edma_device_config(struct
> > > > > > > > > > > > dma_chan *dchan,
> > > > > > > > > > > > >                                struct dma_slave_c=
onfig *config)  {
> > > > > > > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > > > > > > +     int non_ll =3D 0;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +     if (config->peripheral_config &&
> > > > > > > > > > > > > +         config->peripheral_size !=3D sizeof(int=
)) {
> > > > > > > > > > > > > +             dev_err(dchan->device->dev,
> > > > > > > > > > > > > +                     "config param peripheral si=
ze
> mismatch\n");
> > > > > > > > > > > > > +             return -EINVAL;
> > > > > > > > > > > > > +     }
> > > > > > > > > > > > >
> > > > > > > > > > > > >       memcpy(&chan->config, config,
> > > > > > > > > > > > > sizeof(*config));
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +     /*
> > > > > > > > > > > > > +      * When there is no valid LLP base address
> > > > > > > > > > > > > + available then the
> > > > > > > > default
> > > > > > > > > > > > > +      * DMA ops will use the non-LL mode.
> > > > > > > > > > > > > +      *
> > > > > > > > > > > > > +      * Cases where LL mode is enabled and
> > > > > > > > > > > > > + client wants to use the
> > > > > > > > non-LL
> > > > > > > > > > > > > +      * mode then also client can do so via
> > > > > > > > > > > > > + providing the
> > > > > > > > peripheral_config
> > > > > > > > > > > > > +      * param.
> > > > > > > > > > > > > +      */
> > > > > > > > > > > > > +     if (config->peripheral_config)
> > > > > > > > > > > > > +             non_ll =3D *(int
> > > > > > > > > > > > > + *)config->peripheral_config;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +     chan->non_ll =3D false;
> > > > > > > > > > > > > +     if (chan->dw->chip->non_ll ||
> > > > > > > > > > > > > + (!chan->dw->chip->non_ll &&
> > > > > > > > non_ll))
> > > > > > > > > > > > > +             chan->non_ll =3D true;
> > > > > > > > > > > > > +
> > > > > > > > > > > > >       chan->configured =3D true;
> > > > > > > > > > > > >
> > > > > > > > > > > > >       return 0;
> > > > > > > > > > > > > @@ -353,7 +377,7 @@ static void
> > > > > > > > > > > > > dw_edma_device_issue_pending(struct
> > > > > > > > > > > > dma_chan *dchan)
> > > > > > > > > > > > >       struct dw_edma_chan *chan =3D
> > > > > > > > > > > > > dchan2dw_edma_chan(xfer-
> > > > > > > > >dchan);
> > > > > > > > > > > > >       enum dma_transfer_direction dir =3D xfer->d=
irection;
> > > > > > > > > > > > >       struct scatterlist *sg =3D NULL;
> > > > > > > > > > > > > -     struct dw_edma_chunk *chunk;
> > > > > > > > > > > > > +     struct dw_edma_chunk *chunk =3D NULL;
> > > > > > > > > > > > >       struct dw_edma_burst *burst;
> > > > > > > > > > > > >       struct dw_edma_desc *desc;
> > > > > > > > > > > > >       u64 src_addr, dst_addr; @@ -419,9 +443,11
> > > > > > > > > > > > > @@ static void
> > > > > > > > > > > > > dw_edma_device_issue_pending(struct
> > > > > > > > > > > > dma_chan *dchan)
> > > > > > > > > > > > >       if (unlikely(!desc))
> > > > > > > > > > > > >               goto err_alloc;
> > > > > > > > > > > > >
> > > > > > > > > > > > > -     chunk =3D dw_edma_alloc_chunk(desc);
> > > > > > > > > > > > > -     if (unlikely(!chunk))
> > > > > > > > > > > > > -             goto err_alloc;
> > > > > > > > > > > > > +     if (!chan->non_ll) {
> > > > > > > > > > > > > +             chunk =3D dw_edma_alloc_chunk(desc)=
;
> > > > > > > > > > > > > +             if (unlikely(!chunk))
> > > > > > > > > > > > > +                     goto err_alloc;
> > > > > > > > > > > > > +     }
> > > > > > > > > > > >
> > > > > > > > > > > > non_ll is the same as ll_max =3D 1. (or 2, there ar=
e
> > > > > > > > > > > > link back
> > > > entry).
> > > > > > > > > > > >
> > > > > > > > > > > > If you set ll_max =3D 1, needn't change this code.
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > The ll_max is defined for the session till the
> > > > > > > > > > > driver is loaded in the
> > > > > > > > kernel.
> > > > > > > > > > > This code also enables the non-LL mode dynamically
> > > > > > > > > > > upon input from the DMA client. In this scenario,
> > > > > > > > > > > touching ll_max would not be a good idea as the
> > > > > > > > > > > ll_max controls the LL entries for all the DMA
> > > > > > > > > > > channels not just for a single DMA
> > > > transaction.
> > > > > > > > > >
> > > > > > > > > > You can use new variable, such as ll_avail.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > In order to separate out the execution paths a new
> > > > > > > > > meaningful variable
> > > > > > > > "non_ll"
> > > > > > > > > is used. The variable "non_ll" alone is sufficient.
> > > > > > > > > Using another variable along side "non_ll" for the
> > > > > > > > > similar purpose may not have any
> > > > > > > > added advantage.
> > > > > > > >
> > > > > > > > ll_avail can help debug/fine tune how much impact
> > > > > > > > preformance by adjust ll length. And it make code logic cle=
an and
> consistent.
> > > > > > > > also ll_avail can help test corner case when ll item small.
> > > > > > > > Normall case it is
> > > > > > hard to reach ll_max.
> > > > > > > >
> > > > > > >
> > > > > > > Thank you for your suggestion. The ll_max is max limit on
> > > > > > > the descriptors that can be accommodated on the device side
> > > > > > > DDR. The ll_avail
> > > > > > will always be less than ll_max.
> > > > > > > The optimization being referred can be tried without even
> > > > > > > having to declare the ll_avail cause the number of
> > > > > > > descriptors given can be controlled by the DMA client based
> > > > > > > on the length argument to the
> > > > > > dmaengine_prep_* APIs.
> > > > > >
> > > > > > I optimzied it to allow dynatmic appended dma descriptors.
> > > > > >
> > > > > > https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-
> > > > > > 9a98c9c98536@nxp.com/T/#t
> > > > > >
> > > > > > > So, the use of dynamic ll_avail is not necessarily required.
> > > > > > > Without increasing the ll_max, ll_avail cannot be increased.
> > > > > > > In order to increase ll_max one may need to alter size and
> > > > > > > recompile this
> > > > driver.
> > > > > > >
> > > > > > > However, the requirement of ll_avail does not help for the
> > > > > > > supporting the
> > > > > > non-LL mode.
> > > > > > > For non-LL mode to use:
> > > > > > > 1) Either LL mode shall be not available, as it can happen
> > > > > > > for the Xilinx
> > > IP.
> > > > > > > 2) User provides the preference for non-LL mode.
> > > > > > > For both above, the function calls are different which can
> > > > > > > be differentiated by using the "non_ll" flag. So, even if I
> > > > > > > try to accommodate ll_avail, the call for LL or non-LL would
> > > > > > > be ambiguous as in
> > > > > > case of LL mode also we can have a single descriptor as
> > > > > > similar to non-LL mode.
> > > > > > > Please check the function dw_hdma_v0_core_start() in this
> > > > > > > review where the decision is taken Based on non_ll flag.
> > > > > >
> > > > > > We can treat ll_avail =3D=3D 1 as no_ll mode because needn't se=
t
> > > > > > extra LL in memory at all.
> > > > > >
> > > > >
> > > > > I analyzed the use of ll_avail but I think the use of this
> > > > > variable does not fit at this location in the code for the follow=
ing
> reasons:
> > > > > 1. The use of a new variable breaks the continuity for non-LL mod=
e.
> > > > > The
> > > > variable
> > > > >     name non_ll is being used for driving the non-LL mode not
> > > > > only in this file
> > > > but also
> > > > >    in the files relevant to HDMA. This flag gives the clear
> > > > > indication of LL vs
> > > > non-LL mode.
> > > > >    In the function dw_hdma_v0_core_start(), non_ll decided the
> > > > > mode to
> > > > choose.
> > > > > 2. The use of "ll_avail" is ambiguous for both the modes. First,
> > > > > it is
> > > > associated with LL mode only.
> > > > >      It will be used for optimizing / testing the Controller
> > > > > performance based
> > > > on the
> > > > >     number of descriptors available on the Device DDR side which
> > > > > is for LL
> > > > mode. So when
> > > > >     it is being used for LL mode then it is obvious that it
> > > > > excludes any use for
> > > > non-LL mode.
> > > > >     In the API dw_edma_device_transfer(), the ll_avail will be
> > > > > used for
> > > > creating the bursts.
> > > > >     If ll_avail =3D 1 in the above API, then it is ambiguous
> > > > > whether it is creating
> > > > the burst for
> > > > >      LL or non-LL mode. In the above API, the non_ll is
> > > > > sufficient to have the
> > > > LL mode
> > > > >      and non-LL burst allocation related piece of code.
> > > >
> > > > If really like non-ll, you'd better set ll_avail =3D 1 in prepare c=
ode.
> > > > Normal case ll_avail should be ll_max. It will reduce if-else
> > > > branch in prep dma burst code.
> > > >
> > >
> > > I think we are not on the same page, and it is creating confusion.
> > > If non_ll flag is being used to differentiate between the modes,
> > > then in this scenario the use of ll_avail does not fit any
> > > requirement related to differentiation of different modes. In the
> > > last response, I pointed out that ll_avail, if used, creates
> > > ambiguity rather than bringing clarity for both LL & non-LL mode. If
> > > non_ll flag is used and initialized properly then this is sufficient =
to drive
> the execution for non-LL mode.
> > >
> > > In the function doing the preparation, there also no if-else clause
> > > is introduced rather the same "if" condition is extended to support
> > > the non-LL mode.
> > >
> > > Could you elaborate what is the approach using ll_avail if I need to
> > > maintain the continuity of the non-LL context and use non-LL mode
> > > without any ambiguity anywhere, instead of using non_ll flag?
> > > If possible, please give a code snippet. Depending upon the
> > > usability and issue it fixes, I will check its feasibility.
> > >
> > > > +               /*
> > > > +                * For non-LL mode, only a single burst can be hand=
led
> > > > +                * in a single chunk unlike LL mode where multiple =
bursts
> > > > +                * can be configured in a single chunk.
> > > > +                */
> > > >
> > > > It is actually wrong, current software should handle that. If
> > > > there are multiple bursts, only HEAD of bursts trigger DMA, in irq
> > > > handle, it will auto move to next burst. (only irq latency is
> > > > bigger compared to LL, software's resule is the same).
> > > >
> > > > The code logic is totally equal ll_max =3D 1, except write differec=
e registers.
> > > >
> > >
> > > Changing the ll_max dynamically for a single request is not
> > > feasible. As pointed out earlier it may require the logic to retain
> > > the initially configured value, during the probe, and then use the
> > > retained value depending on the use-case.
>
> As my previous suggest, add ll_avail, config can set it in [1..ll_max].
> then replace ll_max with ll_avail.
>
> > > Could you elaborate the statement,
> > > " The code logic is totally equal ll_max =3D 1, except write differec=
e
> registers." ?
>
> My means don't touch actual logic in dw_edma_device_transfer() except
> change ll_max to ll_avail or other variable, with value 1.
>
> Even though you really want to use non_ll, you can use below code
>
> dw_edma_device_transfer()
> {
>
>         size_t avail =3D no_ll ? 1 : ll_max;
>         ...
>
>         if (chunk->bursts_alloc =3D=3D avail)
>         ...
> }
>

Thank you for the code illustration, this is clear to me.
I suggest we shall use the bursts_max variable to compare with
chunk->bursts_alloc instead of ll_avail, that way it is easy to convey
the meaning. I tried using ll_avail but it did not suite well with the inte=
nt.
The use of ll_avail puts the upper limit on the allocation of bursts which
bursts_max shows well in comparison to ll_avail. Please review the next
update with these suggestions included.

> > >
> > > The irq_handler() for success case calls dw_edma_start_transfer()
> > > which schedules the chunks not bursts.
>
> Current code, it is that. I forget I just change it.
>
> >  The bursts associated with that chunk will
> > > get written to controller DDR area / scheduled (for non-LL) in the
> > > dw_hdma_v0_core_start(), for HDMA.
>
> Original code have unnecessary complex about chunks and burst, which
> actually add overhead.
>
> See my patch to reduce 2 useless malloc()
>
> https://lore.kernel.org/dmaengine/20251212-edma_ll-v1-0-
> fc863d9f5ca3@nxp.com/
>
> > > With this flow, for the non-LL mode each chunk needs to contain a
> > > single burst as controller can handle only one burst at a time in non=
-LL
> mode.
>
> Non-LL case, you just fill one. The only difference is fill to DDR or reg=
isters.
>
> Frank
>

Thanks for the link, it is good improvement.

> > >
> > >
> > > > And anthor important is that,
> > > >
> > > > in dw_edma_device_config() should return if backend is not HDMA.
> > > >
> > >
> > > Thanks, this is a valid concern, will address in the upcoming version=
.
> > >
> > > > Frank
> > > >
> > > > >
> > > > > I think ll_avail, if used for trying out to optimize / debug the
> > > > > settings related to number of descriptors for LL mode then it
> > > > > should be part of the separate discussion / update not related to=
 non-
> LL.
> > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > >
> > > > > > > > ...
> > > > > > > > > > > > > +
> > > > > > > > > > > > > + ll_block->bar);
> > > > > > > > > > > >
> > > > > > > > > > > > This change need do prepare patch, which only
> > > > > > > > > > > > change
> > > > > > > > > > > > pci_bus_address() to dw_edma_get_phys_addr().
> > > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > This is not clear.
> > > > > > > > > >
> > > > > > > > > > why not. only trivial add helper patch, which help
> > > > > > > > > > reviewer
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > I was not clear on the question you asked.
> > > > > > > > > It does not look justified when a patch is raised alone
> > > > > > > > > just to replace this
> > > > > > > > function.
> > > > > > > > > The function change is required cause the same code
> > > > > > > > > *can* support different IPs from different vendors. And,
> > > > > > > > > with this single change alone in the code the support
> > > > > > > > > for another IP is added. That's why it is easier to get
> > > > > > > > > the reason for the change in the function name and
> > > > > > syntax.
> > > > > > > >
> > > > > > > > Add replace pci_bus_address() with dw_edma_get_phys_addr()
> > > > > > > > to make review easily and get ack for such replacement patc=
hes.
> > > > > > > >
> > > > > > > > two patches
> > > > > > > > patch1, just replace exist pci_bus_address() with
> > > > > > > > dw_edma_get_phys_addr() patch2, add new logic in
> > > > > > dw_edma_get_phys_addr() to support new vendor.
> > > > > > > >
> > > > > > >
> > > > > > > I understand your concern about making the review easier.
> > > > > > > However, given that we've been iterating on this patch
> > > > > > > series since September and are now at v9, I believe the
> > > > > > > current approach is justified. The function renames from
> > > > > > > pci_bus_address() to dw_edma_get_phys_addr() is directly
> > > > > > > tied to the non-LL mode functionality being added - it's
> > > > > > > needed because the same code now supports different IPs from
> different vendors.
> > > > > > >
> > > > > > > Splitting this into a separate preparatory patch at this
> > > > > > > stage would further delay the review process. The change is
> > > > > > > kind of straightforward and the context is clear within the c=
urrent
> patch.
> > > > > > > I request
> > > > > > you to review this patch to avoid additional review cycles.
> > > > > > >
> > > > > > > This also increases the work related to testing and
> > > > > > > maintaining multiple
> > > > > > patches.
> > > > > > > I have commitment for delivery of this, and I can see adding
> > > > > > > one more series definitely add 3-4 months of review cycle fro=
m
> here.
> > > > > > > Please excuse me but this code has already
> > > > > >
> > > > > > Thank you for your persevere.
> > > > > >
> > > > >
> > > > > Thank you for your support.
> > > > >
> > > > > > > been reviewed extensively by other reviewers and almost by
> > > > > > > you as well. You can check the detailed discussion wrt this
> > > > > > > function at the following
> > > > > > link:
> > > > > > >
> > > > > >
> > > >
> > >
> https://lore.kernel.org/all/SA1PR12MB8120341DFFD56D90EAD70EDE9514A@
> > > > > > SA1
> > > > > > > PR12MB8120.namprd12.prod.outlook.com/
> > > > > > >
> > > > > >
> > > > > > But still not got reviewed by tags. The recently,  Manivannan
> > > > > > Sadhasivam , Niklas Cassel and me active worked on this driver.
> > > > > > You'd better to get their feedback. Bjorn as pci maintainer to
> > > > > > provide
> > > > generally feedback.
> > > > > >
> > > > >
> > > > > Hi Manivannan Sadhasivam, Vinod Koul and Bjorn Helgaas Could you
> > > > > please provide your feedback on the patch?
> > > > > You have reviewed these patches extensively on the previous
> > > > > versions of
> > > > the same series.
> > > > >
> > > > > Regards,
> > > > > Devendra
> > > > >
> > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > > >               ll_region->paddr +=3D ll_block->off=
;
> > > > > > > > > > > > >               ll_region->sz =3D ll_block->sz;
> > > > > > > > > > > > >
> > > > > > > > ...
> > > > > > > > > > > > >
> > > > > > > > > > > > > +static void dw_hdma_v0_core_non_ll_start(struct
> > > > > > > > > > > > > +dw_edma_chunk
> > > > > > > > > > > > *chunk)
> > > > > > > > > > > > > +{
> > > > > > > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > > > > > > +     struct dw_edma *dw =3D chan->dw;
> > > > > > > > > > > > > +     struct dw_edma_burst *child;
> > > > > > > > > > > > > +     u32 val;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +     list_for_each_entry(child,
> > > > > > > > > > > > > + &chunk->burst->list,
> > > > > > > > > > > > > + list) {
> > > > > > > > > > > >
> > > > > > > > > > > > why need iterated list, it doesn't support ll.
> > > > > > > > > > > > Need wait for irq to start next
> > > > > > > > > > one.
> > > > > > > > > > > >
> > > > > > > > > > > > Frank
> > > > > > > > > > >
> > > > > > > > > > > Yes, this is true. The format is kept similar to LL m=
ode.
> > > > > > > > > >
> > > > > > > > > > Just fill one. list_for_each_entry() cause confuse.
> > > > > > > > > >
> > > > > > > > > > Frank
> > > > > > > > >
> > > > > > > > > I see, we can use list_first_entry_or_null() which is
> > > > > > > > > dependent on giving the type of pointer, compared to
> > > > > > > > > this
> > > > > > > > > list_for_each_entry() looks neat and agnostic to the
> > > > > > > > > pointer type being used. Though, it can be
> > > > > > > > explored further.
> > > > > > > > > Also, when the chunk is allocated, the comment clearly
> > > > > > > > > spells out how the allocation would be for the non LL
> > > > > > > > > mode so it is evident that each chunk would have single
> > > > > > > > > entry and with that understanding it is clear that loop
> > > > > > > > > will also be used in a similar manner, to retrieve a
> > > > > > > > > single entry. It is a similar use case as of "do {}while
> > > > > > > > > (0)" albeit needs a context to
> > > > > > > > understand it.
> > > > > > > >
> > > > > > > > I don't think so. list_for_each_entry() is miss leading to
> > > > > > > > reader think it is not only to one item in burst list, and
> > > > > > > > use polling method to to finish many burst transfer.
> > > > > > > >
> > > > > > > > list_for_each_entry() {
> > > > > > > >         ...
> > > > > > > >         readl_timeout()
> > > > > > > > }
> > > > > > > >
> > > > > > > > Generally, EDMA is very quick, polling is much quicker
> > > > > > > > than irq if data is
> > > > > > small.
> > > > > > > >
> > > > > > > > Frank
> > > > > > > >
> > > > > > >
> > > > > > > The polling is not required. The single burst will raise the
> > > > > > > interrupt and from the interrupt context another chunk will
> > > > > > > be scheduled. This cycle repeats till all the chunks with
> > > > > > > single burst are
> > > > exhausted.
> > > > > > >
> > > > > > > The following comment made in function
> > > > > > > dw_edma_device_transfer() in the same patch makes it amply
> > > > > > > clear that only a single burst would be
> > > > > > handled for the non-LL mode.
> > > > > > > +       /*
> > > > > > > +        * For non-LL mode, only a single burst can be handle=
d
> > > > > > > +        * in a single chunk unlike LL mode where multiple bu=
rsts
> > > > > > > +        * can be configured in a single chunk.
> > > > > > > +        */
> > > > > > >
> > > > > > > Looking at the way bursts are appended to chunks and chunks
> > > > > > > in
> > > > > > > dw_edma_device_transfer() are scheduled for non-LL mode then
> > > > > > > it is clear
> > > > > > what non-LL mode would handle in terms of bursts.
> > > > > > > I just kept the format to match it with the LL mode format
> > > > > > > otherwise there is no need of this comment and we can follow
> > > > > > > the syntax for a single
> > > > > > entry alone.
> > > > > > > Please share your suggestion if these descriptions fail to
> > > > > > > provide the clear
> > > > > > context and intent.
> > > > > >
> > > > > > Avoid use list_for_each_entry() here to prevent miss-leading.
> > > > > >
> > > > > > Frank
> > > > > >
> > > > >
> > > > > Sure, thanks, I will push this change in next version.
> > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > >
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > > + ch_en, HDMA_V0_CH_EN);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             /* Source address */
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, =
sar.lsb,
> > > > > > > > > > > > > +                       lower_32_bits(child->sar)=
);
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, =
sar.msb,
> > > > > > > > > > > > > +
> > > > > > > > > > > > > + upper_32_bits(child->sar));
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             /* Destination address */
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, =
dar.lsb,
> > > > > > > > > > > > > +                       lower_32_bits(child->dar)=
);
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, =
dar.msb,
> > > > > > > > > > > > > +
> > > > > > > > > > > > > + upper_32_bits(child->dar));
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             /* Transfer size */
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > > + transfer_size,
> > > > > > > > > > > > > + child->sz);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             /* Interrupt setup */
> > > > > > > > > > > > > +             val =3D GET_CH_32(dw, chan->dir,
> > > > > > > > > > > > > + chan->id, int_setup)
> > > > |
> > > > > > > > > > > > > +                             HDMA_V0_STOP_INT_MA=
SK |
> > > > > > > > > > > > > +
> > > > > > > > > > > > > + HDMA_V0_ABORT_INT_MASK |
> > > > > > > > > > > > > +
> > > > > > > > > > > > > + HDMA_V0_LOCAL_STOP_INT_EN |
> > > > > > > > > > > > > +
> > > > > > > > > > > > > + HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             if (!(dw->chip->flags &
> DW_EDMA_CHIP_LOCAL)) {
> > > > > > > > > > > > > +                     val |=3D HDMA_V0_REMOTE_STO=
P_INT_EN |
> > > > > > > > > > > > > +                            HDMA_V0_REMOTE_ABORT=
_INT_EN;
> > > > > > > > > > > > > +             }
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > > + int_setup, val);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             /* Channel control setup */
> > > > > > > > > > > > > +             val =3D GET_CH_32(dw, chan->dir, ch=
an->id,
> control1);
> > > > > > > > > > > > > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id,
> > > > > > > > > > > > > + control1, val);
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +             SET_CH_32(dw, chan->dir, chan->id, =
doorbell,
> > > > > > > > > > > > > +                       HDMA_V0_DOORBELL_START);
> > > > > > > > > > > > > +     }
> > > > > > > > > > > > > +}
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +static void dw_hdma_v0_core_start(struct
> > > > > > > > > > > > > +dw_edma_chunk *chunk, bool
> > > > > > > > > > > > > +first) {
> > > > > > > > > > > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > > > > > > > > > > +
> > > > > > > > > > > > > +     if (chan->non_ll)
> > > > > > > > > > > > > +             dw_hdma_v0_core_non_ll_start(chunk)=
;
> > > > > > > > > > > > > +     else
> > > > > > > > > > > > > +             dw_hdma_v0_core_ll_start(chunk,
> > > > > > > > > > > > > + first); }
> > > > > > > > > > > > > +
> > > > > > > > > > > > >  static void dw_hdma_v0_core_ch_config(struct
> > > > > > > > > > > > > dw_edma_chan
> > > > > > > > > > > > > *chan)
> > > > > > > > > > {
> > > > > > > > > > > > >       struct dw_edma *dw =3D chan->dw; diff --git
> > > > > > > > > > > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > > index eab5fd7..7759ba9 100644
> > > > > > > > > > > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > > > > > > > > > @@ -12,6 +12,7 @@  #include <linux/dmaengine.h>
> > > > > > > > > > > > >
> > > > > > > > > > > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > > > > > > > > > > +#define HDMA_V0_CH_EN                           =
     BIT(0)
> > > > > > > > > > > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT=
(6)
> > > > > > > > > > > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN
> BIT(5)
> > > > > > > > > > > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT=
(4)
> > > > > > > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > > > > > > b/include/linux/dma/edma.h index
> > > > > > > > > > > > > 3080747..78ce31b
> > > > > > > > > > > > > 100644
> > > > > > > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > > > > > > >
> > > > > > > > > > > > >       struct dw_edma          *dw;
> > > > > > > > > > > > > +     bool                    non_ll;
> > > > > > > > > > > > >  };
> > > > > > > > > > > > >
> > > > > > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > > > > > --
> > > > > > > > > > > > > 1.8.3.1
> > > > > > > > > > > > >
> >

