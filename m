Return-Path: <dmaengine+bounces-8987-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AItzJNOFmGnKJQMAu9opvQ
	(envelope-from <dmaengine+bounces-8987-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 17:03:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C7616927B
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 17:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFDF030131F2
	for <lists+dmaengine@lfdr.de>; Fri, 20 Feb 2026 16:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A0A2777F3;
	Fri, 20 Feb 2026 16:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fYy224zQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012028.outbound.protection.outlook.com [52.101.66.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA47D1D5160;
	Fri, 20 Feb 2026 16:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603394; cv=fail; b=D0nQtazpgKZoWIKW6zR2JMscFL4YosQ3rYHPn3Ls4KfA6F5rrAo9KU53OO+b7juBJhdCKbZ5RnsNNjIr2j59/zwK7UFhEw5/CrsPFIKRie3L6319tvHmlZaqYao21Yg7burJYV6+SbEnBFHbv4Y5d68lufvnXOXTf38Yd5yl6pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603394; c=relaxed/simple;
	bh=RWurD3RqPwIS3ho93/Ih1P0yyLpNxcVC6WBq0x8oBY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hfF9dnk0XEDUhzpSnJV/RtHE23hanOP1ghR5QauHPq+L0JQWljrO572eaxPGvm+qanVwyZovVxQWOriI7Ct3510suLYpHE5usyJVV+DQ4s+QCl9kcYtpCrnYUr0a+joqdbPzGiS9dxnh6LFzD4G4y9MDOUAMO3fVuV7MHUpuhuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fYy224zQ; arc=fail smtp.client-ip=52.101.66.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIgEKsdKVDRmKPyZB3tCy4/Jh3mNH/Eojz16bYxfs87GAtKlWpDbk2ROTraU1SP4mK5neqYE/vYM54wdBI9METW94C0d+lmikozlGdMYzZJiv0SfyIZ7jqcck/acE7Uaywiz0dyMftPLEULswdFWWB3OdqFMmbNT5Yj+ajMTM+sqbXndrrokD8FzYeIe+8XsyXxkJKQwtelPjaziUgTLlskCvaKGEZuqRVrLkIhLOyBBPWvoIKUqlEjahBviKMnoc9gEfJclEbhn5OAQX6ALShlb3VxpXLMLd0YrRfW9Sjilhdk/NQPB8nQtQ2C6x20Vx5h5Kru84PAc1jidP/eLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxZ55ntI4mgo02B25xaQA4shqKziYqDvZK3jdViMMW8=;
 b=x3cRrXjtcM63qAT3+awz9AHOuljyjK3jp2oZKz2S9kE+mUdKAtzFHCRWN39aPVBx1pBNq3gTKfKMqHslL6eIw9VwRsR87BUdpiN1beTnoldrk2tdAXvI35DBgJ+XEz4f7d3V/h86KsqgaMSlbqYsKK6vbux6f3rA43cmLOQ60E377UwcqcWViVa+gjpjl3aZMx7GCnxHRmHBuf7ZpEoCklVaYP0hsB6n4tHbLPbQ4XJGrBmyTekmowulIjYBlHI3YKuaTA0Ukx/YcW8fZ6mvpFwNr/XyJwqELp7VL0ic5AFsXr15Z8Ne7mdCygfSX5Fr4rT60Bxo9381fUnUYJ/vjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxZ55ntI4mgo02B25xaQA4shqKziYqDvZK3jdViMMW8=;
 b=fYy224zQn7vKr4JJvCkGNcbokQKhHZYrc8wX41hQolbROV534lcMDlFcLT33tHJ31hxwKygkZwkMJ/McuD7sqbznFywMdMX8XNFYNS/wgI7RAQfCRB3jwSfXKVpql9Y618cIqgr5y4oA6K9yeOjm5Y2iW0Wz4zlxn9ptvjmaDrDr2rt9l4JrQ0jacM2noKBnh5OVig1giaM8D+/0BD7FNGu7e1h+LsBG03slIZCfX6rkf3yaV+W72ntD3e/JJT5emf33/JJMQY/8NtvUEHNligxmT2PIbdLKA6UBxamH5sS+eoqxPcXhQGx93KfRWK2Vam6aTDvlr7uozOoXVfWXpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DB8PR04MB7161.eurprd04.prod.outlook.com (2603:10a6:10:124::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 16:03:10 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 16:03:09 +0000
Date: Fri, 20 Feb 2026 11:03:02 -0500
From: Frank Li <Frank.li@nxp.com>
To: "Verma, Devendra" <Devendra.Verma@amd.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
	"mani@kernel.org" <mani@kernel.org>,
	"vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>
Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Message-ID: <aZiFtgcMzs-U2MkN@lizhi-Precision-Tower-5810>
References: <20260216105547.13457-1-devendra.verma@amd.com>
 <20260216105547.13457-3-devendra.verma@amd.com>
 <aZNz3DxDdzuIf2Ar@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120CDACB96008B2BD4246D3956DA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZSZrROMrvt8jHvw@lizhi-Precision-Tower-5810>
 <SA1PR12MB812019D701E0B188611DFE7D956AA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZXfmKs5_KzCDSPq@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120DC54060E415153AA8CDE956BA@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aZdDYJIUuceu0guJ@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR12MB8120F99F2A675C17B1F649EA9568A@SA1PR12MB8120.namprd12.prod.outlook.com>
X-ClientProxiedBy: PH8PR07CA0020.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DB8PR04MB7161:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b472f28-5785-45f7-d43b-08de70998acf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uQ9FwX6OHR0oyiCZjyox3tIsBGHkfIUrUrULkL6ant9pyqsIpba5tqCWhyOH?=
 =?us-ascii?Q?7nndnEjfPtfH4zLgmVEEMTyPBqZMI7VApfPgrSN4J3v7WeAImpB8Tlcz7xkQ?=
 =?us-ascii?Q?FWk60URseE+3grrKeoYe5TH+aq74G/aYGopY8jsHsSU3Xk3Gv4GcFjTFE6oz?=
 =?us-ascii?Q?0uf4YxV0cc/wv9DF/FBPhfHI3GWa4FnQdFMORqM4foF0sQbNWHdJeEoEq8zy?=
 =?us-ascii?Q?2Wf9YRw816hHQMf70C0/lhMl+sZzvEeeX6sNYnRummMZ8A76ZDiPr9s3Y8Dk?=
 =?us-ascii?Q?Grs2VPpXW7EcDSdz9Dg1Vz7jAhgtz0SH2fNG3/yFV4wJyoQHnReBe13fb5JY?=
 =?us-ascii?Q?/fUKwdbKwCSEgC9jbST1HtPwRmtiDzzQR5yJ2pruArUj/C4xeTjCCWfAbXZ8?=
 =?us-ascii?Q?4jVD/vGZsvf8o8jC3wrCKU9JnUQHZRuX6IF0+xp7Z52+c5MvYuPmFWRh37aL?=
 =?us-ascii?Q?I0QFMAHjTLrS8G4ZFtvlibeTQyOHJLeosoHTWa3xKSPzMjyCKCvX3n0qa/2c?=
 =?us-ascii?Q?8ofExhLWQ8S29eU4HllloJ44i0SgE9HwhSVnmzVWStb4JSueM7P6uAO0yOgI?=
 =?us-ascii?Q?7U7Z12IXJoBnts0c2wiIZCf0AqCWXypn1BYLZFtlMubsAMQPaAmqXuSjh2cy?=
 =?us-ascii?Q?c72bpTXwg8QwnJbpXFx0P6nOXd06Y9aHjqsT+4uRdKZ3ZGAZa/mUHqG7WdQ6?=
 =?us-ascii?Q?GB9GVDvwA1R/TCfAio3mnoDLViKtZLMxph+GaKIF5cFFfqIK46WNQypNGEXt?=
 =?us-ascii?Q?5n5SLAp36v4H/CH0XpJetoj8WSVGB4CSJ8OatLmqkHCHFWSLpOxD6OgrUF85?=
 =?us-ascii?Q?2oo8JuFmKRuxfBaGABoScvcnJlgMdZ8G+byaT4M+osOsJuXlB9Csrsl0wyGg?=
 =?us-ascii?Q?OUBiaz80371cnTJXdDj3jpNzsOU9zDaIKkmbSDR/a8Hq+FvkOv31cUCV5eLQ?=
 =?us-ascii?Q?vQpw79swWv9brpQFE4jDue/3XP7DUTvZiykx0eFJU2mNumlL3NxKKgwjq1GF?=
 =?us-ascii?Q?YPQAzNRS/KamlfGIE9VIvajYYaQoXkM2Zypno8Ujh0TnF7ifprbSLGMmThNj?=
 =?us-ascii?Q?g/pLdOmpW5RR5cI2/pYcQg4PWWpX8zNCBWRIm0f6aWWxiT34D9TOiXd+li1y?=
 =?us-ascii?Q?578Fy4Jnh+wDtrhGpgHzRmcTgO/uYOHGHwIZx6rqbZCG68C/zmULj769rSMU?=
 =?us-ascii?Q?6jCFFZPt5tjVOmaW6kTumFalf2CRxmE5pEnYyJYn/a8Z/VZIC315d7Wl9ign?=
 =?us-ascii?Q?dw48r9Vn56Pz7PkX/maCo9mDo3dKQ61Yo2HNCfMHJdKRpPk77jzdMLgvgXk5?=
 =?us-ascii?Q?UWD7QJ+AGl1zJshNGSRvc//5CFbc7xpo1LPi2/UJZ6bBbIpYwxCySAQxAvW5?=
 =?us-ascii?Q?Mv+2vRfhLASQoMwaDWUErpPO88xdV0CZxR6mIRFmb1VKimEdRtYH3XDEEuHl?=
 =?us-ascii?Q?DbAOSgwiXovauGPJmTwOTYrSrpR2u21kWb1AlJJa3f/qpvefyHkhLLR1rXQN?=
 =?us-ascii?Q?/18WPhWXewDV28v2bpIiaVN0eipaSZx5P9BfV6I2ikW6fbEP5MjkzCE1eQDw?=
 =?us-ascii?Q?QCHkSn+XPpE3JvoY9mNrnZUJG7daslhp6VKvrcM+ovyevaVhjuQ3LO2XUe8r?=
 =?us-ascii?Q?PQ8mCUmLQnAdg55t7CWdClg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mgq9oKYiU8kv3lQ4irzMrwcs85wrkw72xM7nCfSz6D8x0TQ9pAJloQMDOJZl?=
 =?us-ascii?Q?jomhHT71/NZYZnRn6g6EycQjfLND1f2oA7OpRPzy32iIVoiDUEgh9F8g19Dq?=
 =?us-ascii?Q?FOB04YNH/vaYYC3ngFr5wtRr3Nby0EmWE342aMLuFuwtkLqvsfGum+1e3diI?=
 =?us-ascii?Q?kUkxHC6QBedPYeKMDWctfXkw5nSD6C+e/iUWaaro1RHIFmLWJsglxcD/GFnR?=
 =?us-ascii?Q?ByINfGjjNzFjjF+QYcG9jEpX38CcDKiu9dcqzfg8uoxz/PqTuSX3uAnaMKYj?=
 =?us-ascii?Q?B6xauGYsJMdPuc1QCRF6TRCwb/g0X7sNDDkhGtdhLAR83Oz6p8lKYFgBkFyp?=
 =?us-ascii?Q?RcH4FRUm899d4LWOVpwco1H009DFucavrd1ds79bm6ACvldgxttJmgKRQySU?=
 =?us-ascii?Q?Yzdh9O01V2/dRMc9zEHGuM2f7Mc3XeEi5W3R1Gqfl8c9O2t4vW5FD0WGp+t4?=
 =?us-ascii?Q?6Y2K0Yi6oj05fIkbOX0cm0b93/2w75kJa7WLm/5hx2SsFUE3bTo/7mTh2O/A?=
 =?us-ascii?Q?3dMvQJRtRENYcoJOONrReJWyzigsC1W9jLs8yy74Smo330mf4r23h4Y5KgnK?=
 =?us-ascii?Q?AgQUX7IsNy4ofLzcv90KlfIEpPOYBx5Q+5SMhBGvVVJ/Re+ZTHA3qyZTILzh?=
 =?us-ascii?Q?Mc7hQ+jfgy0NHFTez6hhigm0a55mpF80XFNu5QtlDl67z76ere2GrD7RkLvp?=
 =?us-ascii?Q?iCzuj/GU7gO5lNAMN5Vtg+mO+273ikkFpz4s9w9//uGEXYMvtueft+v/slGu?=
 =?us-ascii?Q?oplgrhSenUL3biK/KkIt+BSHTMiZnDPFpNgJrySAd3h2tOUD2BB2TAddsYQT?=
 =?us-ascii?Q?WX4Vdhx2h6hi/+TQi1mMHUvrymRHyL4+mGDnedhDNktgbevZ2v5ojzlhPJDc?=
 =?us-ascii?Q?3rMCuOwfMXpE51qrTA8cv5SYiOG4tpxCekzInBmO62uJWDKjHqHrTBtN8VX6?=
 =?us-ascii?Q?A8aQGafIOVYIsFyO2pcnYmNEu/EIQnhKPcQWMpfTjZnQV4oK0wnzYy0m1nep?=
 =?us-ascii?Q?8vNSduTZRIRujCx5kpOJ9aIrN+w0Tvly1wkBMB1b+E781yN5bAu5wV1WuGJN?=
 =?us-ascii?Q?sb139uZoim6KOVZRlVRqxEatfmq6fmv/7ipMJeXSIAw4tbpkfJYMDxWwUZF8?=
 =?us-ascii?Q?3O2UrP54ubNOJqVUZQDdrAdzuABEi08kYu+NUwr0Rk1jWAGKriZzmq0b37Fq?=
 =?us-ascii?Q?QZBW4y6f5tpWLkG9YDwRZhXV36NdeyRku0tFAednn3uitEkYCZTPnJbSN0lG?=
 =?us-ascii?Q?r0Nts6ZmldMBMIpPTXKc5V6sCUcU0d93cSXo350s8+wG77ib5iZfUZ0aC8s5?=
 =?us-ascii?Q?Qn2QgHe5KYBYir5W2dwwUc4rea7oKDTCJ0+eOpZis4+Fbw9W3crRdDjM8e2Z?=
 =?us-ascii?Q?TpHwgJKKqj2x1khiko91nZYWqCCN14JED3p00MlM3Z3g9pufDPxjNnpxuthU?=
 =?us-ascii?Q?Cd1Ufh+ny0YfGnMfd9pusryw0o1bp5D5dFgwTW2tQ06qk+m8jWEzin5hbMhV?=
 =?us-ascii?Q?haBIf8P0neZIJftfEMgxwgGrRfpU/btojoulzW4gvliVKlKWHnk+yLkDXuEf?=
 =?us-ascii?Q?7QRcB1E3k657xIv2+lQrtTgrYmJu1nT8SaxuDZh8VQjcajNu73GZToB0v6xm?=
 =?us-ascii?Q?P6xjAK2du5Y+BO1nOolo1Q1enlvUQm64vqAPtU2NonEmLtzmMSUQSNd8u/di?=
 =?us-ascii?Q?DJ8i9rOTo2Mt11gbspPraEeBIJ6n/pyBWVpx0Z0iLhzzDLdYnJ2NQr+g4hAW?=
 =?us-ascii?Q?NgTnF9ryFA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b472f28-5785-45f7-d43b-08de70998acf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2026 16:03:09.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slhJcZ9YYlXwuu7fJ8l0f4jl9Nx7ua7XjNg+Ca1UUtWC3azB88eZSzO+84mbbxwQXwLZfXQ4haEdeoyfO28rHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7161
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8987-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0C7616927B
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 11:47:59AM +0000, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
>
> Hi Frank
> Please check my response inline
>
> Regards,
> Devendra
> > -----Original Message-----
> > From: Frank Li <Frank.li@nxp.com>
> > Sent: Thursday, February 19, 2026 10:38 PM
> > To: Verma, Devendra <Devendra.Verma@amd.com>
> > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > Subject: Re: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL
> > mode
>
> ---[ Snipped some text to reduce mail size ]---
>
> > > > > > > > On Mon, Feb 16, 2026 at 04:25:46PM +0530, Devendra K Verma
> > wrote:
> > > > > > > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL
> > mode.
> > > > > > > > > The current code does not have the mechanisms to enable
> > > > > > > > > the DMA transactions using the non-LL mode. The following
> > > > > > > > > two cases are added with this patch:
> > > > > > > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > > > > > > >   the device side DDR is not configured, then the IP can still be
> > > > > > > > >   used in non-LL mode. For all the channels DMA transactions will
> > > > > > > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > > > > > > >   is not applicable for Synopsys IP with the current code addition.
> > > > > > > > >
> > > > > > > > > - If the default mode is LL-mode, for both AMD (Xilinx) and
> > Synosys,
> > > > > > > > >   and if user wants to use non-LL mode then user can do so via
> > > > > > > > >   configuring the peripheral_config param of dma_slave_config.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > > > > > > ---
> > > > > > > > > Changes in v10
> > > > > > > > >   Added the peripheral_config check only for HDMA IP in
> > > > > > > > >   dw_edma_device_config().
> > > > > > > > >   Replaced the loop with single entry retrieval for non-LL
> > > > > > > > >   mode.
> > > > > > > > >   Addressed review comments and handled the burst allocation
> > > > > > > > >   by defining 'bursts_max' as per suggestions.
> > > > > > > > >
> > > > > > > > > Changes in v9
> > > > > > > > >   Fixed compilation errors related to macro name mismatch.
> > > > > > > > >
> > > > > > > > > Changes in v8
> > > > > > > > >   Cosmetic change related to comment and code.
> > > > > > > > >
> > > > > > > > > Changes in v7
> > > > > > > > >   No change
> > > > > > > > >
> > > > > > > > > Changes in v6
> > > > > > > > >   Gave definition to bits used for channel configuration.
> > > > > > > > >   Removed the comment related to doorbell.
> > > > > > > > >
> > > > > > > > > Changes in v5
> > > > > > > > >   Variable name 'nollp' changed to 'non_ll'.
> > > > > > > > >   In the dw_edma_device_config() WARN_ON replaced with
> > > > dev_err().
> > > > > > > > >   Comments follow the 80-column guideline.
> > > > > > > > >
> > > > > > > > > Changes in v4
> > > > > > > > >   No change
> > > > > > > > >
> > > > > > > > > Changes in v3
> > > > > > > > >   No change
> > > > > > > > >
> > > > > > > > > Changes in v2
> > > > > > > > >   Reverted the function return type to u64 for
> > > > > > > > >   dw_edma_get_phys_addr().
> > > > > > > > >
> > > > > > > > > Changes in v1
> > > > > > > > >   Changed the function return type for
> > dw_edma_get_phys_addr().
> > > > > > > > >   Corrected the typo raised in review.
> > > > > > > > > ---
> > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
> > > > > > > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > > > > > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++----
> > --
> > > > > > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 65
> > > > > > > > > ++++++++++++++++++++++++++-  drivers/dma/dw-edma/dw-
> > hdma-
> > > > v0-
> > > > > > > > regs.h |  1 +
> > > > > > > > >  include/linux/dma/edma.h              |  1 +
> > > > > > > > >  6 files changed, 132 insertions(+), 15 deletions(-)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > index b43255f914f3..ef3d79a9f88d 100644
> > > > > > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > > > > > @@ -223,6 +223,31 @@ static int
> > > > > > > > > dw_edma_device_config(struct
> > > > > > > > dma_chan *dchan,
> > > > > > > > >                                struct dma_slave_config *config)  {
> > > > > > > > >       struct dw_edma_chan *chan =
> > > > > > > > > dchan2dw_edma_chan(dchan);
> > > > > > > > > +     int non_ll = 0;
> > > > > > > > > +
> > > > > > > > > +     chan->non_ll = false;
> > > > > > > > > +     if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> > > > > > > >
> > > > > > > > Need handle EMDA case. if mf is EDMA, need return error when
> > > > > > > > config->peripheral_config is not NULL. Or remove above check
> > > > > > > > config->to make
> > > > > > > > code work for both EDMA or HDMA.
> > > > > > > >
> > > > > > >
> > > > > > > For the case of EDMA, the behavior is unchanged.
> > > > > > > Even if the config->peripheral_config param is set then it
> > > > > > > would be simply
> > > > > > ignored.
> > > > > > > This is retention of the previous behavior. This is done
> > > > > > > because device_slave_config has other params which affect the
> > > > > > > behavior of the DMA transactions, we do not check all those
> > > > > > > params and return any error. The error is returned only in the
> > > > > > > cases where particular parameter from dma_slave_config is used
> > > > > > > and if the parameter is not as expected or in the expected
> > > > > > > form. The parameter used from dma_slave_config for the
> > > > > > > particular IP type need to be known first then it
> > > > > > can be checked for its correctness. This is behavior for the
> > > > > > peripheral_config which is used for HDMA and thus error checked.
> > > > > >
> > > > > > It actaully hidden error. Your patch provide an option, which
> > > > > > need't ll memory to do DMA transfer. DMA consumer actaully don't
> > > > > > know which backend used, which is private information by DMA
> > engine providor.
> > > > > >
> > > > > > dw-edma-pcie.c is only one of all edma users, which know DMA
> > > > > > engine's information because it creates this interface.
> > > > > >
> > > > > > PCIE-EP framework also create dmaegine, PCIE-EP function driver
> > > > > > use DMA standard interface to get dma-chan.
> > > > > >
> > > > > > if (config->peripheral_config) { /* only your specific dma
> > > > > > consumer set it now */
> > > > > >         /* optional config information */
> > > > > >         if (chan->dw->chip->mf != EDMA_MF_HDMA_NATIVE) {
> > > > > >                 dev_err("edma have not implmentent no-lll mode\n")
> > > > > >                 return -EINVAL
> > > > > >         }
> > > > > >
> > > > > >         ...
> > > > > > }
> > > > > >
> > > > > > Add EDMA support no-ll mode is quite easily in future.
> > > > > >
> > > > >
> > > > > This looks reasonable provided that HDMA got the support for this
> > param.
> > > > > An error check can be added in the next revision.
> > > > > The addition may be slightly different as following:
> > > > > If (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) { ...
> > > > > } else if (config->peripheral_config) {
> > > > >  /* error handling */
> > > > > }
> > > > >
> > > > > Using the above, if support needs to be added to EDMA then a check
> > > > > for
> > > > correct 'mf'
> > > > > in the if() shall be sufficient.
> > > > >
> > > > > > >
> > > > > > > > > +             if (config->peripheral_config &&
> > > > > > > > > +                 config->peripheral_size != sizeof(int)) {
> > > > > > > > > +                     dev_err(dchan->device->dev,
> > > > > > > > > +                             "config param peripheral size mismatch\n");
> > > > > > > > > +                     return -EINVAL;
> > > > > > > > > +             }
> > > > > > > > > +
> > > > > > > > > +             /*
> > > > > > > > > +              * When there is no valid LLP base address
> > > > > > > > > + available then
> > > > the
> > > > > > > > > +              * default DMA ops will use the non-LL mode.
> > > > > > > > > +              *
> > > > > > > > > +              * Cases where LL mode is enabled and client
> > > > > > > > > + wants to use
> > > > the
> > > > > > > > > +              * non-LL mode then also client can do so via providing
> > the
> > > > > > > > > +              * peripheral_config param.
> > > > > > > > > +              */
> > > > > > > > > +             if (config->peripheral_config)
> > > > > > > > > +                     non_ll = *(int
> > > > > > > > > + *)config->peripheral_config;
> > > > > > > > > +
> > > > > > > > > +             if (chan->dw->chip->non_ll ||
> > > > > > > > > + (!chan->dw->chip->non_ll && non_ll))
> > > > > > > >
> > > > > > > > if chan->dw->chip->non_ll is true, It should return error if
> > > > > > > > you set non_ll false because no LLP base available.
> > > > > > > >
> > > > > > >
> > > > > > > In case the 'chan->dw->chip->non_ll' is true, then the default
> > > > > > >mode  becomes non-LL for HDMA ONLY. There is no option to the
> > > > > > >user to  configure the LL mode by giving 'non_ll = false' as
> > > > > > >part of the
> > > > > > >config- peripheral_config.
> > > > > >
> > > > > > This is API's callback, you can't assume caller do all correct things.
> > > > > >
> > > > > > > The configuration of default non-LL mode depends on how the IP
> > > > > > > is programmed by the user. The user is aware of the IP configuration.
> > > > > >
> > > > > > It is not true. DMA consumer don't know such detail information,
> > > > > > which only know which dma engineer providor.
> > > > > >
> > > > >
> > > > > For the DMA consumer the only option is LL mode as default mode.
> > > > > In order to use the non-LL mode it need to provide the parameter
> > > > > in the form
> > > > of peripheral_config.
> > > > > Given the above statement, the consumer even if gives the 'non_ll
> > > > > = false', it is not going to change any behavior.
> > > > > Even if the user is not giving the option the assumption is that
> > > > > controller is in LL mode, unless the DMA engine provider provides
> > > > > the information regarding non-LL mode as default mode to the DMA
> > > > > consumer
> > > > explicitly.
> > > > > In the case where chan->dw->chip->non_ll = true, following case
> > > > > may
> > > > happen:
> > > > > - DMA consumer provides no peripheral_config param or simply
> > > > >config- peripheral_config = NULL,
> > > > >    in this case non_ll = false which is the current flow.
> > > > > - DMA consumer provides a valid peripheral_config (!= NULL) param
> > > > >but the
> > > > value is '0', in this case
> > > > >   It is explicit but it would have the same effect as above case.
> > > > >
> > > > > DMA consumer is supposed to provide the only option non_ll as it
> > > > > was not available and LL mode is set as default for the DMA operations.
> > > > > When 'chan->dw->chip->non_ll = true' then this was added to make
> > > > > the chip usable when the LLP base addresses are not configured.
> > > > > Without this, user cannot use any of the modes be it LL or non-LL
> > > > > if the LLP base
> > > > address is not configured.
> > > >
> > > > little bit confuse, Maybe the same as you. I expected behavor
> > > >
> > > > config->peripheral_config = NULL        choose hardware default one
> > > >                                         -           LL mode if hardware support
> > > >                                         -      none-LL mode if not ll list region
> > > >
> > > > config->peripheral_config != NULL
> > > > EDMA: return false
> > > > HDMA:
> > > >                 0                       force to none_ll mode. (always success)
> > > >                 1                       force back to ll mode  (return false if no ll list region
> > in
> > > > chip)
> > > >
> > > > DMA consumer decide if fall back to none_ll to continue.
> > > >
> > >
> > > Thank you for the elaboration!
> > > I have few questions, why shall a DMA consumer decide to enable LL
> > > mode when the default mode supported is LL mode only?
> >
> > LL mode only is software driver implement. Hardware support both LL mode
> > and no-LL mode. Previous driver implement only support LL mode. You try to
> > add non-LL mode. Choose straightforward forward method.
> >
> > One indicate hardware capacity,  one actually used. Like PCI INTX and MSI.
> > If support MSI, most case use MSI. But still support switch to use INTX.
> >
> > My key point avoid hidden beavior. Every branch is clean and straightforward.
> >
> > >
> > > If DMA consumer is trying to enable the LL mode, then one must be
> > > knowing the configuration of the controller that controller is working
> > > in non-LL mode, as LLP base address is not configured,then why to try and
> > enable the LL mode?
> >
> > The DMA consumer don't know these informaiton.
> >
> > >
> > > The user need to know, at least, one detail from the above two cases.
> > >
> > > The use for non-LL mode is useful in the following scenario:
> > > - When user want to utilize the LL regions also for DMA data transfers.
> > > - For single and big chunks non-LL mode is useful in both use-cases when
> > non-LL mode is default or
> > >   user enables it via peripheral_config params.
> > > - This addition, inadvertently, makes the DMA controller usable, for AMD
> > (Xilinx) only, when the LLP
> > >   base addresses are not configured; it can be used in non-LL mode.
> >
> > LL regions may not visiable,  User can use non-ll to config LL-region and switch
> > back to use LL-region to continue transfer. User may use non-ll as indirectly
> > reg access.
> >
> > > For Synopsys, DMA controller
> > >   cannot be used in any mode if LLP base address is not configured.
> >
> > Does spec said it? It doesn't make sense. it should be controlled by LLE of
> > DMA_CH_CONTROL1_OFF_RDCH_0.
> >
> > >
> > > Based on the above points, if user is trying to enable LL mode when
> > > default mode is LL mode, it looks Intentionally making the choice when user
> > is aware of the mode DMA controller operating in.
> > > Please let me know if this clarifies the doubt.
> >
> > No API to get mode, only use set and test to know it.
> >
> > Actually Needn't consider so complex. like functions API(x)
> >
> > We just consider input x,
> >
> >         validate x's input ragion,
> >
> >         if x is out of region, just return error.
> >
>
> Thanks! Will update in the next version.
>
> > >
> > > > >
> > > > > > > The check for non-LL option
> > > > > > > provided by the user is useful when LL-mode is default. That
> > > > > > > is why the value of non_ll == false is not even evaluated.
> > > > > > >
> > > > > > > > > +                     chan->non_ll = true;
> > > > > > > > > +     }
> > > > > > > > >
> > > > > > ...
> > > > > > > > > diff --git a/include/linux/dma/edma.h
> > > > > > > > > b/include/linux/dma/edma.h index
> > > > > > > > > 3080747689f6..78ce31b049ae
> > > > > > > > > 100644
> > > > > > > > > --- a/include/linux/dma/edma.h
> > > > > > > > > +++ b/include/linux/dma/edma.h
> > > > > > > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > > > > > > >       enum dw_edma_map_format mf;
> > > > > > > > >
> > > > > > > > >       struct dw_edma          *dw;
> > > > > > > > > +     bool                    non_ll;
> > > > > > > >
> > > > > > > > Can you check ll_region directly? it should be equal to
> > > > > > > > (ll_region->sz == 0)
> > > > > > ?
> > > > > >
> > > > > > Do you miss this questin?
> > > > > >
> > > > > > Frank
> > > > > >
> > > > >
> > > > > Yes, looks like I missed this question. Could you explain a little
> > > > > bit more? I
> > > > am unable to understand the context.
> > > >
> > > > you set chip->non_ll = non_ll in dw_edma_pcie_probe()
> > > >
> > > > and only set ll_region->sz = ll_block->sz when !chip->non_ll.
> > > >
> > > > Thats means ll_region->sz is 0 when chip->non_ll is true.
> > > >
> > > > So non_ll have not bring new infomation into dw_edma_chip.
> > > >
> > > > check !ll_region->sz, which should be equal to this non_ll.
> > > >
> > > > dw_edma_chip is the exchange information between controller and dma
> > > > core driver. Needn't cache it here because you already save a copy in dma-
> > chan.
> > > >
> > > > Frank
> > >
> > > I understand the concern here but it does not look good to piggyback
> > > the non_ll related information on the existing variable.
> > > The use of bool readily points out the information related to what
> > > mode is being intended but using the ll_region->sz is an inference the user
> > has to make.
> > >
> > > Having ll_region->sz == 0 does not really tell it is non_ll mode or
> > > not, it can also mean that the size of LL region is zero while in LL mode
> > which could be an error.
> > > This does not translate to support for non-LL mode. This brings the
> > ambiguity.
> > > The introduction of the non_ll provides clarity and easy comparison
> > > with the similar choice (non_ll) provided by the DMA consumer in the
> > dmaengine_slave_config().
> > > I request we shall retain the clarity here.
> >
> > You can use helper(dw_chip_is_support_ll()) macro to check chip's
> > capatiblity.
> >
>
> I do not understand what you mean with the above statement.
> But if it about writing a new function to check the LL mode support
> then I think the current variable is good enough which provides good readability
> and do not create any ambiguity compared to the ll region size comparison.

It is not big deal,  use 'bool cap_non_ll: 1' in dw_edma_chip. So we add
more cap flags in future.

Frank

>
> > Frank
> > >
> > > > >
> > > > > > > >
> > > > > > > > Frank
> > > > > > > > >  };
> > > > > > > > >
> > > > > > > > >  /* Export to the platform drivers */
> > > > > > > > > --
> > > > > > > > > 2.43.0
> > > > > > > > >

