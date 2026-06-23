Return-Path: <dmaengine+bounces-11738-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /e94BRQgOmqO1wcAu9opvQ
	(envelope-from <dmaengine+bounces-11738-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 07:56:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1E96B44DB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 07:56:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=IVz9anhN;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11738-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11738-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4871C3016BAB
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jun 2026 05:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7271A3A9637;
	Tue, 23 Jun 2026 05:56:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020101.outbound.protection.outlook.com [52.101.228.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC0331EB8;
	Tue, 23 Jun 2026 05:56:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194175; cv=fail; b=rQcf1qlBqsnA65Y0VzE7YV92iNGSc7F/BgYX4M57MRnzji4kzqmfexRS6f5QAJnnTil69FRj6JxchdoKsUjdJdnoDdgT18/R8NPlM0kwoI6ZdNMfJUahUn65nDynUWQ/Ih4+a8diOJIrj29UZ0T7YkArLSEyTkibGVlAfHLKYCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194175; c=relaxed/simple;
	bh=TBqd6ggXbwDZDHeGm80yDgGsZ6c029Ijh38+hecoGD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oFv+U9KNE+7AOeaVpeHmi0SdEgxO6PQQGgmKDejb8hyYpU8RfMBMV31N0x86PpZvVCEOguNI/k66Yjk3Pv/hdD/sPSvpKgL4afO+dYusW998J4s/CuCnRfNoI3sPcK2B+MhudeajeuhTwGtXZKv5sWlPmR3geHXJEWsa0WHEY5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IVz9anhN; arc=fail smtp.client-ip=52.101.228.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQ/5oINryI6Qw6Xu2dYhPKCBDocOq9qzWH/RIGk4joLIsv691spVKQSZpjWdxWRYV+wZSQEUKQp9OMLHjoPMfnFarFz4wKz+Pq1WsHSSHBs4j4WrhMbZGLkwxJVA2xSI/P09PS6sJT5ty2dmmDeTMWvfKB1uoJXGJ0upUtidVzTmx2eHcJaA5OAs+v/6nfjMR5+wiqaz13ofoF13PzVzN5whdwudxwVuFpoMc/GsEqfgATfybvxwYxy1wMRIXOzfaHLT3V5ixPsMta30YG8cAsZOHzV5Vhwg8RevNiHbDDZmLUzNA5Dl4GhpJYTyEAsjPU0j5eD82+hgEAF8NKYLnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVm1l/rZjSgG0D1qkVKBhYLRhUNKYmkaYlb73Fyet+I=;
 b=J20tOkCwPnMY52nesRiDU4uTbVOgSwfk91Pzc4Jw+OFsvVIe/EdCB7Oj4hd+IVwAnEl2Ej6SewH964yl8vgKpDHmVqWvDZbZsoVRUbmi2w7yRqbxgyFkPd5KV6fO8p7OayT5oqaxVAAqAPhIVLDFztlW3KHAZG1yMDjQV75owQPfAq94gUtsXgdcf4QpiP8rlemx6o4zloSY/wKM1S5xgswzRH3p7IDg/CR5OKr9L60npPpDY/KzW2P7So9nuYFmBd0wWRE7yLFsXZ9sqdjU7Zbo0QGZuKj78YD18/9Af0HEJDrfTfG6gYHg8sasGb//aDwY6mKdmCv1IeJ2O3VyFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVm1l/rZjSgG0D1qkVKBhYLRhUNKYmkaYlb73Fyet+I=;
 b=IVz9anhNtQFkhzF8RT6xGV+y98K56amJNEZxLWtddpwdySgq+9h/VQafoQkWXqGhhn5MI81et1RhLpOdYPKGCtI5Ad02tSGdTniZuCdYewqEtYY4pRhi3YNL8fiKfyqQLyeDh05vVrwfUoerBKW6lz5Qgln48oTBHfbezao58V8=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4713.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:195::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 05:56:08 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 05:56:08 +0000
Date: Tue, 23 Jun 2026 14:56:06 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <wmwhekjfeqomzehfyqczzxel3knkxlfgfyrifeqpcqpqq6viwq@abwyzxaibkio>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26>
 <ajlEGS99fQT5rGkf@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlEGS99fQT5rGkf@ryzen>
X-ClientProxiedBy: TY6P301CA0024.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3bf::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f1a3dff-926e-4417-c805-08ded0ec1ebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|10070799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	f6Vl66PRx7ytxqMu56qg/8+xetL4ettYaeGV2/xPij1+7HCW0aad+Nv9jl9kkFgvtKW3WoZUzeIWniOfkrkLwFReDQIzeUMU1r8mFIPuS9IFdMiSyittBFbSYrzPOgBgfxmPr1R1vndTyimIxb/h+OMXnxc/ij3yPPTCDbDO+SZWriH9Wy8dX1GDFyO7eAyP83uiJSHoxd2tqAizg/f6FJTzWEvID+cANMQucEEhGwmVTCvukIjwltbE0jFX7oZcWpgi3HTw0hKnwxHCZDYkNBXwgCi5B2jWzANRl56Z4tkzGEPTZfMWW02RYjzGkeBkYkOhpOvpXYKejMBatlJKWFQZFd6Z3bsFjbQItd9cDnbYNOPQA5xkfO0XPLdA3PiLyRbeLcGe8TrczBA+OzeUxH7u+lYydDOfbw5hOHJAd5s9KmpgJi9/UnKGw6XJj9IFZlOddVNgXDLgAlSogizD9bte8XyQeKZ4GnQJ/vMBzjSuoJ7a0zRfs9kzXTJCFxyVWQkZcMC7PiHox+G0f3Qu40gTKwFj9Fe76rqojSlD348GwTFIHTXz1moAp4w/jh2RshahlC16YPsGuoFmbJePyZ9SN/6Sj2DPFugd9vhG0pdavBTuZIURQqhWq+nBKI58x8TLKNXpD6x1YQ/gbqY5ivv9HVsuEnWUSwO1/zWAkvw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10070799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VlJf2ZIWLTS8gwEf3z9W8nLsFt2hPCDs7POvbaAVKQAK4zA91WOnoH5XUcfA?=
 =?us-ascii?Q?xq7D2FVVjD/G7QOHO0BuufR9GBNiaHhwB+EFeVlNr67qOXZi9iOvs7KXrs28?=
 =?us-ascii?Q?H6VnmQza/JqEVuQnnf9/KyFv4xWnmm3/Z2yvWQtAe6o+8d7UlQ6ziIU2zNUL?=
 =?us-ascii?Q?8y9tD+PlyvXyUFVeChCd5aeBn1mROVpl/aULzI3HjKXns5tLkV7pBl/oEFYy?=
 =?us-ascii?Q?5mm5a+bhl0BAihFHDBVQviby4W6EWD1iRnW5u9nGiu/0Wq6hPzFUc36L+GBk?=
 =?us-ascii?Q?yXnDhDrf/VzWRydLjt1mTW5Ozw8x7gSTYDg9zSc8v4YbGf8QCJ3e2eyVT6DG?=
 =?us-ascii?Q?GczGdIgkmgy6AFxfVcGU8pb8eMBCfCiVWkHS1/NncVGrljB8W4tIEcpZ366L?=
 =?us-ascii?Q?fib5BRkX1exqhHJ9pCgDBCy0dLQpKcpzQwVeGSZSaLw9Bm4ZXSQcwo/TnzIc?=
 =?us-ascii?Q?wM50TIoaTuyJphX3cAh6jg4WOVGYPGYA03XXbZr1wJOavewjiTHZhldAW/j8?=
 =?us-ascii?Q?QtRjuouxKG+V7wbyxWfPbQXsTzzL69cpaZ0NtsaMCAKiQrPSBkVWpT4Ck+pq?=
 =?us-ascii?Q?c/CDmQhIDIAC6HhE//r24C0+0eUasBRZ69blzZ5jLZNyjZalNSsD8tRpCNKu?=
 =?us-ascii?Q?k6OeJJrSCWsWRKg15MqA63jKsV2KU2mFQU/SBNwPFuff5q7YjgPwr4NXR7Dz?=
 =?us-ascii?Q?6dEDsaEmOtoU+6GxBNjXJEgX0Lboq1MLfgqCiUgP4YokN8ptgKgnTmiYOAJR?=
 =?us-ascii?Q?sXimdACecu5/gZECBKWuz/xZ/5LXXdDKKclgasGdT5yH9ZuHfICesaIMX2MU?=
 =?us-ascii?Q?YjbjZAyND3N6fAHvCMPm+SESH3DL1YdQcBQucylUYNsEWCQfWCMpeoUF7vx1?=
 =?us-ascii?Q?ULVWJWF/BvPE2dIlsNYyRkL9sLRi/dLlfG4Uv1gAHOp6aInmyZRvunXzIjc/?=
 =?us-ascii?Q?hzTxGwu3nfDcgA+gBQ3Q+29nEk5VESISoRci1rKyMFSJrKYx2gVhsMIFQ0Lj?=
 =?us-ascii?Q?zCSobkph4E1CLnPeEMTW7L3IQfLgq3ibUUBSBhb7hfw/86wmJnrwhhGIUPa1?=
 =?us-ascii?Q?XR5BpVWQwJwJmdVgSF2hetw0sGX0B5x6djRdykehelhNnQvJewQhbQ8/udsA?=
 =?us-ascii?Q?E9Zey2Agkbmri66QYKRsKKSW1sl+c5t0SfaImkrt/FHrwSI1A2d2HsjB6TAu?=
 =?us-ascii?Q?jhStjA4CIWC+u3tRGWui3+1H/rIeRSXCBhdsVfDlVwCZg++tGTHkKEVXrEMV?=
 =?us-ascii?Q?E9cqTshAhspxnt2iF//m+1QfOdxYyDlqUhCcxfcKP5ShRc3FRZI/W+UCd+Sx?=
 =?us-ascii?Q?GNri1Z3tOtrVURAeBKEnc3lxasMGnTWgVM4KyWk3FMo090H6G/pKlx6+QwZK?=
 =?us-ascii?Q?1DiDZy86U+/6FJmPkggBk1mtwFjd8l/BVO2jH0lK9p2JSYjYyumtx9ftl9T5?=
 =?us-ascii?Q?hh6s8sgyiQy2/rHnhFRh0I84tSFR0WwXONV46dsA9cdS4z5Ec1pwvtIu468P?=
 =?us-ascii?Q?TcU5Z9a5v48RP9vEjas6ERIAOAeQo8fyAFrNRZ9AM4oQu2MtlF4KA9rxX4Yt?=
 =?us-ascii?Q?AbcMSmDTd6mBPd3gh5OSaaLH8q1LhtnlGQtrVJc/1JzQuvpRzcxheHR1tK4K?=
 =?us-ascii?Q?GKvw1tSanwTv4nbmhmEbxv0cRAqDHj49AQ13XG3hMIUovLMB62wC+AueesMr?=
 =?us-ascii?Q?A1NPmy4gxAxGgN0SUIU0ulAIwhdy6d4l3RLJIqacAymeB4b6zDIHgiZSKu0A?=
 =?us-ascii?Q?GsBHpNho0MBcIAKOALa+rspna2CXsWzknB4cbp23QqSWjCy4x7Dq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f1a3dff-926e-4417-c805-08ded0ec1ebf
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 05:56:08.1226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ66S8fiFHrOkRtLWI0wcZjqzzGRVDuOwC5QJjxU6PD0YRm0IPZrprWfQwPl/25NTUWFu2DKMStn41sWFi1KUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4713
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11738-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:cassel@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,abwyzxaibkio:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B1E96B44DB

Hi Niklas, Mani,

On Mon, Jun 22, 2026 at 04:18:01PM +0200, Niklas Cassel wrote:
> On Mon, Jun 22, 2026 at 04:38:49PM +0900, Koichiro Den wrote:
> > On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> > 
> > Hi Frank, Niklas, all,
> > 
> > I am looking for a good way to stress PCIe controller DMA engines, such as
> > eDMA/HDMA, and measure their upper-bound throughput.
> > 
> > nvmet_pci_epf is useful since it is a real in-tree consumer, but it is not a
> > very direct benchmark for the DMA engine itself. So I wonder if
> > pci_endpoint_test would be a reasonable place to add an opt-in DMA performance
> > mode.
> > 
> > One possible option I have in mind is:
> > 
> >   - a new fixture, pci_ep_dma_perf
> >   - opt-in execution, for example with PCITEST_PERF=1 environment variable
> >   - a few variants such as single and sg, possibly with a few knobs:
> >      - PCITEST_PERF_NUM_WORKERS, to use multiple EP-side workers
> >      - PCITEST_PERF_NUM_CHANS, to use multiple DMA channels
> >      - perhaps other knobs for SG entry size, number of entries, etc.
> >   - the new tests: READ_PERF_TEST and WRITE_PERF_TEST
       `--- (A)

> > 
> > For the other possible places I could think of, this still seems to fit best in
> > pci_endpoint_test. For example, extending dmatest does not seem to fit well
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > because this needs both EP and RC side setup. A separate kselftest also feels
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                         `--- (B)

> > like it would duplicate a lot of pci_endpoint_test code. That said, I might be
> > missing something.
> > 
> > What do you think? Any thoughts or suggestions would be much appreciated.
> 
> There are two existing (out-of-tree) tests for eDMA that I know of:
> 
> 1)
> https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> 
> But as you can see, the comment was to use dmatest instead.
> AFAICT, dmatest currently only supports DMA_MEMCPY, which, by hardware design,
> cannot be supported by DWC eDMA HW (since it only allows remote to local, or
> local to remote, and remote has to be a PCI address, while local is local
> physical address).
> 
> Perhaps it is possible to add DMA_SLAVE support to dmatest.

Thanks for the pointers, Niklas.

The first one looks like a host-side test on top of dw-edma-pcie, where the
RC-side driver programs the eDMA through BARs. That is useful, but it is a bit
different from what I had in mind here.

What I am looking for is closer to pci_endpoint_test READ_TEST/WRITE_TEST, but
with a perf/stress mode: the RC side provides the buffers, while EP Linux
drives the EP-local DMA engine and reports the throughput.

I agree that, if we extend dmatest with DMA_SLAVE support, then Vinod should be
involved early. In theory that could cover this too, if dmatest also had a way
to set up RC-side buffers and pass their PCI addresses to the EP side. That is
the part that makes me unsure dmatest is the right fit here (see (B) above).
Before going too far down that path, I wanted to check whether the PCI endpoint
test stack would be an acceptable home for this EP-driven case.

> 
> 
> 2)
> https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/pci/controller/dwc/pcie-dw-dmatest.c
> https://github.com/rockchip-linux/kernel/blob/develop-6.1/drivers/pci/controller/rockchip-pcie-dma.h
> 
> 
> Anyway, since Vinod is the maintainer, it is probably him you need to talk
> to come up with a way forward. To not waste your time, I would talk to him
> before you spend a lot of time implementing something :)

Yes, that makes sense. I will keep Vinod in the loop. :)


Mani, since this is about the PCI EP test stack, do you think an opt-in perf
fixture in pci_endpoint_test/pci_epf_test would be acceptable, or would that be
too much for the EP test driver?

The rough shape is the one I described in (A) above:

  - a new fixture, pci_ep_dma_perf
  - opt-in execution, for example with PCITEST_PERF=1 environment variable
  - a few variants such as single and sg, possibly with a few knobs:
     - PCITEST_PERF_NUM_WORKERS, to use multiple EP-side workers
     - PCITEST_PERF_NUM_CHANS, to use multiple DMA channels
     - perhaps other knobs for SG entry size, number of entries, etc.
  - the new tests: READ_PERF_TEST and WRITE_PERF_TEST

Best regards,
Koichiro

> 
> 
> Kind regards,
> Niklas

