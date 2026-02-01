Return-Path: <dmaengine+bounces-8643-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mbc4NEa7fmmSdQIAu9opvQ
	(envelope-from <dmaengine+bounces-8643-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 03:32:38 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBE4C4AA7
	for <lists+dmaengine@lfdr.de>; Sun, 01 Feb 2026 03:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEC82300334C
	for <lists+dmaengine@lfdr.de>; Sun,  1 Feb 2026 02:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB1B25B2F4;
	Sun,  1 Feb 2026 02:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="E/RhbMZf"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021117.outbound.protection.outlook.com [40.107.74.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB3C2AD00;
	Sun,  1 Feb 2026 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769913150; cv=fail; b=BTwgZ2ROgO6wGQDZWBNJn/AEyk1j2AjcupQz3TFsk60X2Npu4+XXtr0R70JsO/6epMy8BIjl1XjAyFfAqNWPSwzZYjlET6mKmhRpLdBSh1S4TBKPhJWZTx+CxMECpt9KX3ZyBLjt7rfNniDhV/rh6iRAdfr0Zko1ls4EeterEOc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769913150; c=relaxed/simple;
	bh=/K9gMVpx2D3bfjrUXfbkKYnKNfqrW1K106vNxOjuz+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QiW+lPS2FUdwxVSxngNRaRjsgaY0u2avWYF5FAL+XSgqYffYGpVHAlaf/f8C6c283CihCDvHjP/VBEyFwxeRC1EsIXLawtXjnCB0JqA6phRaUsnXOQLXrIy3kOo5y36NU7YV3WKl5aPWb1XrZzHcMcEVILSvG1JhHSswiDjECdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=E/RhbMZf; arc=fail smtp.client-ip=40.107.74.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUkdzQNf9oSBE3LBF/1Pq9GV5JuXUbX9h0WLe8xzJsv93VXhBnbl4JUAT7prog4sUu8f6XMS2KxW81nc006apmy+IFP74/O5dWv8/SSeotdMaiY8MI4HbtZ6E3mcUcvVNrg+5HhI9zqgXf5NQ2Sqj4XJQxS/ONyNHM3iW+pHlw9phunA5Xi6+6ZV8+eRuLXi3KO+i/fB0hCux8Vguha2kWnV4hfR3VRK6Dj7UXoJloc+IVnAqMjQnOjo9fabbK20TngvnM33IgwUWASrJKhLdAnxObBRqaTXaCsZvrSowEDDU1ITizTi1lHlSVkqgn7R7x2DC/EubPUncirMrvIKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ggrj8BosZR3rauq4p9WcH0/2ZR8KIa0PzXb2UveLK+M=;
 b=ZVliumPBt5jv7rgeCF6GDFeL7ViSPEegp5kDpOpZkyuYidX9p2lSWfcJuaUekJ5WD91gBjnhPwq59B9xpLm+BkcZiLGhC6EQS2y/fYjWJrpwDrJl/WqNzypKtX1nJCwQpbLut1ewtkCq9Elzxmlzm1KMSZnAPNcYrlGviIjFw8Z4gAFZIMHJWkVPlEYUI6J4sXQnRllIekEo+Z57ZQw1pc+TW+LV9ct9oTm4OxaDPKeDaR75NydTdU8HM69njq/L701X45ZHyD4wgjjFfjJq74bRryh7CwDXnDsRzzKHquzfk6O4LjgXqhuycy7YY0LpvtClg1hve8S/1gyELZjFEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggrj8BosZR3rauq4p9WcH0/2ZR8KIa0PzXb2UveLK+M=;
 b=E/RhbMZf4pZYgfqKHuz/cznnub9coYrDBzswpg4V/b57oZw1OLq4QGFBhJnUdg5XTllynLWJWLccLZ1nBkI3kM8ApdWz0fLNsRLNWKZ6r9JyVuxBYueGXaEdOrTlfXdnTjr+Rai+ZPrPQeaItpoO7m5SqAI/8295Eefw04IhlUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYCP286MB2685.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Sun, 1 Feb
 2026 02:32:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Sun, 1 Feb 2026
 02:32:24 +0000
Date: Sun, 1 Feb 2026 11:32:23 +0900
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com
Cc: dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] dmaengine: dw-edma, PCI: dwc: Enable remote use
 of integrated DesignWare eDMA
Message-ID: <h3uhcd426u32lmn4ajjcrclabuptiy3d4lmtdbwhtu5ca2dv2s@co5piltmkhx6>
References: <20260127033420.3460579-1-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127033420.3460579-1-den@valinux.co.jp>
X-ClientProxiedBy: TYCP301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYCP286MB2685:EE_
X-MS-Office365-Filtering-Correlation-Id: da1f7e7c-7ab4-45c2-c16e-08de613a2281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eC9QaVFRY3N4ODU1QWF2NXhaVkJjcVQydU5PU0toSkI1TExzUWU5cGFhWnRj?=
 =?utf-8?B?VFFBRWtVZkRLam4rbFlZNHpVZ2xHeEFDR0c5dy8xM2dYczlMQkNTK2h5a1FZ?=
 =?utf-8?B?MkFWNis4RU8vcEcvWXRTLzk2eXJPMzRTckpING5LWElBQVdUMWwvSEEyMDRM?=
 =?utf-8?B?czJ0OFFBWGNlV3RYSVRXb1U2aGY0NzFrcFV6aERoM2lXancyUDQ5NDZRdDB6?=
 =?utf-8?B?cE8zQWNOTk5FQ003T1hpTTJIY3ZOeVl0YlB4dWw1SkcrNlI3c2h6SGlRVGtF?=
 =?utf-8?B?N1Y0R0k5Ui9BOVVocGN3MUhFMW1qT2Q4dUc2U2hnU1gxUHF0UHNiWS8xeEJ6?=
 =?utf-8?B?ZFRvcEcrV0hEb1VsQ29aSG1RVDRPVDk4U0hmckt0WXZDUm9ZQnFNTEdBbWF1?=
 =?utf-8?B?YU84c1hFSmN4TmdiWDFObTZGZGhqMDRpdzRRSU5WMFBKYjg0dTh4OHI0L29S?=
 =?utf-8?B?cjlpcVlkQ3dJT2YxbjJVWHFMRExLaFUvaVF6dGJ2SEE4ZzZUdW8vZzdrVEZL?=
 =?utf-8?B?YXYxZnNLSExoQ2t0NHY2UmhLaFRXc0VQOVZyazRNM1YzbC9PbWQvdVRORGFC?=
 =?utf-8?B?ZGVQNWVFNnNLM0lTbDVPVWNWanNXbHRIb3VyMk81Vm1oZm81QXMvUWxad1VD?=
 =?utf-8?B?a0NWeURVczhpQ2tuTlVHYTVVdlU0VERpTzVZcGJxTTdpa1Vqdkd5TTh1VVM4?=
 =?utf-8?B?YklnRWFnbVJIL0JIOXRQT09NQjlGUTRWNEUrTFVSLzc2SWRDbG1oUGhYdEt3?=
 =?utf-8?B?M1ZlRW9kWkltOHJCaUJhVG8wQjh6eGxTVTEyR2ZKcFBpa2xYTXhxNmZvZEFH?=
 =?utf-8?B?czZFUWozakhHeTRueFYwbTRMSkxiTGp1TWZmQXRseW4vTTJmTmR2Y2R5VlYv?=
 =?utf-8?B?blNkTG96bzY3c0ZrZzBqS3BHQnRJalhzR3E5bGM4V0hneFhJdWN3NGhlQVJX?=
 =?utf-8?B?RjR3clpveS84ZXVOUWFkVllyTUgzMnZ3Z0xiT3c5NEtvSVNuQzE1M2xaVnhV?=
 =?utf-8?B?blpwYldhdzZUbFUrc0lUZVpNNEx5NkIvUlg5R3RlbE9CZVczQmN0SlFoSmhE?=
 =?utf-8?B?TVp1cEVIcTJJSSs5Vm5INEIwZzRiemRxdU80d1FtNW13Q0g1OU1DVEtCYXRu?=
 =?utf-8?B?Wk40MU9QN25qZmx5TE8wNkkzL1RJbmZ2bm5kRlFhMjY3eEFrMDY4SncrV1J2?=
 =?utf-8?B?WFR2ZHZpanlvR0VwWDMzVUtTdWdzcWtxN3RGYnVlREpCYTdHM3dvM04rNGV3?=
 =?utf-8?B?L1JIejRUV1NBMStYcmUzZ0tNNEtsa1IyU3BIZmZtUkVTYVk4M2NQZnFwZ0pQ?=
 =?utf-8?B?U2hjajNzaENyR1pUVDFyZnRPMnZUTWkrQnJvZCtOdlpxOUEvdUMwYUlUK1lk?=
 =?utf-8?B?Y1NyZXdHNHV0dW9vUGlSQ0FsVWpReWtMa0JDUzJERVk4a2I3QzA4OFlTQmRw?=
 =?utf-8?B?WTNFYjZoVnYzbHVIcVFqRVFzeit1ejZxSksvN0F6ZXRDMnFpVk9tZjhPclBq?=
 =?utf-8?B?WU9QblZyUWlMMHBDZ2ZFTnhiTFl6c21mQ0ZYMU5tMFFuaE13eG5ISFltazZB?=
 =?utf-8?B?NVZaWlU1Y0tjeDJsVVZJRFBtbjhpNWMwcVBLOVREWTl0TnlxREFPZEdwSkM1?=
 =?utf-8?B?VFBadTR2Z09iUnJCUHgxWGxlNXlSZkpjdVZHK0QrOHIvMUtPc1ViTlNiUUJY?=
 =?utf-8?B?RXBscUhmQnAySDVzRm43dFdUVURpTXpuNzJUOGtZcVBCL3JGYXhNeGw4aHFD?=
 =?utf-8?B?eVNVaEpFWldUK1JsWm1XOHFGVlIyR2FqeEdoamYxOWpaTTlFbEpXTlB0V216?=
 =?utf-8?B?U3RuekV6K2pOSmZlRUhjcjM4Um9NQ25rMzgwY3dvWDNtWXIyN0JpQzZjMDR6?=
 =?utf-8?B?YUZXd1FGeWY5SUhsdWdQczRoUWxQWUVoM3pwZzE2SkNpMDJUVHFjb2d0bWJx?=
 =?utf-8?B?WUlNbG5Cbi8ya2RxNkk3WEtJLzdOdnc3SXBLdWE5d1NYRFhnWVF2UHpLRHln?=
 =?utf-8?B?TldzTnJIYnJtQXZhSTRLRmhPVjN0TEx1ZUFaYytzT1FNblowTnNNWkZnSU1V?=
 =?utf-8?B?Y2FwWFpnTzRNWExHSHNzN0pDUlFXa29QSEN0ODh5Snh2WXJtRU42TjlqRWRl?=
 =?utf-8?Q?xhrM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YjM2b2pXYWxMc2J5cGNuVkNRZTZxb29qNGpPdXRpaHFncW9QTEl6SXdad0JX?=
 =?utf-8?B?MkJuYXV6U1BJWm9yZmNSWEFNcGtRR2NUWVg5STZQOXZ5MGo5N2dsVW02MWNy?=
 =?utf-8?B?YVV1T0syVis1RUZGM0FuYWg1MDdNM0ZOYTJ1Z3EvZ2RvUUlERlZKZ0JtcHFT?=
 =?utf-8?B?ZDd5ajZPZ3VMcDZvNE5ia0QrcVpMaWp5YTh5bFdKdXEzQWU3bElZQ3QrNVNJ?=
 =?utf-8?B?aXNacE9wOVdLMjRxZ2R0K295RE1udWlidkJTbW15emFjY1ViNHhmd2pDN3hG?=
 =?utf-8?B?U2xsWnprekgveU9Bc0FsNFlpLzdZZmovdzQxL05OeEkzNjdDMjZ4L0pUUUhD?=
 =?utf-8?B?Vmsrei9QS1hLcUdMR0tVU1FjTkF6Y0JKUXVGZVlIMkdhbHpweUJkZEZPc3BE?=
 =?utf-8?B?UVlRNmdUZmNuY0Z6QVExa0E1RmQ3N0Rnay9xZzhLUEVhckNzbExSR1NIU0Zl?=
 =?utf-8?B?Qkw4c0JjZW1nMHNuSkhncGdiWCtBamF0MXovdkQ0UDJqNkZHb01Ja2xsQ0Zs?=
 =?utf-8?B?QmNIWjBPNGVJZHpPRFdXbXoxREZNZW93bEU3WDBvZWdEUksvaVNVRXhLSElp?=
 =?utf-8?B?UnpYa0hGOXVqdW5UZzNJRXVUOTRQcGpxUk5pcUEyQVN2ek9BRWRCV2l0ZUhV?=
 =?utf-8?B?S3E2anppeWU3UDFNb0hqZXA2NGNWbGVheUtNUEo4VlZZSTUwLzN2cFNnUEhZ?=
 =?utf-8?B?SlhlUDBicHZJOTcvVTJLSm10OWtLaGY3b0ZHSE9vSXJUcEp5ZW5DTHJCZ1JP?=
 =?utf-8?B?Ym42K1dqYnY0WE5XbGlRYzdscW9VcUExcCtsY1o2QjV6NnYxZ29JRXgzemFl?=
 =?utf-8?B?MkpscXliOGxSN2VRM1g4Y1hnclQwRTNEbk5qQllhTmZxMXNFLzVrNVJpbTZO?=
 =?utf-8?B?M282cm9YS0hpem0xNkVEVitMSVJ5VTBGUVVsRjY4ZUxnaUE5Z2tNSTFUdGxh?=
 =?utf-8?B?QkxZSGR2T2w4RTc5ZzU0M016TWVwR2duU1l6eFJSQnJPWmtXMzBTaU42eVJJ?=
 =?utf-8?B?QnFuMkdzVjVEcmRib3MyWEl6ZmNxdnRPSXk2bTdUZ2toZjRwbGdaSHEvcFB3?=
 =?utf-8?B?TkhRdXBRb1k2ZjNPQ2JFbmF5VUFvZi9MeXZlWjhqY3phY01RK1FPWk9BZ3Iz?=
 =?utf-8?B?K002d291cGlkRnc0Y29iWFRaNmd0Q0VkVmdxU0xLMzFxR0xaWmYzcTBHN3BF?=
 =?utf-8?B?UnpuUEZJSUVjRmRScjZQK0JXME10emE1OWFpQnJNdWRyeWxxekNIK3VId1dB?=
 =?utf-8?B?a1VHQThXQ2RZeDFxeHhVNExCWE5yRndtOHN3LzdQYmNXYzZNQ2hkMkx0SDIy?=
 =?utf-8?B?Rnk4blo0c1J5U0VVSWRNUHJYcGJ1Y1luRFg0d1N4cDFxeDFHak5HcG52UzVM?=
 =?utf-8?B?RzUvand4aE5XSnBHWUdKWE1TdjFPL0l6cGR1LzV4blN6ZExnMnRrVFBGZG01?=
 =?utf-8?B?aFl2S0NlTk4ybFA5dk5XUzdBMko3YlI2RjA4Mk5QemVNWVVSR2x5dEY2QlQ3?=
 =?utf-8?B?bjRHYmk4QklKMkVGVWZNVnh2dUpGMkpNQlFTVHhUR0pzSGdoTmVya1ZJd3dG?=
 =?utf-8?B?RFNzdmJyTzkwazlLcjMzam1na2JPeFovZFR1VWNqeHRDc3dRd0pOV2huYlVN?=
 =?utf-8?B?LzliYnhzU2Y3VlBqR2YwZ2oweVJMazc5THozR1o3NFB6VXhpZ2ZtOFJweGYy?=
 =?utf-8?B?M2xzTXhvQVZxWW1IdDB6ZmFNQ25RTFIzeU1CNE9Ea0tpZjBpU24wbEdDMCty?=
 =?utf-8?B?VTdTYzdtMEZPWEt6UFRhVjhYb3M2bk1xUTl1YnVBT2ljSGxXdUQzc0tMVzJE?=
 =?utf-8?B?Qjk2dS9hNXJJT21haEpSd1k4a3psY2pRNlFScitwcy9FNm9pZWt6Q1hZYXFj?=
 =?utf-8?B?S3d4ZXJHM3pZcUEzOUlwQ3I2ZU84anFoS0U4OGpTMnhkdEplSFVtMzVDS2VG?=
 =?utf-8?B?dEFKY1ZyV1YwVGZlTDVnaXNRU1NxY0NUVlFNWjl0MFlUVG5HYzJMbnN4MGxW?=
 =?utf-8?B?Mm82cUhTMGZtdE1YeDZXb3l0Tk5Zc3JLUDFabG8wZHJLK1RJeVlTQlMxQzY5?=
 =?utf-8?B?aTN0ZDJYU1Z4SThtbldVbjVwd3IxV252U3lwRjVKTStra2gwRVl0cnZmK0x4?=
 =?utf-8?B?dDRjZTYxcmFlNGpCMDh2Ly85SWFEU051K1JPSGRldCs1Tm5rUHl3dm16L2Fi?=
 =?utf-8?B?MHJZL2xwbkpHZmlVcUU5N3RSSzZrc2Yrb2k5TVFWL2dzTlpDeFlpUW8zWjJv?=
 =?utf-8?B?ZktuVDYyTzRuU0JJbGFIKzA1cnIvcDVQU0VwMkpxOFdOWnh3T2ZZb0d1aklt?=
 =?utf-8?B?Rk1MUk9iMFUwelVSR2NRYTFYNHNJeHN1SnVpeWJUMGxIWUxoOWRrbnVOdjJq?=
 =?utf-8?Q?OzoGd1YdDAV48+0dBniawHwn8JatNFvxhn9OF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: da1f7e7c-7ab4-45c2-c16e-08de613a2281
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2026 02:32:24.8915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vA+ea09WUEH2GYfy/8mQ5oogHbJpfG9brkI2rxK2Rjmh2aENrhFIaoHYFOaqw2UUVYEJV+wfeDryGMcwsp4gEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2685
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8643-lists,dmaengine=lfdr.de];
	SURBL_MULTI_FAIL(0.00)[valinux.co.jp:query timed out];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,nxp.com,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DBE4C4AA7
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 12:34:13PM +0900, Koichiro Den wrote:
> Hi,
> 
> Per Frank Li's suggestion [1], this revision combines the previously posted
> PCI/dwc helper series and the dmaengine/dw-edma series into a single
> 7-patch set. This series therefore supersedes the two earlier postings:
> 
>   - [PATCH 0/5] dmaengine: dw-edma: Add helpers for remote eDMA use scenarios
>     https://lore.kernel.org/dmaengine/20260126073652.3293564-1-den@valinux.co.jp/
>   - [PATCH 0/2] PCI: dwc: Expose integrated DesignWare eDMA windows
>     https://lore.kernel.org/linux-pci/20260126071550.3233631-1-den@valinux.co.jp/
> 
> [1] https://lore.kernel.org/linux-pci/aXeoxxG+9cFML1sx@lizhi-Precision-Tower-5810/
> 
> Some DesignWare PCIe endpoint platforms integrate a DesignWare eDMA
> instance alongside the PCIe controller. In remote eDMA use cases, the host
> needs access to the eDMA register block and the per-channel linked-list
> (LL) regions via PCIe BARs, while the endpoint may still boot with a
> standard EP configuration (and may also use dw-edma locally).
> 
> This series provides the following building blocks:
> 
>   * dmaengine: Add an optional dma_slave_caps.hw_id so DMA providers can expose
>     a provider-defined hardware channel identifier to clients, and report it
>     from dw-edma. This allows users to correlate a DMA channel with
>     hardware-specific resources such as per-channel LL regions.
> 
>   * dmaengine/dw-edma: Add features useful for remote-controlled EP eDMA usage:
>       - per-channel interrupt routing control (configured via dmaengine_slave_config(),
>         passing a small dw-edma-specific structure through
>         dma_slave_config.peripheral_config / dma_slave_config.peripheral_size),
>       - optional completion polling when local IRQ handling is disabled, and
>       - notify-only channels for cases where the local side needs interrupt
> 	notification without cookie-based accounting (i.e. its peer
> 	prepares and submits the descriptors), useful when host-to-endpoint
> 	interrupt delivery is difficult or unavailable without it.
> 
>   * PCI: dwc: Add query-only helper APIs to expose resources of an integrated
>     DesignWare eDMA instance:
>       - the physical base/size of the eDMA register window, and
>       - the per-channel LL region base/size, keyed by transfer direction and
>         the hardware channel identifier (hw_id).
> 
> The first real user will likely be the DesignWare backend in the NTB transport work:
> 
>   [RFC PATCH v4 25/38] NTB: hw: Add remote eDMA backend registry and DesignWare backend
>   https://lore.kernel.org/linux-pci/20260118135440.1958279-26-den@valinux.co.jp/
> 
>     (Note: the implementation in this series has been updated since that
>     RFC v4, so the RFC series will also need some adjustments. I have an
>     updated RFC series locally and can post an RFC v5 if that would help
>     review/testing.)
> 
> Apply/merge notes:
>   - Patches 1-5 apply cleanly on dmaengine.git next.
>   - Patches 6-7 apply cleanly on pci.git controller/dwc.
> 
> Changes in v2:
>   - Combine the two previously posted series into a single set (per Frank's
>     suggestion). Order dmaengine/dw-edma patches first so hw_id support
>     lands before the PCI LL-region helper, which assumes
>     dma_slave_caps.hw_id availability.
> 
> Thanks for reviewing,
> 
> 
> Koichiro Den (7):
>   dmaengine: Add hw_id to dma_slave_caps
>   dmaengine: dw-edma: Report channel hw_id in dma_slave_caps
>   dmaengine: dw-edma: Add per-channel interrupt routing control
>   dmaengine: dw-edma: Poll completion when local IRQ handling is
>     disabled
>   dmaengine: dw-edma: Add notify-only channels support
>   PCI: dwc: Add helper to query integrated dw-edma register window
>   PCI: dwc: Add helper to query integrated dw-edma linked-list region


Hi Mani, Vinod (and others),

I'd appreciate your thoughts on the overall design of patches 3–5/7 when
you have a moment.

  - [PATCH v2 3/7] dmaengine: dw-edma: Add per-channel interrupt routing control
    https://lore.kernel.org/dmaengine/20260127033420.3460579-4-den@valinux.co.jp/
  - [PATCH v2 4/7] dmaengine: dw-edma: Poll completion when local IRQ handling is disabled
    https://lore.kernel.org/dmaengine/20260127033420.3460579-5-den@valinux.co.jp/
  - [PATCH v2 5/7] dmaengine: dw-edma: Add notify-only channels support
    https://lore.kernel.org/dmaengine/20260127033420.3460579-6-den@valinux.co.jp/

My cover letter might have been too terse, so let me add a bit more context
and two questions at the end.

(Frank already provided helpful feedback on v1/RFC for Patch 3/7. Thanks, Frank.)


Motivation for these three patches
----------------------------------

  For remote use of a DMA channel (i.e. the host drives a channel that
  resides in the endpoint (EP)):

  * The EP initializes its DMA channels during the normal SoC glue
    driver probe.
  * It obtains a dma_chan to delegate to the host via the standard
    dma_request_channel().
  * It exposes the underlying HW resources to the host ("delegation").
  * The host also acquires a channel via the standard
    dma_request_channel(). The underlying HW resource is the same as on the
    EP side, but it's driven remotely from the host.

  and I'm targeting two operating modes:

  1). Standard use of the remote channel

    * The host submits a transaction and handles its completion, just
      like a local dmaengine client would. Under the hood, the HW channel
      resides in the remote EP.
    * In this scenario, we need to ensure:
      (a). completion interrupts are delivered only to the host. Or,
      (b). even if (a) is not possible (i.e. the EP also gets interrupted),
           the EP must not acknowledge/clear the interrupt status in a way
           that would race with host.

                                  dmaengine_submit()
                                          :
                                          v
       +----------+                 +----------+
       | dma_chan |--(delegate)--->: dma_chan :
       +----------+                 +----------+
      EP (delegator)              Host (delegatee)
                                          ^
                                          :
                                completion interrupt

  2). Notify-only channel

    * The host submits a transaction, and the EP gets the interrupt
      and runs any registered callbacks.
    * In this scenario, we need to ensure:
      (a). completion interrupts are delivered only to the EP. Or,
      (b). even if (a) is not possible (i.e. the host also gets
           interrupted), the host must not acknowledge/clear the interrupt
           status in a way that would race with the EP.
      (c). repeated dmaengine_submit() calls must not get stuck, even
           though it cannot rely on interrupt-driven transaction status
           management.
      (d). callback can be registered for the dma_chan on the EP.

                                  dmaengine_submit()
                                          :
                                          v
       +----------+                 +----------+
       | dma_chan |--(delegate)--->: dma_chan :
       +----------+                 +----------+
      EP (delegator)              Host (delegatee)
             ^
             :
      completion interrupt


  Patch mapping:
    - (a)(b) are addressed by [PATCH v2 3/7].
    - (c) is addressed by [PATCH v2 4/7].
    - (d) is addressed by [PATCH v2 5/7].


Questions
---------

  1. Are these two use cases (1) and (2) acceptable?
  2. To support (1) and (2), is the current implementation direction acceptable?
     Or should this be generalized into a dmaengine API rather than being a
     dw-edma-core-specific extension?


Any feedback would be appreciated.

Kind regards,
Koichiro


> 
>  MAINTAINERS                                  |   2 +-
>  drivers/dma/dmaengine.c                      |   1 +
>  drivers/dma/dw-edma/dw-edma-core.c           | 167 +++++++++++++++++--
>  drivers/dma/dw-edma/dw-edma-core.h           |  21 +++
>  drivers/dma/dw-edma/dw-edma-v0-core.c        |  26 ++-
>  drivers/pci/controller/dwc/pcie-designware.c |  74 ++++++++
>  drivers/pci/controller/dwc/pcie-designware.h |   2 +
>  include/linux/dma/edma.h                     |  57 +++++++
>  include/linux/dmaengine.h                    |   2 +
>  include/linux/pcie-dwc-edma.h                |  72 ++++++++
>  10 files changed, 398 insertions(+), 26 deletions(-)
>  create mode 100644 include/linux/pcie-dwc-edma.h
> 
> -- 
> 2.51.0
> 

