Return-Path: <dmaengine+bounces-12055-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mSYFC0TDS2p+ZwEAu9opvQ
	(envelope-from <dmaengine+bounces-12055-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 17:01:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86110712529
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 17:01:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=Qk+55oYm;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12055-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12055-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAF0D3087210
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 13:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559C440A938;
	Mon,  6 Jul 2026 13:19:57 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020101.outbound.protection.outlook.com [52.101.228.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283A3A6F1A;
	Mon,  6 Jul 2026 13:19:54 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343997; cv=fail; b=mIvNWN9T9Gwj/G/6X7CpO7nC5CxHu6Fh5QKl+2FaoxTDNrWYU93aigDY1Vn9Yn5oUTNhcqUrRIldL0Af6T5+oSBOl99bUdNedFWB0IgOu6pu05M9mXMYXrjar10dwCmhnv1U7r5FUr6VM6ygEDT68ly/Q0AhCyvfTDB3mjwHok4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343997; c=relaxed/simple;
	bh=DXrvZlaqkJckN5y65dRIConnOryAKVhZrD4NGN/qDNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j9Y+tUL7JbEXL9czyxcSNVhE4UyqOLFNA9bA2HPGVfAtSI55FVHC1E2G6DyVvcM5/28QO+9gWxNL8YNjt6y8G//kzco+OlBZ2l5XRJ4y+8fQxz2J3TIeK9fIFpDhNs2Z5AdWTj6Krp8JLUs5Yo3bN8o1chN7jSx6WxQjtVZzx4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Qk+55oYm; arc=fail smtp.client-ip=52.101.228.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ay0BQgpLTuX5TuvyTSm7UTjN4Z7F7sE4XKxJoy8ef7P8b/fqFIhgAXYepOLMm6GVIiDKJVVbQ0EgN9UJoYHsKkoy6l2KCwSs0Tfmb32C5xX2Qfxp1sfEFWus49i5rPnc1iojsOBqLOF1s+SXmmJ5YOPRQq5vNXAL4v3Aw/lhX/MBb0jhmDKlxBASJfMoCc/bkQryvxuHLvXluaKWTFqFqf7hlGDmyKvLqIY/gmsVWXOsq/UxVQmrF6bd9gjKthOetUIGvd+XzqV09UApbwZT+qwRn7vrXYybelYVLaboCVOwFln5KydinT0mj3RQ5YGDupf9h+UZsaIkXrP4lsNdmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7sazNm7C2zyOc3Wuy46NRQx8We5+uqQqnhd5/yZCAA=;
 b=Nw0q22l641FcRRyryqIumNjU5VOnmWy7ViVxW1UvWJ1bnLQiIbBxDyiuMyjESIIcsO9AY6rXqVgGTz9bpComdJu/0GZEnWDasp0+wNTK5DFEpItRV4VIf0wZOKHPdh8BC+5U4E2XJRmweFIzgwP0/0IYdbLV2OYFD61FDywyuHSlh5TFPvHHEcaAarrfTKIqOWt05whALRBxvU31EAuOciAVaWfbvNF5sjc1gEHx5QFTua+oXS60uvwKhYDebCCbSNOl/gAKkQwTAtOcEkV2Gx9EaVkso/HI/ildN5jQ/rC6AikAjiDCAH9/kJ3nCJQrHsU4P9VOSxKBiqeJNYTEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7sazNm7C2zyOc3Wuy46NRQx8We5+uqQqnhd5/yZCAA=;
 b=Qk+55oYm9XeC+NN5k0TSLq8ijDlDTc/nn2ADSrV8MFIDfwcAKYpJx4tucgP3Mogrntn8845dsrWilet3Ja9fZFe6g9wwNlqu1IDJrF4MKwxx0F6dUO6enkhsO6GWLbKtg/4jIrseZDwGW93MMWj1BpMT2Cb90WXZStuF20iu0nA=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSCP286MB5902.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3e7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 13:19:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Mon, 6 Jul 2026
 13:19:51 +0000
Date: Mon, 6 Jul 2026 22:19:50 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] dmaengine: dw-edma: Support dynamic LL appends
Message-ID: <lsyb7meljjocweaphebglva5pvp2etjcvzsqvpwr6wuhjov4rb@oqioetxsozbr>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <tau5svk3bcatzeapqeb6mun7dxi4ifk56g5ltkk366ljozjzit@vepneiac3f26>
 <ajlEGS99fQT5rGkf@ryzen>
 <rf22kgt3tyradxuxg6c7nifas6olde7jdslkavf3qbbgdb2qlb@fl4wgcrrihcx>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rf22kgt3tyradxuxg6c7nifas6olde7jdslkavf3qbbgdb2qlb@fl4wgcrrihcx>
X-ClientProxiedBy: TY4P286CA0011.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:26d::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSCP286MB5902:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a84d2bb-9619-4bee-5224-08dedb614311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|10070799003|376014|18002099003|22082099003|56012099006|4143699003|27256017;
X-Microsoft-Antispam-Message-Info:
	nViN4eSNaZusZvIudT1nqF53EZ7jZyjUCmEJ0EesrSz9ef9tHweMEu0qXCx4xnfk6s4lwo7ORvlGDit858ynFLwoczou5MAD5//kxt3YKa1zD27J5w3FEqmm2uBloWdxAr+sf/ueRHRBGgtPcCbQNX2EwdSGF5appw1Sh3N34G/BA8s+fKNaaFf6iozCqjNyyvyECqeU8vdg3h8CJaFj1CVvCrXzgt3rg+1Iev612pYn39ceUpyAV2SZmW3FjQnvXHH97JagM/mt9FPIM9ePhnq/FwBIe+eSwotKXoa8NcP9xF6358jHsaMtjYwIQAuy0dgJIXX1T6aeeVEl+niYM87f4yyUE/iSxnLyX3W1NqQ0jF88zS9sJDW2gMOCcJsyYv+JZjbNTFtT7+pmpjKSMNBo7KQjzMAucM+3ld+wSynP8p6af1DfkS9Ky7DCjgFRNJoyacq0fmocUXfPT/118u1o9f/kg8Rtj3FliJCj7JvnDM58LYxLhL8dV/TLHGedwVaPXZranzssEdVAUGTuGrWP9elIoK/KbKUnOSdH7/jJnEEUY2UOspxudnoo2FVm8qXBgSQlo9ih2ELOSZZ9iLs3PuYO1TzlvkssOU+ZfvSUnLeXKSEATzk3+un+E8bUoAn5t+ok8Au2G6xlc2tBF0YCsAvQXpvXfrXFEpBhw8nCAuSVP3aFMliNzKCB/0AjvxyXPbLlBsklSwMXtQOrMxTAwpvFqbMtZ8J2g66vxSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(18002099003)(22082099003)(56012099006)(4143699003)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDVDRmQyYnhEbkNudXlGRFFLV3RtOEVSbklITUdIZU1mZmwyNkUyUStCOHNO?=
 =?utf-8?B?WFhMclR6aEZEeUxYOSs4aCtDRmFMbzUzVXorN2w4MXh5dVFiQ0FFTk5KQUxF?=
 =?utf-8?B?QWFsbU5mdm5XYWNmb3RwNExlSVlRRWl3NjBGZ2RzY2VhZ1phWmpOWFFNRkpa?=
 =?utf-8?B?QWxWK2ZJcjBNUThUWWFRV1FxTGR0VDJSNVJRMGVXOGc0U1NiTkNBN1QxNW44?=
 =?utf-8?B?a3JZQndYa2k5NHJ1KzRjbWd5WmwvYnFsZlpJYkxsK2lCdnUvemwzTmZWdU0y?=
 =?utf-8?B?TWhwbVcyNitJaThvdG1JQk5JRlp0bnIrOVFDeFdiZVZXaWlJODJHQWJINk1a?=
 =?utf-8?B?dU5IendjMXhnNGVTWG9HcE56VDlFc0NpanRFTWJDakpTOE84bjRSM2crQ2Z6?=
 =?utf-8?B?Nlg0VVhIRmlVQjREVExUaXZnT2pqa0Z6YjJNMXNlekRZVE1abzR2MUFqZUtB?=
 =?utf-8?B?T0syMTAxeHFQQ20wMFl3am1Ud0tCU3Q5ZEVBRHVGaTB0ZEg1UFFCNkxwcjcz?=
 =?utf-8?B?a1kzS2FtWit4R1hMdXBjM1llN2pVYU5hS1RDemQ5YTVlVHc1WnJ4RFFjQ0Qr?=
 =?utf-8?B?TEZrSEhlYlVJcU8ycTZXRVZsSzZUemdFRU05K3JkM0YwbkxQWnV4WGM5cWdX?=
 =?utf-8?B?bTNCaFRrbm5ZcVdhQkpoMEY2ek52dVN1MExrWGtKSWtyUVg5MlBHb0hZajdP?=
 =?utf-8?B?M3o5UmxGV1BBVGFReWFRZGtLRmdKeUNDT2N5TUJzNUM3NE9SVVBiTmZPUllk?=
 =?utf-8?B?WGwyYmRJOEdUVVVMYyswYWJaclZpakI4WTlwS3lWUTVVRHF2RnE5VFZRV0ta?=
 =?utf-8?B?VERNNkpuSWdnTC9ad0xzeE1jclJXVkJmenlpN0U5SGQ3a2srNTUwL1hEcndx?=
 =?utf-8?B?UVFBM3EyekNxQ3dkdUllM05KcmMxSk9JOFZBUEV1QzROVktWV0V0ckdWNTNm?=
 =?utf-8?B?eXlKaEpySlQyM0Y4OUFleDFGUlhWTFFib2tuTE8xZnkvdWJjeFN2emN4c0xH?=
 =?utf-8?B?eTJUMVVNc3lTbmhBSHIvUjdXRENVc2ZJL3JNY2xhZlhOMTRtbVpEQXVlTnBD?=
 =?utf-8?B?ekhxdkFnY0hQZ0ltQmhYZ1pTWG1DeTZiRnh1SDM3Tm4zRGVrd2dtaHkyeWRt?=
 =?utf-8?B?cjg3NU5CV1ljUVd6SWNlaUUrZUJMa016MlJoWFZiQ2t6OEE2K3QyM0R2YVZG?=
 =?utf-8?B?YVdSOTdaNVA5N2dSbDY4ZGFpSVRGK1dkZTVqcVRnZG9qM0Y2QU8rWHdsQjZl?=
 =?utf-8?B?ZXpoZjI4YzROc2ZKZUxnUUp5SnluQmRYY0l5QjVFK2xMTFNvTzhBMlZRTEJw?=
 =?utf-8?B?REMyZlRBU1VmWlRPL2pVYjVMWFdoQ3JJd09qMXNIUWgxYVVtMEYyT2tQdTNM?=
 =?utf-8?B?Y1lLdG1UZnNLNkMzRm9ibGxvUk5CNmxZUStsdnJOdGVsQlpjZjRCNDZlL2Ux?=
 =?utf-8?B?OE5IQW5UcDlNT1Z0Ti9tWHBnUDIrR295T3hCeCtFS2FIVWtjUFpvN0dSdFg1?=
 =?utf-8?B?WXRnR3FzWjRxVk83SWNDc2U1UmN1Z1YwUURNTjdIT3ZINzc3bllCSHQ1TkJs?=
 =?utf-8?B?SlhTTHd1dzh2V3FXVjQyMTlOZFI3T1VWdnB2TFo3WTlCK01DejZueXBNakdw?=
 =?utf-8?B?Z0lJdjRwY1ZyWXlFU015bHg2dEhNZURGVVdSTzM0UWVFNTcyUFllU0E2ODBY?=
 =?utf-8?B?b2JoUzkxMlpIYlBDWVYzOS9ZKzJXTjgzZFNQNEtEWVJwcmxaUlptYk9pUmtG?=
 =?utf-8?B?UEFIVTUvNnBFL3cxdTlzdU05cmRkM1l4QzhENTRqQVJoVlRWOEp4a1psZ01h?=
 =?utf-8?B?TTlLVFc2UVMza0M4aWZqZXd4Qmp6aWZxSkFHYmNOem40MkJXVTZFdXJaT2ww?=
 =?utf-8?B?QTVYZ1dSKzBDb0lPekhvK09hYU9LaE50cmNoUW1oVENkMjZid2pQZXo5TVho?=
 =?utf-8?B?UzNrSUNvQ3pna05jUWV2MUZ6bnVDWmhyZ0FMSmZtajBFcmdlK0k0ZE1NRGJ2?=
 =?utf-8?B?NFVyL3NOUVhkL1ZGODNvY0Z4WEVxYVhjYklYaGpZaXNFYllUdENJK09PdDZY?=
 =?utf-8?B?UC9TTVVPWUhjWmhZV3RXMzNWSmkvdFMvQytWWkExRjB3ZVdYZmZXN0NuWlRK?=
 =?utf-8?B?RCt5aVl5R2JrVEdSblpFbjA4dlorYVJmRjdXV1hYYTlHcW00NkVRdnl5QndV?=
 =?utf-8?B?OEQ3MUd1a3N4THJrSk9WcWFkNGgxaE5rYUdoVDlKODdmdFRYY3daRlR4R1h5?=
 =?utf-8?B?OHUrbE5TcUJkVlcwcDU5VFJPODA1Rmk0VEZEK1B3QU81ZFFHcEJRSVZTWlpm?=
 =?utf-8?B?bzhROE54aGNOd0VqU1QyYmNFV1JHQ2tEeGs1NGhOcElWcHp1Sjh1NGQxZHFa?=
 =?utf-8?Q?B3PRnOaJjbkLFr5FgOViVnNA3O8lu+ITTUEIb?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84d2bb-9619-4bee-5224-08dedb614311
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:19:51.8103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig4mtHO+uFr0dlHrULnKLlljoe+hFv6wJKFlm3LSMroLFbgpEFXQcwI6nRlQzliOdEYH2Bihl9CmHhWhOBfv3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB5902
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-12055-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:cassel@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oqioetxsozbr:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86110712529

On Tue, Jun 30, 2026 at 01:38:32PM +0200, Manivannan Sadhasivam wrote:
> On Mon, Jun 22, 2026 at 04:18:01PM +0200, Niklas Cassel wrote:
> > On Mon, Jun 22, 2026 at 04:38:49PM +0900, Koichiro Den wrote:
> > > On Tue, Jun 16, 2026 at 12:40:54AM +0900, Koichiro Den wrote:
> > > 
> > > Hi Frank, Niklas, all,
> > > 
> > > I am looking for a good way to stress PCIe controller DMA engines, such as
> > > eDMA/HDMA, and measure their upper-bound throughput.
> > > 
> > > nvmet_pci_epf is useful since it is a real in-tree consumer, but it is not a
> > > very direct benchmark for the DMA engine itself. So I wonder if
> > > pci_endpoint_test would be a reasonable place to add an opt-in DMA performance
> > > mode.
> > > 
> 
> I think including DMA performance tests to pci-epf-test would overload it.
> pci-epf-test already provides the bare minimum read/write benchmark, which I
> feel is sufficient enough.

Understood, thank you for sharing your thoughts.

> 
> > > One possible option I have in mind is:
> > > 
> > >   - a new fixture, pci_ep_dma_perf
> > >   - opt-in execution, for example with PCITEST_PERF=1 environment variable
> > >   - a few variants such as single and sg, possibly with a few knobs:
> > >      - PCITEST_PERF_NUM_WORKERS, to use multiple EP-side workers
> > >      - PCITEST_PERF_NUM_CHANS, to use multiple DMA channels
> > >      - perhaps other knobs for SG entry size, number of entries, etc.
> > >   - the new tests: READ_PERF_TEST and WRITE_PERF_TEST
> > > 
> > > For the other possible places I could think of, this still seems to fit best in
> > > pci_endpoint_test. For example, extending dmatest does not seem to fit well
> > > because this needs both EP and RC side setup. A separate kselftest also feels
> > > like it would duplicate a lot of pci_endpoint_test code. That said, I might be
> > > missing something.
> > > 
> > > What do you think? Any thoughts or suggestions would be much appreciated.
> > 
> > There are two existing (out-of-tree) tests for eDMA that I know of:
> > 
> > 1)
> > https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
> > 
> > But as you can see, the comment was to use dmatest instead.
> > AFAICT, dmatest currently only supports DMA_MEMCPY, which, by hardware design,
> > cannot be supported by DWC eDMA HW (since it only allows remote to local, or
> > local to remote, and remote has to be a PCI address, while local is local
> > physical address).
> > 
> > Perhaps it is possible to add DMA_SLAVE support to dmatest.
> > 
> 
> Since Vinod is not in favor of it, you can also think about adding eDMA/HDMA
> specific kselftests. It makes lot of sense to write a  standalone test since
> we can configure this IP from both host and endpoint side.

Alright, I'll consider eDMA/HDMA-specific kselftests once the need becomes
clearer.

Mani, Vinod, thank you for the comments.

Best regards,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

