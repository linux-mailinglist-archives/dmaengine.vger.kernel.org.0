Return-Path: <dmaengine+bounces-9781-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN4xDcHZy2kaMAYAu9opvQ
	(envelope-from <dmaengine+bounces-9781-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:27:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8806336AEFA
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E074530A868B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 14:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477E53D7D7B;
	Tue, 31 Mar 2026 14:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mdl99hi9"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013053.outbound.protection.outlook.com [52.101.83.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B849336EC5;
	Tue, 31 Mar 2026 14:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966819; cv=fail; b=pMMxPHyX8/tBc51MxyLDsktzsbnePmW5n8Jz0Jgm3PmDccqngbd16MyZ0KhaE93DX2zy6DpuIgNXPxqfNvw+VjdIPHEwWphkFqezwbruwQvZwwKCPg4JAGVSREAPfw5ACFUkQyR4WfiKsrrL9AgolShZHFsdcExOQSFyMcC/96Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966819; c=relaxed/simple;
	bh=Q6tAIk+6Z9QbnwEMz+WgAfeYfxY2qL6E/cDPS/veie8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HVWEPWlNprF8wuX2wuFUxJVxa9GIgBK7Lf048cyyv3q1wXfY8TNP4/GNoD5oqAbjPCqb+uGf3zqjEcRWuZ2YOLdr9+5xvHhz/nJlonfDum+mcDqiJNeTF9X+mbMiiD02Kw6ieKCjTbNKIKIi1Dr4YiNKkSsA6BxmoKECsUVZbso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mdl99hi9 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPoJVgM88vx4uira4O0klQyuYcCol9QtuYjqPtOA/vo8St4XitOk+35JuJil/bHPNKKG+2ZuF6HTSnS/ekVK03VQouSaMKdd4aPkTfiGE2iZ52/Gexy1HaNyRHulB+WEIvx7iSWosZ64I93XczXr2dYBAClxWgwb64hIzIFS5uNDb5yZGnRKw5ZT7gwHTUpEo8DWGMVrZiWD/Vkyx20VJSIt63HuTSTPSjnoJhpacR0ucxBb3gQeR4DpcM2RHO76IjYJVDIqkjOPBw7So2r2D1xHqtVSEWCqUQDlh0l0jNqt41Stv4hmwX3QRDRSX949b1jz7DXbVfqCoednZS5hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF29GiPR+Xfb/z9gmZO86yJCKYfh81HkJ+5y+2DSfEg=;
 b=n3uTFpwjEbDPsLcEWUMf6b0DXC+Ddyz+LaGX+3yh6ucqF8gfeofDtsA27XFtOLJjdhzYDinSdyYEMxkF0vDcWgcpKUQNXS9TYIJwiV/LvuLiGTTLk6ym1IwP411tsOgcEfleaTwxVsagZ1hmACMMk/XenCdddu95NjhrzRKM01Gac9mw8n8X4SviMe0uA962Bb62n3RdBBzBFHV6rRbHUBZxZCtOHMqoFW2yXscKgK+FqLqPtmFCnJA7Ej0wHsnDqiP4tW2KfMoFRLTNrSZlF/TkG+pfDrWpHq0u8ESDIMcWg9xgTUyJ5h2Sl6ayUy1G7s1/8pwct4nLEt0l2BLbXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF29GiPR+Xfb/z9gmZO86yJCKYfh81HkJ+5y+2DSfEg=;
 b=Mdl99hi9WQrGKCN3GKRZSRC076OlPiOz5hHsHuGEPBd6VU+BuzeK5wjPeo9tFWqWHHvj5Eu4s12wg3radm/7yGQYc59B/h7jG56fCHbeD745bpSldle4AHX0tJP844JZ5w5Lgujp4y46L2ZavL78lAxW5ksHQQkI9vE72YI4RPPETesGMgveoIzafKaZm7JLaNCs1Pd7r/ekme+a+288S78k5wLwoNRGGf2sGqTEh7a0EW22+FlrLabkefjp/xxGJAXADU6vedTrsXF8yIkXPKikAnDdmnsGiREi28n1XmmEL+dZAFXFhZ4y8M1MbpHS11kSSoNhyLD71rrYrr5zsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU0PR04MB9633.eurprd04.prod.outlook.com (2603:10a6:10:311::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 14:20:13 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 14:20:13 +0000
Date: Tue, 31 Mar 2026 10:20:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v2 3/4] dmaengine: dma-axi-dmac: fix use-after-free on
 unbind
Message-ID: <acvYGLESQ1kZYB2G@lizhi-Precision-Tower-5810>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-3-021f95f0e87b@analog.com>
 <acqVIrUwtIM5AaG3@lizhi-Precision-Tower-5810>
 <acuI7MOEMmAgGwve@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acuI7MOEMmAgGwve@nsa>
X-ClientProxiedBy: SA0PR12CA0026.namprd12.prod.outlook.com
 (2603:10b6:806:6f::31) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU0PR04MB9633:EE_
X-MS-Office365-Filtering-Correlation-Id: 85924c4d-6920-4b10-a767-08de8f309fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|52116014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mm+3hvzhHdAAv8ihLWRY7T7eGHrf2UiVYrt3s7BztQfigieyBV2GR47m6UBz14U+ZhdSBZs4mqoxWXNuXp4gJPtWd41VpCQiDEUqI85p1q0SJs/fpWLeUvNkO2f5xtkBNl1TYVxpW/HVQZoqiuBDbyhJxCxQG6gi4oTFAAZEwIc18NeYIYnZ4NErNEtl6cwZvXDOjDN6g2ZVVvPHiUoJQYF/YQbl6PImkVL5b1RjM+fnNL7teBdZm5tw8LPZenRd00PHndS4Cm48vlHFLu+AQkiolg0KoLxUVLQdVIXidOTaUd/HpEX7APtwOBnTGcnPIXIfZe50EB+A6kQY2pU691BV/BWXhm0Q7jogXQ257uAUNpBuSfcDj/GqAV5RyWIsPSks4ONyRuWVPPvWgevl4manhtoMsjRNkv0mq4J1CQTawavj21QHtVk3Yg6G1ZPjmcVne2CrZc86cU7nRlIN1aQgLN3jzHzXFHHjWk650vpVH1mrWkljAyXr3jJkEssZo6dpZVQ8StahugXqyorAOEHIkfuALjtMA09REZlgLVlVZjQ3sAqC7oGtoRDmQsZ4Ght8wh1gp+G0uaM/6MP/yOlz2TSG1BACHq6rWBSvNcb864o9r8Bc7b5OWI6kpYMV3+rhd2yGlti+l2jqFqxY2XJ2r88K7iyx8QJrmSKxDgVRYcsJeSRpojXXeIiTwGyHMxQY8FnQZ2aYf9RDTAORlRpM9Hu9PWkZBpnGNXUEpzxBif4qf4WsIdencZfITI4mkJEbac0M2UqZm4V84Swue/fGvg7aFWqvB8nt/B1o3w4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(52116014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?Bd7fyfeTOE+BM0TY5EbK+IMYBBcBi86BfdPLQRz3IZA5vlK+cAQjWM1iRy?=
 =?iso-8859-1?Q?90z3tjd0iUHC9eGMDYfzmqK0n/22Gz9Ioyj9+wgpUYiyw2+lZEXyfPUy+C?=
 =?iso-8859-1?Q?PmMGH/R9m9wWu16OzXmxPK09xN4VPC/7mvtluiMjS+p8jdWN64kdSyqSxI?=
 =?iso-8859-1?Q?4eQ0bd5YYBsiR7101RtWxAXfdFICkOQ5rPo7PCLlQJ7UL3vmnuhUQdWZE1?=
 =?iso-8859-1?Q?Z0J/zM43yZOUeuoFcES+DycjbjpwZtiSWWSagsRI4OxNATb6zWezUYjYYH?=
 =?iso-8859-1?Q?u3BT7cKnsXCLeFk86yAoZFQgHDYuqRGUzSQBytGFLWbj+SXcsIy+ESOeQT?=
 =?iso-8859-1?Q?AKsmYMRAbdydZ0mk3hnETWJG3YQo51YzdGMAQocezw3cgOAplaGnO01pai?=
 =?iso-8859-1?Q?zqT+mRQfuFx+30Bqu6VER9AU9/J1Kn2bXoIQgaRNvw6Pf1TzX6pGv5oAv/?=
 =?iso-8859-1?Q?AHdq0p9MVB2iyguV3WxtFGw1KWxF/qnqU0DggoyS+GghrK6N78aIkbeeoh?=
 =?iso-8859-1?Q?kZrpfBIVwKypUbEUKRz+kxvpTMS3eVb/Md5JJisoh8Yn7LYUgG74xZHUz8?=
 =?iso-8859-1?Q?WYFIJ68xPLBaRegy0l/jNrfmf9uyak5PXwYTiWGpAbJU2suVyMCdzS4prB?=
 =?iso-8859-1?Q?XHgZT/hdrhNiuKpqeesrsOrfEZVH0Ii+aCz1v+o9cIjS/w3gPEjcfIFrnP?=
 =?iso-8859-1?Q?/PNUWps6Jyc5sZMMBpB1CSiq2cxHw6PriPRH5SSkllv8e5J2iCqeVUTm3H?=
 =?iso-8859-1?Q?WMFKwd277dzDE7bN5Qc4xXsrYJTKdMkWhoQmJO29OYeqeZyhreH/QMJ13D?=
 =?iso-8859-1?Q?4aFoguqEx0n6o/F03DXEX7opSjkANYSzEfvEYqoupzVbnMwyrohb3SvDPc?=
 =?iso-8859-1?Q?g5DpvoLn+bI1BX6IITQt815nPEoy8HG853bckPRj5Nt3oFUxHRXnxdHJj+?=
 =?iso-8859-1?Q?N/HfuAU0VJ5/8AzOnnqaqKWaE+6zxuhC0vzQ+i3HQKyZycbiZWn0x6cdXT?=
 =?iso-8859-1?Q?esqOTHspj0Heej7IyBAYdRnYqYqaxpNSoZmmgsYyG0I04D2cTexH5sdbB2?=
 =?iso-8859-1?Q?JmFDMiwbhocrQJChoomyA/rOGoNX/nWa9Y/j5/3UpUGZyF5fYrE6+51m0P?=
 =?iso-8859-1?Q?xQcDe6CakCCBPn4thDbNQBoqgfcOFrf+HBZp6/jeo9aFG7YRhPo3f7kaTM?=
 =?iso-8859-1?Q?HlLcPz64mHMd4WxgsOhGmeck12Ght9mivHM9w9xx9nal2nELVqPYgp+cHJ?=
 =?iso-8859-1?Q?TtsWqnuksWcQTR2vkAgOCZFWscac5F5qfpzKtWb3K/7gJMNvb3M6gLD2Cj?=
 =?iso-8859-1?Q?YJuuBt2gay2O5Mzl2pgC6JYcwfHD4Zri1zTOWAu+d29PzMeWhOFSGj9lZL?=
 =?iso-8859-1?Q?e6NBWaNhvW0A3BpMnWOoHynYMJyQJrw0Md4VQPuk5mQVqwc6SybxDL11Sv?=
 =?iso-8859-1?Q?XkldawNCHo+Y85gwdGTDoBhXiX9gvMlJuS7l45Jl9b68oXuWvj5rW1m/HE?=
 =?iso-8859-1?Q?MqNOqKTeWDuw4xQ9zDEW9z9P00GecfSEu9Fqv5JCxq3tQFz2SCFSPlMSED?=
 =?iso-8859-1?Q?fGNcc8Dcyxb7DDh7AK8OCRGIMhoGik8l0tSdzZa6BGdvreZjoKlfzMQkah?=
 =?iso-8859-1?Q?z8fRzJ5Mdi3xDcMv5GuEDQJMefTCQ39KpqZ1Igj3B+wWL6HTdlXZ7kbfaz?=
 =?iso-8859-1?Q?msFqOKVnrqiGyJgTSQPwQM8VF8M3dCj9oE5ESbkRAOSyNj0INYWdok1pHp?=
 =?iso-8859-1?Q?btg+Htsnzt8J74PmpQOLIaZuhAC7V0rEwJqYnKI5q+KJCRufPIR/2zT0ZI?=
 =?iso-8859-1?Q?CeHfv1Vv9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85924c4d-6920-4b10-a767-08de8f309fed
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:20:13.8767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2Su3HZ+NY+4R7dvyBKNgT0tHHHJpd+0tBqfL/KvAlrygYr3A5cDKQZBsH5fQV5XfKRn/xM5lQaioWPbjD6HtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9633
X-Spamd-Result: default: False [3.64 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9781-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_SPAM(0.00)[0.833];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8806336AEFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 09:46:35AM +0100, Nuno Sá wrote:
> On Mon, Mar 30, 2026 at 11:22:10AM -0400, Frank Li wrote:
> > On Fri, Mar 27, 2026 at 04:58:40PM +0000, Nuno Sá wrote:
> > > The DMA device lifetime can extend beyond the platform driver unbind if
> > > DMA channels are still referenced by client drivers. This leads to
> > > use-after-free when the devm-managed memory is freed on unbind but the
> > > DMA device callbacks still access it.
> > >
> > > Fix this by:
> > >  - Allocating axi_dmac with kzalloc_obj() instead of devm_kzalloc() so
> > > its lifetime is not tied to the platform device.
> > >  - Implementing the device_release callback that so that we can free
> > > the object when reference count gets to 0 (no users).
> > >  - Adding an 'unbound' flag protected by the vchan lock that is set
> > > during driver removal, preventing MMIO accesses after the device has been
> > > unbound.
> > >
> > > While at it, explicitly include spinlock.h given it was missing.
> > >
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> >
> > Not sure if it similar with
> > https://lore.kernel.org/dmaengine/20250903-v6-16-topic-sdma-v1-9-ac7bab629e8b@pengutronix.de/
> >
> > It looks like miss device link between comsumer and provider.
>
> Well, it surely it's related. I mean, if we ensure the consumers are
> gone through devlinks and nothing is left behind, then this patch is basically unneeded.
>
> But, FWIW, my 2cents would also go into questioning if AUTOREMOVE is
> really want we want in every situation? Might be to harsh to assume that
> a DMA channel consumer is useless even if DMA is gone. Anyways, is there
> a v2 already? I would be interested in following this one...

This patch may be missed by vnod, I have asked vnod to check again. The
open question link to channel device or dma enginee device. I prefer link
to channel devices, so it support more advance's runtime pm management.

Frank
>
> - Nuno Sá
>
> >
> > Frank
> >
> > >  drivers/dma/dma-axi-dmac.c | 70 +++++++++++++++++++++++++++++++++++++++-------
> > >  1 file changed, 60 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > index 127c3cf80a0e..70d3ad7e7d37 100644
> > > --- a/drivers/dma/dma-axi-dmac.c
> > > +++ b/drivers/dma/dma-axi-dmac.c
> > > @@ -24,6 +24,7 @@
> > >  #include <linux/platform_device.h>
> > >  #include <linux/regmap.h>
> > >  #include <linux/slab.h>
> > > +#include <linux/spinlock.h>
> > >
> > >  #include <dt-bindings/dma/axi-dmac.h>
> > >
> > > @@ -174,6 +175,8 @@ struct axi_dmac {
> > >
> > >  	struct dma_device dma_dev;
> > >  	struct axi_dmac_chan chan;
> > > +
> > > +	bool unbound;
> > >  };
> > >
> > >  static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
> > > @@ -182,6 +185,11 @@ static struct axi_dmac *chan_to_axi_dmac(struct axi_dmac_chan *chan)
> > >  		dma_dev);
> > >  }
> > >
> > > +static struct axi_dmac *dev_to_axi_dmac(struct dma_device *dev)
> > > +{
> > > +	return container_of(dev, struct axi_dmac, dma_dev);
> > > +}
> > > +
> > >  static struct axi_dmac_chan *to_axi_dmac_chan(struct dma_chan *c)
> > >  {
> > >  	return container_of(c, struct axi_dmac_chan, vchan.chan);
> > > @@ -614,7 +622,12 @@ static int axi_dmac_terminate_all(struct dma_chan *c)
> > >  	LIST_HEAD(head);
> > >
> > >  	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > -	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> > > +	/*
> > > +	 * Only allow the MMIO access if the device is live. Otherwise still
> > > +	 * go for freeing the descriptors.
> > > +	 */
> > > +	if (!dmac->unbound)
> > > +		axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> > >  	chan->next_desc = NULL;
> > >  	vchan_get_all_descriptors(&chan->vchan, &head);
> > >  	list_splice_tail_init(&chan->active_descs, &head);
> > > @@ -642,9 +655,12 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> > >  	if (chan->hw_sg)
> > >  		ctrl |= AXI_DMAC_CTRL_ENABLE_SG;
> > >
> > > -	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
> > > -
> > >  	spin_lock_irqsave(&chan->vchan.lock, flags);
> > > +	if (dmac->unbound) {
> > > +		spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > +		return;
> > > +	}
> > > +	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, ctrl);
> > >  	if (vchan_issue_pending(&chan->vchan))
> > >  		axi_dmac_start_transfer(chan);
> > >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > > @@ -1184,6 +1200,14 @@ static int axi_dmac_detect_caps(struct axi_dmac *dmac, unsigned int version)
> > >  	return 0;
> > >  }
> > >
> > > +static void axi_dmac_release(struct dma_device *dma_dev)
> > > +{
> > > +	struct axi_dmac *dmac = dev_to_axi_dmac(dma_dev);
> > > +
> > > +	put_device(dma_dev->dev);
> > > +	kfree(dmac);
> > > +}
> > > +
> > >  static void axi_dmac_tasklet_kill(void *task)
> > >  {
> > >  	tasklet_kill(task);
> > > @@ -1194,16 +1218,27 @@ static void axi_dmac_free_dma_controller(void *of_node)
> > >  	of_dma_controller_free(of_node);
> > >  }
> > >
> > > +static void axi_dmac_disable(void *__dmac)
> > > +{
> > > +	struct axi_dmac *dmac = __dmac;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&dmac->chan.vchan.lock, flags);
> > > +	dmac->unbound = true;
> > > +	spin_unlock_irqrestore(&dmac->chan.vchan.lock, flags);
> > > +	axi_dmac_write(dmac, AXI_DMAC_REG_CTRL, 0);
> > > +}
> > > +
> > >  static int axi_dmac_probe(struct platform_device *pdev)
> > >  {
> > >  	struct dma_device *dma_dev;
> > > -	struct axi_dmac *dmac;
> > > +	struct axi_dmac *__dmac;
> > >  	struct regmap *regmap;
> > >  	unsigned int version;
> > >  	u32 irq_mask = 0;
> > >  	int ret;
> > >
> > > -	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
> > > +	struct axi_dmac *dmac __free(kfree) = kzalloc_obj(struct axi_dmac);
> > >  	if (!dmac)
> > >  		return -ENOMEM;
> > >
> > > @@ -1251,6 +1286,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > >  	dma_dev->dev = &pdev->dev;
> > >  	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > >  	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > > +	dma_dev->device_release = axi_dmac_release;
> > >  	dma_dev->directions = BIT(dmac->chan.direction);
> > >  	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> > >  	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> > > @@ -1285,12 +1321,21 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > +	/*
> > > +	 * From this point on, our dmac object has it's lifetime bounded with
> > > +	 * dma_dev. Will be freed when dma_dev refcount goes to 0. That means,
> > > +	 * no more automatic kfree(). Also note that dmac is now NULL so we
> > > +	 * need __dmac.
> > > +	 */
> > > +	__dmac = no_free_ptr(dmac);
> > > +	get_device(&pdev->dev);
> > > +
> > >  	/*
> > >  	 * Put the action in here so it get's done before unregistering the DMA
> > >  	 * device.
> > >  	 */
> > >  	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_tasklet_kill,
> > > -				       &dmac->chan.vchan.task);
> > > +				       &__dmac->chan.vchan.task);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > @@ -1304,13 +1349,18 @@ static int axi_dmac_probe(struct platform_device *pdev)
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	ret = devm_request_irq(&pdev->dev, dmac->irq, axi_dmac_interrupt_handler,
> > > -			       IRQF_SHARED, dev_name(&pdev->dev), dmac);
> > > +	/* So that we can mark the device as unbound and disable it */
> > > +	ret = devm_add_action_or_reset(&pdev->dev, axi_dmac_disable, __dmac);
> > >  	if (ret)
> > >  		return ret;
> > >
> > > -	regmap = devm_regmap_init_mmio(&pdev->dev, dmac->base,
> > > -		 &axi_dmac_regmap_config);
> > > +	ret = devm_request_irq(&pdev->dev, __dmac->irq, axi_dmac_interrupt_handler,
> > > +			       IRQF_SHARED, dev_name(&pdev->dev), __dmac);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	regmap = devm_regmap_init_mmio(&pdev->dev, __dmac->base,
> > > +				       &axi_dmac_regmap_config);
> > >
> > >  	return PTR_ERR_OR_ZERO(regmap);
> > >  }
> > >
> > > --
> > > 2.53.0
> > >

