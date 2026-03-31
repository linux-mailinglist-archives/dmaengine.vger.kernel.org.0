Return-Path: <dmaengine+bounces-9779-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKW+LYHYy2mILwYAu9opvQ
	(envelope-from <dmaengine+bounces-9779-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:21:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5922536ADAC
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7DAE3015481
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 14:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887C73DC4AA;
	Tue, 31 Mar 2026 14:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MFdAKO4m"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013035.outbound.protection.outlook.com [52.101.83.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72283F9F44;
	Tue, 31 Mar 2026 14:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966582; cv=fail; b=i36v2V2mioS72JEJtptf2vVxC3D80vPnODRoqSIWLOsNWAzTzC9z+8WwrNSUSN87J4PQgnnKGL7eSo2gm4gWXmLq0Ow51j+A5zDxntUG72/s4ZDGAXCTWr9Y23usvnqtdnx9ofwFXcwhG9ISHYCatRVVulp9vhmpfntmIoSXkig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966582; c=relaxed/simple;
	bh=d+CHYhwcHLqtMFDCZGB0xwflNjYOqhq9rKCcsBm9sgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nBHOw//mlWlXcKszC063sS+jrn7QtX3CPCPdFuOX291nadSuUGhXgk+66X1QjAUuM8kjnVfwWSiO8l1gmlK03+I+GNeIIfyDrepAmC0JF7MDk53ai1jcaWMYRjVxtrOpn0PehKNJxSu8J/4dhAfAJhx6lqH0SN85HpjQMFNq6qg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MFdAKO4m reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlT6YmuSI695MFDiOAeXhc3haiwCPph/Jz+ulp+phhjBU6wXk3Lk8U87lFS1Gzuel8yFl9x1uKqr6+OgkWF1ugYEYuITJvnVGnaQd9qU9iSw6IEPeZ3eSX0ap0GhWjemY9KaSEoB/YGXhHB01+m92pYpAG8T6CiQydzHJKIhZaGnT9CnQP2WmneJmBC64xb6wVW/Gbefkdkxqqb+1GYvNlEeOX9R6xriU8a6tEEdWZfP6KLBILxltzP96QSSQdS7mk4u+OToqrugnBSIVbS+Mteg9PSxbr7UmAysezjjFI7yIb0zcxH0sbdsg+zZC3Us9e2ukmBNjbCMToipJW9Zfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etzzKsccG3tPEA4Cqfg8Ba8vp76l6ThWJ1xY/kiXHsE=;
 b=P2Om+mXCGxZieqZZ52C3LOeNN76mHxqvEQuGQoXDZF/L0K9xx3oHtWad0Bqa1kQPXOxl50imm0LqE6UBIAuBz3n0iDzB41OHUk75vKBgoPl/tlG+Eph5lMZ8IjnNhw+6NZG7SsgdEh05n95AgjQy0SrdsPmHX41UXwZgmsBIj/m2MxALyfyF0Tp5R8/2A/Q4FKBiXHpr4+pC9SB5s4IaEQNNbaT3YPn6p59vFGo83T+JXoqI8G3NvWUTjF0A7LEH32m9LI5N72vGLF2qjTUJxX8o/2Uh7/p3BfST5yPtvpeENjDU2/vCx5P2+F0ZjS+PnaRxSk9SL2Sp0h0+8wAhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etzzKsccG3tPEA4Cqfg8Ba8vp76l6ThWJ1xY/kiXHsE=;
 b=MFdAKO4mFEXgSG1w2i1d+6eR2DOBwoX4vsTLR9DLSMz9wksKF72l3tllGbSbv86+bX33fwnSzjKUwv6sSEp0gM83GNS6cuI4NJxBaJrOux6J6WpK4AgcSNoNGni+P13219MG3h6aIIix/tngRpirXXHzRZr16zrySqcUg7GEp+1Jm1MuSJov1h4e14nRkaLK2lWRJu/Gd3xS+9e0TWFig2QwhbQ0rgBDnrqLi3GI1HN5tRG7MN7zEvFFYfEvZSnELg3kp7KT4QoGb+xxwgRUt2td2EbuF3yiV24BLVXJU8HaETRdM1Wv4VLCovTQUEr5Wj/j3hGArCHEdgfj8Oy9TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AS8PR04MB7495.eurprd04.prod.outlook.com (2603:10a6:20b:295::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 14:16:16 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 14:16:16 +0000
Date: Tue, 31 Mar 2026 10:16:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Eliza Balas <eliza.balas@analog.com>
Subject: Re: [PATCH v2 4/4] dmaengine: dma-axi-dmac: Defer freeing DMA
 descriptors
Message-ID: <acvXKYJkXID9qiqM@lizhi-Precision-Tower-5810>
References: <20260327-dma-dmac-handle-vunmap-v2-0-021f95f0e87b@analog.com>
 <20260327-dma-dmac-handle-vunmap-v2-4-021f95f0e87b@analog.com>
 <acqVsvQo87NvlqU7@lizhi-Precision-Tower-5810>
 <acuJ-Girr0ozQHh2@nsa>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acuJ-Girr0ozQHh2@nsa>
X-ClientProxiedBy: PH8PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:510:23c::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AS8PR04MB7495:EE_
X-MS-Office365-Filtering-Correlation-Id: 9222114d-cd7d-4fb7-5b02-08de8f301289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|19092799006|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jcGAv+7ph7wVO63DHgzR6NhB1uwJomNuxc/73lehSEvp782j/EgDf71NQezMPaPr2EjGXAjLB6HXCZoLY7U7olnmAhLji3suIn57Nr7YsasngxuCHztRKwRmnVx0mOB6fET2dtdp4fa0nneUGqkAw3GpOuJvN0giGez0G7LBIout/9lSARX7GKidUPXupBRJ2y0i9Nvv3YrMb95zd6caDlAb8IAe15+YtNt0c9Bf1D+JT8WGGIB+CyAf9I+Ky4pCeGLdEtIyQckmtp23lxZW4C7i8ysTCMi6Oribc3EnYxjl4Nc/ia+R6UFGu8+VfiM/HbsuMSPGFZCmFx9/T9nLkK8gAAXHp4tTft4lOX0B3GMQvd5uPby2mmf8VVe12IGF74iTShjB+8W9/nKroX581d6OspOzARKotx+LJAlgxS/TySQv6m9OpC7Rt9yExxkl3Q30d1BfCsm9QzUZuhz6U5pbrLIUnJ2wAoSit/jI/fPf58TfcKorIOVG1eKVRcIfjiJOt1UGitktuY55FcEaLJ3oCTNkj4LUWsOy1w6GY05n4kzQGsZEMYtAW6LaaZFKul+uASWnPdHbayCI944fkFGlVlxzAYBPUuL13XdwluC73p+WeTTLCy83khxESrc6WaVqRZQA1/lPbv41YFyT0DvLLcIcPDfV+Z2b2F2uJguH79JKtASDFvhvKFpKZkC9lm/PAsXGoDqQDwKPutfr/Vsc+jb5PO5F2F63jDjZs7tb9A5Q+D7x/tvRISLfbKiY+APDJOFwlLOsu1xGxjiCPLEsGbRgxglc2+m9MPDtmMs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(19092799006)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?PheDZuR7kaTLvGCUy9z3IqayGwjQVa3avxX0qjYq023PpGEvFd1kMgW9dD?=
 =?iso-8859-1?Q?QYm5d4+bm6GXVj7lMvSbL1ogfU3PVB8OUlG8ztcGIBpMMAPWx3TY+wrQpE?=
 =?iso-8859-1?Q?1CjpbYxtSklSD3wMTurSvJpoNwlKkfTaRr6F70AGZlhceCdJQaYqZDKzXI?=
 =?iso-8859-1?Q?cBm4NdOoCUmbFhqam1GsbU51Nw38dsOob8joVUhhjIzK5oQXAAg+9psuer?=
 =?iso-8859-1?Q?MGLzKl7WoR8Ygwh2LHGoHmGJG9J9fgkKYln9jnJjg+0eeJyL94ArF5LLUy?=
 =?iso-8859-1?Q?xYk5xpSg4ySCTHK2DiqOThi+c21xmHtS3ZPjZ3Y9bMhv+mC9kYhfUr2hUY?=
 =?iso-8859-1?Q?t6FhX206GAbd+D69gXVxY1E7eIPhAFrdvmrvSByxZDGUVL8ESUNa1mDXW7?=
 =?iso-8859-1?Q?/mWJIaDarP2yNSIPmhM9ZdKg16ehA0gizVkven19OSyStdjx+HYjv1FkRc?=
 =?iso-8859-1?Q?G4lzsj+OjImvPC2+vi9DIh49tq0B+loTunkjeqQ0GPPuz4ZUrFH73kHhzG?=
 =?iso-8859-1?Q?q6GDf6W8cV1wP0DUTX7Y4sywqpyylEQBO7wq6YKmALHZcWkltuEEuqMqKm?=
 =?iso-8859-1?Q?YLHf3bsNL07NtXdbyzPEv9Vh7cdDhNcPsrb3200AVrlLL395tOk91APOWs?=
 =?iso-8859-1?Q?2fBNmv6DW7pPmmWI8QkoQlU1+rlHjANbJWp+wB6Z8kSW1GwWoE52yl8ekc?=
 =?iso-8859-1?Q?OfdKQ/ug5V1LIcCs9rY9kMDxTyDml+IYtagDSiPZXDzUpFVVCDIcFx+Eka?=
 =?iso-8859-1?Q?fvrlrs6MSF7/2NgJy5bU6bHkZ9Zm3ea2dGfCheSkCjuWrgDCXBvbRXgh7w?=
 =?iso-8859-1?Q?owIoD+JeJThuY/1ZlMrFuw3hWfbhmMPjjgXhcnJozeRIMoJCy1lf7C9GDG?=
 =?iso-8859-1?Q?jxMQV6QFtt5elhcy8QmzhJERJeHLpO3OxKQAm+/u4MV43UHUyJCsU1egaN?=
 =?iso-8859-1?Q?XU55GEbtLmIBOfXUCgyaYkXFAP5qTzm8d9YuTNRVHOJF3R6QJsVJ4CP3YR?=
 =?iso-8859-1?Q?egj9Qg3EFbnp3Yv5DzxEOpQcC/njFpHCUN1cgEGxnQFHh0PqpjiiU1B0bw?=
 =?iso-8859-1?Q?8gYG3a2EPazAgB+qYM3CS319FcnW8pAAXfWZP9Y0+wT+49hGIVzAF1mVlb?=
 =?iso-8859-1?Q?ciKETf5udHETUGSBXLPqzKlRxD0hS1x5ulRUgTZoD/mYC2fSUbqIJBM2QC?=
 =?iso-8859-1?Q?yfMcjexDs7wXwgMvLDCy1LfFxIvgDLv560qaDPqn9qu5o/5ofs3L9fRq8D?=
 =?iso-8859-1?Q?hXOBSo5bL6oJG9RpkNGUdX8nwd2493VXWeQkTSl6fG6n0LkcSCyRFhuqsm?=
 =?iso-8859-1?Q?9xUrdt9ZZvn1Bubmcs1QYgos8Ok/5WKPVv4rZ2EF73Z7s1CbhWUFfuBqKc?=
 =?iso-8859-1?Q?9abmIK7bVWL8gSATdez1P3JKuYfCdJXtQPMAoGQO4xO1K7PPvWVIzcLtVc?=
 =?iso-8859-1?Q?Am9QnpDhKCVubgpEB+6GBDmRbbTj+2F+UDq5VT9Td5L39iju2yZwMZtzts?=
 =?iso-8859-1?Q?tgWy5bHGO2mvIwo91mMntGYFZbuEOuDNOakiEhet/80hLUg5ykn7K9NEQ4?=
 =?iso-8859-1?Q?jfbjK9nHRGwcVCk5TX698M/03PhY/MskZTh/uPgnq1eYyPT/0+1AnLSx1H?=
 =?iso-8859-1?Q?ltkRekQAruQjSG+/gqBj7xAM7tPKavQdJLkx+P4522Xwe4AfK4LwJs6IIN?=
 =?iso-8859-1?Q?Cumj/qKTGf3NdqBB3BaYb3BF3ULhmdy4ITDamOQTORmlqwbygGmqWX1gcJ?=
 =?iso-8859-1?Q?FOv4hKB5LBwRXBvNV4w+Br/pMHacyBDCoXT2mC75l6WDI32V6X1mnzIZnm?=
 =?iso-8859-1?Q?u2Xanl7PUw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9222114d-cd7d-4fb7-5b02-08de8f301289
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:16:16.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2KvIuckF9TRNcN/OUxWXl0vjuuLhJwQUektuUd8Xnlqz8wHYm+ultWH1VaYmRJk7K5Ebt6GFZGk35Vb1FL0DpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7495
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9779-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.622];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 5922536ADAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 09:53:45AM +0100, Nuno Sá wrote:
> On Mon, Mar 30, 2026 at 11:24:34AM -0400, Frank Li wrote:
> > On Fri, Mar 27, 2026 at 04:58:41PM +0000, Nuno Sá wrote:
> > > From: Eliza Balas <eliza.balas@analog.com>
> > >
> > > This IP core can be used in architectures (like Microblaze) where DMA
> > > descriptors are allocated with vmalloc().
> >
> > strage, why use vmalloc()?
>
> It's just one of the paths in dma_alloc_coherent(). It should be
> architecture dependant.

Which architectures, this may common problem, dma_alloc/free_coherent() is
quite common at other dma-engine driver.

Frank

>
> - Nuno Sá
>
> >
> > Frank
> >
> > >  Hence, given that freeing the
> > > descriptors happen in softirq context, vunmpap() will BUG().
> > >
> > > To solve the above, we setup a work item during allocation of the
> > > descriptors and schedule in softirq context. Hence, the actual freeing
> > > happens in threaded context.
> > >
> > > Also note that to account for the possible race where the struct axi_dmac
> > > object is gone between scheduling the work and actually running it, we
> > > now save and get a reference of struct device when allocating the
> > > descriptor (given that's all we need in axi_dmac_free_desc()) and
> > > release it in axi_dmac_free_desc().
> > >
> > > Signed-off-by: Eliza Balas <eliza.balas@analog.com>
> > > Co-developed-by: Nuno Sá <nuno.sa@analog.com>
> > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > ---
> > >  drivers/dma/dma-axi-dmac.c | 50 ++++++++++++++++++++++++++++++++++------------
> > >  1 file changed, 37 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > > index 70d3ad7e7d37..46f1ead0c7d7 100644
> > > --- a/drivers/dma/dma-axi-dmac.c
> > > +++ b/drivers/dma/dma-axi-dmac.c
> > > @@ -25,6 +25,7 @@
> > >  #include <linux/regmap.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/spinlock.h>
> > > +#include <linux/workqueue.h>
> > >
> > >  #include <dt-bindings/dma/axi-dmac.h>
> > >
> > > @@ -133,6 +134,9 @@ struct axi_dmac_sg {
> > >  struct axi_dmac_desc {
> > >  	struct virt_dma_desc vdesc;
> > >  	struct axi_dmac_chan *chan;
> > > +	struct device *dev;
> > > +
> > > +	struct work_struct sched_work;
> > >
> > >  	bool cyclic;
> > >  	bool cyclic_eot;
> > > @@ -666,6 +670,25 @@ static void axi_dmac_issue_pending(struct dma_chan *c)
> > >  	spin_unlock_irqrestore(&chan->vchan.lock, flags);
> > >  }
> > >
> > > +static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > +{
> > > +	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > +	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > +
> > > +	dma_free_coherent(desc->dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > +			  hw, hw_phys);
> > > +	put_device(desc->dev);
> > > +	kfree(desc);
> > > +}
> > > +
> > > +static void axi_dmac_free_desc_schedule_work(struct work_struct *work)
> > > +{
> > > +	struct axi_dmac_desc *desc = container_of(work, struct axi_dmac_desc,
> > > +						  sched_work);
> > > +
> > > +	axi_dmac_free_desc(desc);
> > > +}
> > > +
> > >  static struct axi_dmac_desc *
> > >  axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > >  {
> > > @@ -681,6 +704,7 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > >  		return NULL;
> > >  	desc->num_sgs = num_sgs;
> > >  	desc->chan = chan;
> > > +	desc->dev = get_device(dmac->dma_dev.dev);
> > >
> > >  	hws = dma_alloc_coherent(dev, PAGE_ALIGN(num_sgs * sizeof(*hws)),
> > >  				&hw_phys, GFP_ATOMIC);
> > > @@ -703,21 +727,18 @@ axi_dmac_alloc_desc(struct axi_dmac_chan *chan, unsigned int num_sgs)
> > >  	/* The last hardware descriptor will trigger an interrupt */
> > >  	desc->sg[num_sgs - 1].hw->flags = AXI_DMAC_HW_FLAG_LAST | AXI_DMAC_HW_FLAG_IRQ;
> > >
> > > +	/*
> > > +	 * We need to setup a work item because this IP can be used on archs
> > > +	 * that rely on vmalloced memory for descriptors. And given that freeing
> > > +	 * the descriptors happens in softirq context, vunmpap() will BUG().
> > > +	 * Hence, setup the worker so that we can queue it and free the
> > > +	 * descriptor in threaded context.
> > > +	 */
> > > +	INIT_WORK(&desc->sched_work, axi_dmac_free_desc_schedule_work);
> > > +
> > >  	return desc;
> > >  }
> > >
> > > -static void axi_dmac_free_desc(struct axi_dmac_desc *desc)
> > > -{
> > > -	struct axi_dmac *dmac = chan_to_axi_dmac(desc->chan);
> > > -	struct device *dev = dmac->dma_dev.dev;
> > > -	struct axi_dmac_hw_desc *hw = desc->sg[0].hw;
> > > -	dma_addr_t hw_phys = desc->sg[0].hw_phys;
> > > -
> > > -	dma_free_coherent(dev, PAGE_ALIGN(desc->num_sgs * sizeof(*hw)),
> > > -			  hw, hw_phys);
> > > -	kfree(desc);
> > > -}
> > > -
> > >  static struct axi_dmac_sg *axi_dmac_fill_linear_sg(struct axi_dmac_chan *chan,
> > >  	enum dma_transfer_direction direction, dma_addr_t addr,
> > >  	unsigned int num_periods, unsigned int period_len,
> > > @@ -958,7 +979,10 @@ static void axi_dmac_free_chan_resources(struct dma_chan *c)
> > >
> > >  static void axi_dmac_desc_free(struct virt_dma_desc *vdesc)
> > >  {
> > > -	axi_dmac_free_desc(to_axi_dmac_desc(vdesc));
> > > +	struct axi_dmac_desc *desc = to_axi_dmac_desc(vdesc);
> > > +
> > > +	/* See the comment in axi_dmac_alloc_desc() for the why! */
> > > +	schedule_work(&desc->sched_work);
> > >  }
> > >
> > >  static bool axi_dmac_regmap_rdwr(struct device *dev, unsigned int reg)
> > >
> > > --
> > > 2.53.0
> > >

