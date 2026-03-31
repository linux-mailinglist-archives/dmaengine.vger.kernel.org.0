Return-Path: <dmaengine+bounces-9782-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG1WBLbay2k2MAYAu9opvQ
	(envelope-from <dmaengine+bounces-9782-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:31:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F536AFE1
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E044305116B
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 14:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487DE375ABD;
	Tue, 31 Mar 2026 14:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h1WERkh+"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011014.outbound.protection.outlook.com [52.101.70.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BF93FADEC
	for <dmaengine@vger.kernel.org>; Tue, 31 Mar 2026 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967021; cv=fail; b=m/aqE6VpWYaWUzuTlbfp5cYQjDFpNWq6ezAK+s/mbH6L0hUJFM9KCyZvK9SSBXTjnD+7YeauQFnetbkGwHcyfv/ywRYLb3kOP9p08TNWcxXsSW1uN/mRzQCn69101G0IQYX0XtanZPSxjDuatGlZG93mAQGz5CKSG9jOCqyie2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967021; c=relaxed/simple;
	bh=JBKmGKih0V8XEqCfFw7yRGVw8/aSImIhrZOVZtYN2cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iQuoHAbmondOk+UY7YkeY5gCey4oXiWkrMFJ40WCcvvgTraAOPy0bm5jI1RTjfsMcgnARXI4Lyst0pzKB2yS3jLCyp8xoWHa9kFAr9fhcWMeGjPfTvLlIHAxYpiWiF0cAE8Ptvh39ZyOJCGh9l0C6geGWqahYWA9j7+PeEHeuog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h1WERkh+; arc=fail smtp.client-ip=52.101.70.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrk7y5iCDHiLBrEGJAjEtGySDnI4Q3pBBsl7kAKRY7UGa/vWe9Tu9XFwSc3DkV0p8W/EXa5qjk+TUNXypTGDnls25kIcPfwFs9XAB1gysCpsWUwzyOx+udUoYnIDdDyPhcHppXcRPJZWKp4NhP5iUAokn1yV8PDd7wL3ZO5BjDC6ksElRWr4gkGg8rkEz8N/C8mqUjIWzkOjZWN8z1sTnVyt3D9jjMS/pbJyzHg+jLmBQuI9rkpG5zlcKwPSi8Lo8/qf7N3Qm/EraNFDF9vRNtuF+nV1YZ44sRBfI68sUQ5XBuJGYFELWGQpInewYfp/5KQ51lrdN7ghXESEKvrCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=suaSWS9XsPNIPe8eSpqd06lluFNvuTItixHcVVDJhak=;
 b=oaAwBWF0ArTM7Kpfa9yg+S4PCEyRWPAcWBAszyyKsMU104wWfC69xpmqX6ZWR6CGnHP6pFfZASL8KCMWeLLruJqh5V1ztj5h0+5sEHLpuomgs6DU7FPhSekMXiWy3Lx2lb9vVH4mpTCJm1DN6WVP/LNKNnr5q729QiOaxdy7w7riUm7Ez4ttzC/FLdl7ByVgPrAE25aemojk3ngcM5HRvggz3AK3gffPb4yO5AzCl5XN938h1JypBHq/0dmX4xvSy4ZQxTkVpMDCZBoHay1NThf5Q//2AxpDiPL/U13sbfhBK0aW6FasEmzH2qbjY5ozDqOFBhqbKv8NHWgd9Zrcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suaSWS9XsPNIPe8eSpqd06lluFNvuTItixHcVVDJhak=;
 b=h1WERkh+6O4MaF+DFGuoGzIi0MRVJ7h/Fr3U704QshGfwhWC8Am0t3Zwz/sQZ5lhtbdixmK6j+BiT8XGT/+MbXKQEcsTKt0MrG1svdtJE6hs/VzO7+EJ4/krH4hRnWRMViq17oFoMDRiCuJBno+eEhhT5EdR9PGVUPK5kugzioz5mLIVR6Uxe6mqqbBHMRPOx8rz0eeJjeVvGShJmleDBB6hzkyKs4kNSHUCwlz023PimpWu9RCZlr69h+GbwQ6G8vBP3wZLSPk4nzSEfLzlFrZDFotb0FA+iPALHH7tKKZ0ZHDBioFE/2iRUcbbvKELrd/+oA7cr1REhUVpveY9fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI2PR04MB10190.eurprd04.prod.outlook.com (2603:10a6:800:228::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 14:23:36 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 14:23:36 +0000
Date: Tue, 31 Mar 2026 10:23:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: David CARLIER <devnexen@gmail.com>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Yingkun Meng <mengyingkun@loongson.cn>, dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: loongson: loongson2-apb: fix broken bus width
 validation in ls2x_dmac_detect_burst()
Message-ID: <acvY4AvndkRhRZue@lizhi-Precision-Tower-5810>
References: <20260318164803.14351-1-devnexen@gmail.com>
 <acqkrL7CYbr0WmHf@lizhi-Precision-Tower-5810>
 <CA+XhMqyn_jTgQMpMT9n958qm=1m1bFG+hNjCeqm6eaGqRwU7+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+XhMqyn_jTgQMpMT9n958qm=1m1bFG+hNjCeqm6eaGqRwU7+A@mail.gmail.com>
X-ClientProxiedBy: SA1PR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::12) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI2PR04MB10190:EE_
X-MS-Office365-Filtering-Correlation-Id: 178f209d-3278-4bf0-b704-08de8f311722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uUiileWRw1e9F3IB8fLryUKs/kYGKSCxI4NSRJPsUF88tSkhzrrTv2jYpMA0g19zGr850fw/80omjg+vYhA5RzJpkcm9p3bYN06PiefVVopthMnCtFznhqgd4U18OqMyouxd/304it3bhnwEokPhboYRar3oK28u2WE3FvAKUiwlLJlRFzBImN3jTzubFPeyVAEtBaMm307nHV+s3BFcvxoyK1YaN+0qx8vFu/hNZoj3jVhp/vGuH1hHubC4sy7AY7+Qe/rCGEiEOsoRgAi+LGqnlRKvKemNXpeLgHVLqkUR25Whzt1YK2QqGPfK94WFzlEDuxfe5VNlUSkg6kwRE1GQGfiVonvkLiQGwfHaS1ueXlV/Zyes7NGp/PQx89qmHOFJEyGhl+xItc/9QfQ6nnXi+za0NHEVFyV97J0vEzxOuWcNYFlS9bkXKDDX+iT1WV9IFkejw9AyX96A8n9k8i1UGv2/41JAu3r0l5g4A8uyeiVNSloYYbDiUB5UGKcYJOIk+JDqay1ke+MWjGD5KdA65ZJYnlr0dIBL+IZMWwhT5PruoSp0dsulkWg0MmZLr90CFxYX7FMkNoUV0nIoXqbAv9I//BNNwYqx2TpVoWIhENDCWNQiVKgYZPQoEi3ckFbbHGdEBfmlfLfTr1FmBYefFlFr9FhgjqipmHHT52yhZMjvaWe61zZkuI4AOhJX2jKieWe/28HDFOEU4VQcR2rhq2As5Tjj0sRrDcBO4c1oltMgbMbfZWJcV3+mGLzCiiYwPspEEtdM8TuVQjSWzWZFknbqVhz3Kj3NrUQgjaU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VER4UUdRSGhveG5BNGpZNkxkV1R4YXRlWVE0SG1xbXU1dXRWYXRBSmdBbHlW?=
 =?utf-8?B?Y2x5NXRiT2pMSG93V1BzT2JybTRqYmNJcTlNcTZVR1lmVlhpRmVCSDJLanJs?=
 =?utf-8?B?dTdNZ3VsajRmM1dVU3QxUkttRThBU3lMY1A3eERMSTFKbkVJbnhyMTdFM0sv?=
 =?utf-8?B?bkdrSXZCRGtWZ0pxOE5qSU0ySFRWUVZwRHZtcmFIVUtUQTdxVCtuS1E3aGVC?=
 =?utf-8?B?WlNZc1p3VmcrZTFyYWRka0hBVFZNbVNaSlRya0Q5QWttdlVJY1R1MWZFTSsw?=
 =?utf-8?B?bDlub3oyOEhwbXRRUDlPTVNwdzdwbG14Y2NsaUx2UTZFTUI1clFWLzhFQW9t?=
 =?utf-8?B?YTV2OHhXNkdGTHJscTcvUnUvYWVtblhmVWVlWFg1ek95TEQxeW9rQlFXVGc1?=
 =?utf-8?B?T2plMWlGaEtXbHpRSnlwMUxiN05QaHpFdW5iM1hTYXY0bVZaWERnYUxMSW1u?=
 =?utf-8?B?SURhVWhXVTJGWlVtVE9TVzVxQTNoV1ZjUWI5dUlCOHhpcGZQSDBURmphUWN2?=
 =?utf-8?B?Y1BYc1BodzFNTVJaRmJqdS9YbzVkeFV2d2E1ODNnWTFqYnNWNyt5UkpUcTVI?=
 =?utf-8?B?LzhDTUJHQ2I5aS9ja3JHVmV5R05GZDBoTUc0RC9Wb3RRRmJVZURzKzg2SGkv?=
 =?utf-8?B?QlBZd2llcUk5bkJEQktrNFBrdTBaKy92YlZaeEFRVVNaNFJNek5RYmJhWW5M?=
 =?utf-8?B?TEx4RGJac0U3blFMOWJrS3FFRnFIVlF0VlBYTC9aQi8wQ1c4b0R3Q0oySU8y?=
 =?utf-8?B?NW4zZTlqd2dvbU1WdE1DWmF2bnJzUmlKUlU0dHJkb0FqYm5vekt0YjRJK254?=
 =?utf-8?B?RW8rTGhWNWdKT21obStPb0gza0VQRElzZWNDVjNjY0xQQklqVzhCdVI0WjBW?=
 =?utf-8?B?QThVVDM4eWU4a09IakRkN08vSkZaVGU3MEUvNG1VL2F4K3o4Nyt1SXBYQzhU?=
 =?utf-8?B?MUM3eFFDRnZBMUtMWStPY3ZmWHgzcU9yWFVPcHN2K29TckRGdXFadnBhVEFQ?=
 =?utf-8?B?UWlpMmRyU2RHWXlmd0RJVVdhQjVvRko2OHEvUXFqQUw1Q0FTVlZMbjRVb2Yv?=
 =?utf-8?B?Q2gzQ3R4T3R4WGQ0c2xCTWhSakt3MzJCOW1udlhwYlVBckloMzY2cmllYk9Q?=
 =?utf-8?B?bWtjT3hyTmltSzE0Rnp4eHVTL2FIckplZVFQUU5vWG9BRzV0cjRWbTRIa3pY?=
 =?utf-8?B?bVpBc0IrMDhuTzd1ZjdSMG96Q1IwY2JRMy9SQnFXTlRrSFpFNFVmaWpQdHhI?=
 =?utf-8?B?R1duS2xWRDlLNG0yeVp4cUtRRDIzZkFSSnJXenlNOXFXc1dVU24xUHkyMTNk?=
 =?utf-8?B?SGRYVW5ocmYwZ0dBN3BYZXJJUkJHNTVVaUFRNnllTllZUWVNWDQ0dDJVTEpX?=
 =?utf-8?B?bmM1ZDc4VHZrY1VuUzBCYjdibWZSMGdlRWN0WEFaQjI1cnkzNlJZeDVvZk11?=
 =?utf-8?B?cnI0SGo4RE55UGYrZmdyUzYyZGd4YStUcG9pQ0tzQ2hVT09YcS9iWXFPcFM1?=
 =?utf-8?B?cjdjYnp3UTJvbndsaGVTSFBRVzB3NldHUjZUWWJLUXpaWTRLN1FDN28xdGdh?=
 =?utf-8?B?VDdTS2VLTHd6NC9jOVFoTHcxRGVzN0czUXBVOU9QcjRUemZ0ZDZvZFpLSGdm?=
 =?utf-8?B?bTBxc0pxWmw1SFpYaTdsdHZtUWxGZUV1aGtYUDQ3UDlWY2VtNjF3SGxDa1VL?=
 =?utf-8?B?NFczOEZseW9wRmx6ZjRublZRdmlaTVhxVlJmbGFDOEZmME5RNEpDV29FeCs3?=
 =?utf-8?B?YklyTlRLaVlvUjhscnJOZUpQenhrd0xZMTdEZkdNVmpoYnpCRHZLdWlvSEND?=
 =?utf-8?B?N29QT1M4QndYZmR5QWlCTlBWais5WDhXdEd1OGVEWXdxRE83MkFYQktydkh2?=
 =?utf-8?B?YnhHWUgrTEhXZWxMdEV2Q08vZDhLZ0JXaVkrNGxuMUVWUE8rN2FCT2tnQ2Yw?=
 =?utf-8?B?ZE9rS2lvNnVLMmlHSng0OVdwUUxHaG1Pd2FNdm5wTCtQQXlkN1VIOUxoMU5y?=
 =?utf-8?B?NlRaamhDbnJRWEZSUnlLNTZVbFpUZm9JdWxWWWNKZzdEaEMyWklHeVlRd1lL?=
 =?utf-8?B?dnNJbFRRL3RoQ01HRFAvaGkzei9WRjZGNXdGbjFpR2UwS2EwMkk5RjZjOVF4?=
 =?utf-8?B?ejhVYjVIblo3UXZNV3J1K0Z6RDdmcnpOM00xYXZMa3Fhb0VoeURrdUZYTDJI?=
 =?utf-8?B?SHJDWjVYcEd4b095TjVOSW1EbGh2SW40R0JibE5kY2cwc2xMNjliNTE1MzBu?=
 =?utf-8?B?VGFZUThVMGQ3VmpUSXBIZUlWUzhwclArUUJaR21GcUcyY2xtSXZra3diazRQ?=
 =?utf-8?Q?0pe9GK85Tq6Decp7pv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178f209d-3278-4bf0-b704-08de8f311722
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:23:36.1891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GlvQYGJNIFWOQ3w49CIEPzU3CFpTPsihFSptLc0K1mpCX6CifZcLxI2zV7vFqxtgVBh1/D4BI5IzdVaU/JP5Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10190
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9782-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B8F536AFE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 05:57:44PM +0100, David CARLIER wrote:
> Hi,
>
> On Mon, 30 Mar 2026 at 17:28, Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Wed, Mar 18, 2026 at 04:48:03PM +0000, David Carlier wrote:
> > > The bus width validation check in ls2x_dmac_detect_burst() compares raw
> > > enum dma_slave_buswidth values (e.g. 4, 8) directly against
> > > LDMA_SLAVE_BUSWIDTHS, which is a BIT()-encoded bitmask
> > > (BIT(4) | BIT(8) = 0x110). Since 4 & 0x110 == 0 and 8 & 0x110 == 0,
> > > the condition is always false for valid bus widths, making the
> > > validation dead code.
> > >
> > > Additionally, the logic was inverted: it rejected configurations where
> > > both widths matched valid values, rather than rejecting when neither
> > > width is supported.
> > >
> > > Fix by wrapping the enum values with BIT() before masking (matching the
> > > pattern used in sun6i-dma.c) and inverting the logic to reject when
> > > neither width is supported by the hardware.
> > >
> > > Fixes: 71e7d3cb6e55 ("dmaengine: ls2x-apb: New driver for the Loongson LS2X APB DMA controller")
> > > Signed-off-by: David Carlier <devnexen@gmail.com>
> > > ---
> > >  drivers/dma/loongson/loongson2-apb-dma.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> > > index aceb069e71fc..102c01f993ef 100644
> > > --- a/drivers/dma/loongson/loongson2-apb-dma.c
> > > +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> > > @@ -220,8 +220,8 @@ static size_t ls2x_dmac_detect_burst(struct ls2x_dma_chan *lchan)
> > >       u32 maxburst, buswidth;
> > >
> > >       /* Reject definitely invalid configurations */
> > > -     if ((lchan->sconfig.src_addr_width & LDMA_SLAVE_BUSWIDTHS) &&
> > > -         (lchan->sconfig.dst_addr_width & LDMA_SLAVE_BUSWIDTHS))
> > > +     if (!(BIT(lchan->sconfig.src_addr_width) & LDMA_SLAVE_BUSWIDTHS) &&
> > > +         !(BIT(lchan->sconfig.dst_addr_width) & LDMA_SLAVE_BUSWIDTHS))
> >
> > src_addr_width is enum dma_slave_buswidth, which allow
> > DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> >
> > BIT(128) will overflow.
>
> Thanks for the review Frank. You're right that BIT() would overflow
> for DMA_SLAVE_BUSWIDTH_128_BYTES. While this driver only supports
> 4-byte and 8-byte widths
>   today, relying on BIT() for buswidth validation is fragile. I'll
> send a v2 that avoids BIT() altogether — would a direct comparison
> against the supported widths work
>   for you, or do you have a preferred pattern in mind?

I think LDMA_SLAVE_BUSWIDTHS use enum dma_slave_buswidth OR together.

Frank

>
> >
> > Frank
> >
> > >               return 0;
> > >
> > >       if (lchan->sconfig.direction == DMA_MEM_TO_DEV) {
> > > --
> > > 2.53.0
> > >

