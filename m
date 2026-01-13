Return-Path: <dmaengine+bounces-8231-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E312ED1659D
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 03:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56E813032AA8
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 02:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB22FD1C2;
	Tue, 13 Jan 2026 02:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wANqMdlo"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DC2F744F;
	Tue, 13 Jan 2026 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272288; cv=fail; b=peyWlFGc6J4NixlrQMDaA27zKPJjPw0/QZI42OHVB4ydyobyOqUkJgVqB3X1s7SgCmA7r3A2MzyD+7PrLOHjTiew/MDC5MGGZK7MJ4BXO8er8FiBYHLxPoJFpKU+PYEWupjsPq2bndLmuqZqV3GRCnobJdxKHZhZNM2iWlzBDn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272288; c=relaxed/simple;
	bh=VZs4vQDGdOq4ph6earn667rEcBUPs2BQKEOG+q1gW8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MJX9MWq1wPRBeTs/j567soudR0vQhV+juTNjZVJyqvMjGn7Knod5AH7yqq2+6rZIrD6OiUSaq6HDRgR5lWvo9DaYiWpakuJuUWbOmS5/GW/bZcmAjLv6BaZX1wxwuASQaUEzyl7SnKJYcKZaGQhQHhIqT35p2ucXJCS2bLVyuAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wANqMdlo; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdxUIcUP70cewK0oyZHOYr5Kld3x6Hm6Ecf/A29ZhJgAu5HM8jvd7ut8oSznGLm3i+2+AkvEWeEoHJl81Q/eviQ/iXSS/vOgcZBF9Uxt1YK4q8r/K6ykRzZ9kqzSOn9xt960tbgNu2K2KFqE/adadGhXQXqnYZZsUCwjsYpv952tHlxenh9PnSlUzQpnrd2zl9cdND8Tl64A8Q5v3I2G3WXnRtusOYb65KF3kLQ0I63DgNT9ECzVZHAAlhPInQVm8ca7O9nXYf4+aoRf2g7xXYJQOQDKReMwJJFNLaX/k6DsjB8Y4+KWbZGYKmj6zwUwrHg2eQr3pgGzFptY8YarZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwiPMeYOqla300uALiRXzDnK7JdjjLj6GHQnNLTby38=;
 b=WfUcBCAVFIJM8uvdIW+xq3WJ0Vbg+/YOC/MLEWWvfFYu9PajE9pdcf60x8dCst2SxmZ58LWt/NP6nnS0l9IvX2vouUZNziCNFqhNDTaQatviA+lLxmjXGZaTS8WSSWy+2dii2yJ3ZGd/IREhF924pzhdZ/Kfm8i53BUnRYxjy5xjpVcE705Ed59vKGqb4iN6j7FFlBE/dMD68zLNIK+avBYc1ujq1dIcribNuZq7guf4dSiTxi9PffVSS4uRH7jSHxcyDiL6F6VnKb+kAABeMfsdgHrufNG28GBC9nhTa1QuuZwByR0jHnraCHsM3oOaW30+YqQg5s4Mmqirrpi24w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwiPMeYOqla300uALiRXzDnK7JdjjLj6GHQnNLTby38=;
 b=wANqMdloF3aqaprJHjPelHEHekbLHOYv3et7IMlcV4NHNSvcpYuEjG+msDNeMd6TAYJnFdsZMF9uv9D5Q6VMLp2OLA5lOS5Tj0+/i1Mq4d0EFHTy5PZUaheQouiSMXJSDb+aFSXq6uwhSRrAg8zQpAd6GVF6+FcFu5y9+7AdNjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6770.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 02:44:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 02:44:43 +0000
Date: Tue, 13 Jan 2026 11:44:42 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Frank.Li@nxp.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org, 
	bhelgaas@google.com, corbet@lwn.net, geert+renesas@glider.be, magnus.damm@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jdmason@kudzu.us, 
	allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, Basavaraj.Natikar@amd.com, 
	Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, logang@deltatee.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, utkarsh02t@gmail.com, 
	jbrunet@baylibre.com, dlemoal@kernel.org, arnd@arndb.de, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v3 26/35] NTB: ntb_transport: Introduce DW eDMA
 backed transport mode
Message-ID: <ccu4kjuibnn47sylkjcmtlyoylgrdany3pzjfhmpd7lz6vqhd7@rgz6tpwlaozp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
 <20251217151609.3162665-27-den@valinux.co.jp>
 <e3229f31-e781-4680-aed1-05ad5174a793@intel.com>
 <gvwki3y5bec5lr4eukzreuojw4t55og72bnuoh74gmbgrdbtiq@c5qgmt5cdygd>
 <cb83f12f-14f9-4df1-bd43-c127a06bb7dc@intel.com>
 <rlqffb3dnvalfjj4vcbmqkraqxmqdv5vd4tpqq2cssyuwrydc3@ujkesovxdgfy>
 <71fd5c95-3734-479f-b1dd-9a2b48fdeb74@intel.com>
 <3zrstpea6x4imus6vskkm72hnf45l32qai4d6qdtyf5fu7tzl6@nl2xlv7ivka7>
 <71518468-e877-4b78-ac22-bb50e40915f3@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71518468-e877-4b78-ac22-bb50e40915f3@intel.com>
X-ClientProxiedBy: TY4P286CA0098.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6770:EE_
X-MS-Office365-Filtering-Correlation-Id: aac6d660-70fa-407c-ca06-08de524db4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pmB0JS8RBfilhESRKY6Tk8lu9aGCi/gC69V5hJ7QXiKVKUVzzRN0Ru8lRh4F?=
 =?us-ascii?Q?7MxjQ/qGeHB51dGUq3kuguYaxBzT9FOF7aLz2t2+hyig0bORZSo7iMVDLCo1?=
 =?us-ascii?Q?SqI1kX2hPsn+Uz09nKIgyH8dHNKUuKGRBALE2Vp6CAL943tm6pRjJBl8MDLw?=
 =?us-ascii?Q?aKxkRLjegsoIkR6fXJbQ2U0Tt2xhviYl0uCBouIsqSlipe/QFc9fbfSr83L1?=
 =?us-ascii?Q?dB27UOeqBUSuThYbToFWlTpzhgLLR/M7i73D6l8Fl/g1J/AA9thgRbix7HMi?=
 =?us-ascii?Q?egM1/kPW8j306d8+S2srxWhSeTteIJJ/iqS3Zpll+0g9w8Mlt6DIjrxRYHhd?=
 =?us-ascii?Q?asRy0pIuyP0FtWZkEfvTTqHbPoE/qUGsSsr9eSFagnWy2VZQ9NA5JW/gJ4Ie?=
 =?us-ascii?Q?8JJ1OuK8UxV7ZsF+/DD6jHNv99F1yB7V3XrhJdUiALMFcyi4YCcpxY84ai20?=
 =?us-ascii?Q?j+hcDDsWK1MTxKN8oCH0bKwNgLVRjhAyMU/inSxjSwIppH3YPnd7MD8L0jIP?=
 =?us-ascii?Q?5Z7a+ROZdA9ZY/wC9ZWd3TZ0gZEHaA9a3f2S2iBgy+eEBdQe1BILjVeA0QcM?=
 =?us-ascii?Q?xQTVx2+UW8O95FKdT/dPPcWJLKdGqMPHuyNUFgl7MyeJpQ+hGZcaxC5zjVoW?=
 =?us-ascii?Q?4ZADpierZRxuuQF0fG/XTEIXhlUIvk0NBpAlxmvVdwuvYThqDeOQJwX34mbJ?=
 =?us-ascii?Q?5yaTVB3VeUVxyRamf2u1Bq+SVbGIykBU4pBZ681lbmGp73vGuh4OU9zgn+65?=
 =?us-ascii?Q?IsDXnJK3eBE5UXKREseaJkwwHlyXRkMsiuTNRXU8VjSQCCHwyJarHCr/zZz5?=
 =?us-ascii?Q?/1ItVw3O83LVQ6fPB57NiEcoF1uN0z+NaXNjVpWUGr6qLSktAevoyMUy19p7?=
 =?us-ascii?Q?/lNU3HsDn+Xtv18dS5LBJmwNu/XwB4CqUh/oHhDppM9+Tjo2K2govfXT9cji?=
 =?us-ascii?Q?09EXH2CT13eSot1VNDcCAGkAxfc1XNHwVSRtYVhoz1i3xAUbljZR11+bZq39?=
 =?us-ascii?Q?Vl9SJak+GkXsxSv3h83C/Ya/UUlfP/Vww/bZCdBRMtG7KBD4IC6KIo5wCsIB?=
 =?us-ascii?Q?isU7FtWg6DJqzbbghNyOPpZBDJc0qgZdNGPaTq/Jd/Ps7No6x94MqOW9toFO?=
 =?us-ascii?Q?Wc0mpNevytnjfRxE7vTc9xlccDzP5L+AtTBCe+w3Q1l/RLgHBtk1TzBe9GcR?=
 =?us-ascii?Q?3LmP5XDEtTJQTuQ6WG+N90zfTSdDqJLpVGE9W9ov3CBtBD5SwBE4wByGpGc0?=
 =?us-ascii?Q?ifkA/FCvFCfkUE0+nQP0uDBfBvgWQDQATbEvP56YlwWlKoItPqLbDiTf79kT?=
 =?us-ascii?Q?qsrvfpX+XUvMxc/yXomwP1srsoUA3h0CioNpUqXQzY9vP6lyzvRNTdI4+QPH?=
 =?us-ascii?Q?Eshx2Y9+6TwtItRptdlsSbXRvz9BifTdg1Pc3EQl4fmqmiH58flaxyWL3RSG?=
 =?us-ascii?Q?RzWZNtKfIOrl6C5bpvcJgv6FXXNA4Dts?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dux7z+WNoRDYXKCtXvFpPztlGdIXls3hyiTDzNT3QVr/fo6At6r94kOAEQZm?=
 =?us-ascii?Q?FI/usoKk+HAoEsT7K12aLDbTTLKGu+/P9W5jLcRQ/HcvsCVyiVYSNXlAsoK0?=
 =?us-ascii?Q?OWyokz7ehe33F37KRhZTvCJcFPEtHAtD2OHPpvrKGorDNi5XWkpy+N9ZO19K?=
 =?us-ascii?Q?FUrrBUhgxs3JupGPSH480Ri0adCG7PIdVsvR0JduHVSoMzwx09/d0uQ5KZZK?=
 =?us-ascii?Q?lUkE7+oxUgK2tHI4Fxk3+wWbgtI4F8Cw4+x/Af4aPjzlhNvRl9Jl83o+8ib/?=
 =?us-ascii?Q?oAKAFQld8dg653h1AFrKaVMy5rC8omOzOtXzXR1Rh4oLlUHnS9vy4R2Q2bRG?=
 =?us-ascii?Q?Piv+OHOPdZ7HogjV3wN2+hVxO02U9u6vuxOTeAHUcWJVC3O+yNotaUmvSryy?=
 =?us-ascii?Q?uOXtbC8lRtZ2u/Ypx/n7L0+0PjGclk1uC1wZgHIbCOEWNpxmUSIG/wWvAtZd?=
 =?us-ascii?Q?cp2t505uNMTzTR0oDVLQJIvF7uTXjcC6CW5pXyt0k1OMieyL7v12JzmAV7Nq?=
 =?us-ascii?Q?2itA2ImRlmuXMKThVKCWWFYnN/YfgljmflmJpK6DQXwssxntiPwqogPqGtYz?=
 =?us-ascii?Q?yD58+oZcKDshPOCcmbQdVDyORCpA4EM51b4jhKbMFuHUma79yTYwwnSmFyBI?=
 =?us-ascii?Q?LCEtuwBJkdvjAwLicVMqRclr2tLv3iVvux1Rvweph9vns8easIbJf8aH84O2?=
 =?us-ascii?Q?1L9Vi3CHsxfZjmX0JFhNUf4bSGHh9/UK+KNJdDgqNae+MN4sjNR9i2XMdBAR?=
 =?us-ascii?Q?WLTkw4wXDdB1xkJ1jdFey/Ty091GWQ2/aj5bTKxVKNoZYChNJCaf9Q8zA6bn?=
 =?us-ascii?Q?df3HX+Si38oYWybGl/50z0k1NkhnvAjBMu3SbVkKxm31521sDo2pOApK0w/o?=
 =?us-ascii?Q?V5GM4viGrwB/zUZ5Pa6cj05FqLYvWsEnn5rXL2CjWR88dS4XzErgjv04I13F?=
 =?us-ascii?Q?6j9ZsaJLsfuTIq6GBdRTh01hjW2YwW8gA6wkRpNhaT8yHGv7ILYBCdEMvubo?=
 =?us-ascii?Q?9zK1/Vm51P7XXmWB+8bm7HsYrGJ+ukyFSH0uhqzSSWOMMszEu8OjUeBHrSWe?=
 =?us-ascii?Q?3puwf0AXpauD9RY9uoPRAy2IYt/+vPIf2Kxkm9HWUq3N0SnhlglYd3ZfHBdw?=
 =?us-ascii?Q?/lZ30ScjpkhN5vQ7DSKg5Nle6IHGHoVDuA4BEJYRgoRFqU61QnZexkR/Glu+?=
 =?us-ascii?Q?E3+P0zsf4a0jVtz7n57kKNttEnU0HICVXXf/xMXkUqyRNlYC7wBptBs35sYr?=
 =?us-ascii?Q?icebvkIBqO6AHOhalFOoSSFrJBw87DCHIuD7yxMFE3zh/H9YiFH2ICrm+aO5?=
 =?us-ascii?Q?kwEB1pzQ5uDDUjm1eYCmjOCA5WkWhsZRUJ9JlM827E3VUf2Uf8pDmhy4zGu6?=
 =?us-ascii?Q?hmtvEXIL8Fqa6sitpCF2tFhBbztw9IITokc66oYmC6AHljWr4ZjqPNHRA/lB?=
 =?us-ascii?Q?h9SuxESDxOG6fwARwfNM8qjyMHEfLRVYyU9cDTbIWogsz5+Fsn6vEM3t/fJL?=
 =?us-ascii?Q?C141KyUfl/vM6AV+fuK00c7UEqXUoMwubA/mTGcUyB4QoUE81DP8DyKdYgEv?=
 =?us-ascii?Q?Pa/Pntpxy1ayiI+oBaMk/G+HvrNoy/Be3YeyybK5Yd+1BZmYm34yhCGfwqL2?=
 =?us-ascii?Q?IxptmryK5DwP+yFWg07glCyU4I8yu/PYa2QdGGw5P59mXA2tTFr8kvkH13hy?=
 =?us-ascii?Q?BiQrSv07LF2JOm72zMDc2gVPyEl0f2vHY3DzyBRc1AkHs9xZNptCv2VkYh2w?=
 =?us-ascii?Q?Lm1C0yq7Rh215va337R8lYMlkfnspzkhbm5BxDi6HTG6MQbttJRO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: aac6d660-70fa-407c-ca06-08de524db4f8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 02:44:43.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaRozetksqF0+HaDborXCCHW0wyCpOPIFVeoPsc76b8rBAjvp5fjf6K2TZU89C1z7EsOO41SHUELy3yqDhZKkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6770

On Mon, Jan 12, 2026 at 08:43:28AM -0700, Dave Jiang wrote:
> 
> 
> On 1/10/26 6:43 AM, Koichiro Den wrote:
> > On Thu, Jan 08, 2026 at 10:55:46AM -0700, Dave Jiang wrote:
> >>
> >>
> >> On 1/7/26 6:25 PM, Koichiro Den wrote:
> >>> On Wed, Jan 07, 2026 at 12:02:15PM -0700, Dave Jiang wrote:
> >>>>
> >>>>
> >>>> On 1/7/26 7:54 AM, Koichiro Den wrote:
> >>>>> On Tue, Jan 06, 2026 at 11:51:03AM -0700, Dave Jiang wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 12/17/25 8:16 AM, Koichiro Den wrote:
> >>>>>>> Add a new ntb_transport backend that uses a DesignWare eDMA engine
> >>>>>>> located on the endpoint, to be driven by both host and endpoint.
> >>>>>>>
> >>>>>>> The endpoint exposes a dedicated memory window which contains the eDMA
> >>>>>>> register block, a small control structure (struct ntb_edma_info) and
> >>>>>>> per-channel linked-list (LL) rings for read channels. Endpoint drives
> >>>>>>> its local eDMA write channels for its transmission, while host side
> >>>>>>> uses the remote eDMA read channels for its transmission.
> >>>>>>>
> >>>>>>> A key benefit of this backend is that the memory window no longer needs
> >>>>>>> to carry data-plane payload. This makes the design less sensitive to
> >>>>>>> limited memory window space and allows scaling to multiple queue pairs.
> >>>>>>> The memory window layout is specific to the eDMA-backed backend, so
> >>>>>>> there is no automatic fallback to the memcpy-based default transport
> >>>>>>> that requires the different layout.
> >>>>>>>
> >>>>>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> >>>>>>> ---
> >>>>>>>  drivers/ntb/Kconfig                  |  12 +
> >>>>>>>  drivers/ntb/Makefile                 |   2 +
> >>>>>>>  drivers/ntb/ntb_transport_core.c     |  15 +-
> >>>>>>>  drivers/ntb/ntb_transport_edma.c     | 987 +++++++++++++++++++++++++++
> >>>>>>>  drivers/ntb/ntb_transport_internal.h |  15 +
> >>>>>>>  5 files changed, 1029 insertions(+), 2 deletions(-)
> >>>>>>>  create mode 100644 drivers/ntb/ntb_transport_edma.c
> >>>>>>>
> >>>>>>> diff --git a/drivers/ntb/Kconfig b/drivers/ntb/Kconfig
> >>>>>>> index df16c755b4da..5ba6d0b7f5ba 100644
> >>>>>>> --- a/drivers/ntb/Kconfig
> >>>>>>> +++ b/drivers/ntb/Kconfig
> >>>>>>> @@ -37,4 +37,16 @@ config NTB_TRANSPORT
> >>>>>>>  
> >>>>>>>  	 If unsure, say N.
> >>>>>>>  
> >>>>>>> +config NTB_TRANSPORT_EDMA
> >>>>>>> +	bool "NTB Transport backed by remote eDMA"
> >>>>>>> +	depends on NTB_TRANSPORT
> >>>>>>> +	depends on PCI
> >>>>>>> +	select DMA_ENGINE
> >>>>>>> +	select NTB_EDMA
> >>>>>>> +	help
> >>>>>>> +	  Enable a transport backend that uses a remote DesignWare eDMA engine
> >>>>>>> +	  exposed through a dedicated NTB memory window. The host uses the
> >>>>>>> +	  endpoint's eDMA engine to move data in both directions.
> >>>>>>> +	  Say Y here if you intend to use the 'use_remote_edma' module parameter.
> >>>>>>> +
> >>>>>>>  endif # NTB
> >>>>>>> diff --git a/drivers/ntb/Makefile b/drivers/ntb/Makefile
> >>>>>>> index 9b66e5fafbc0..b9086b32ecde 100644
> >>>>>>> --- a/drivers/ntb/Makefile
> >>>>>>> +++ b/drivers/ntb/Makefile
> >>>>>>> @@ -6,3 +6,5 @@ ntb-y			:= core.o
> >>>>>>>  ntb-$(CONFIG_NTB_MSI)	+= msi.o
> >>>>>>>  
> >>>>>>>  ntb_transport-y		:= ntb_transport_core.o
> >>>>>>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= ntb_transport_edma.o
> >>>>>>> +ntb_transport-$(CONFIG_NTB_TRANSPORT_EDMA)	+= hw/edma/ntb_hw_edma.o
> >>>>>>> diff --git a/drivers/ntb/ntb_transport_core.c b/drivers/ntb/ntb_transport_core.c
> >>>>>>> index 40c2548f5930..bd21232f26fe 100644
> >>>>>>> --- a/drivers/ntb/ntb_transport_core.c
> >>>>>>> +++ b/drivers/ntb/ntb_transport_core.c
> >>>>>>> @@ -104,6 +104,12 @@ module_param(use_msi, bool, 0644);
> >>>>>>>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
> >>>>>>>  #endif
> >>>>>>>  
> >>>>>>> +bool use_remote_edma;
> >>>>>>> +#ifdef CONFIG_NTB_TRANSPORT_EDMA
> >>>>>>> +module_param(use_remote_edma, bool, 0644);
> >>>>>>> +MODULE_PARM_DESC(use_remote_edma, "Use remote eDMA mode (when enabled, use_msi is ignored)");
> >>>>>>> +#endif
> >>>>>>
> >>>>>> This seems clunky. Can the ntb_transport_core determine this when the things are called through ntb_transport_edma? Or maybe a set_transport_type can be introduced by the transport itself during allocation?
> >>>>>
> >>>>> Agreed. I plan to drop 'use_remote_edma' and instead,
> >>>>> - add a module parameter: transport_type={"default","edma"} (defaulting to "default"),
> >>>>> - introduce ntb_transport_backend_register() for transports to self-register via
> >>>>>   struct ntb_transport_backend { .name, .ops }, and
> >>>>> - have the core select the backend whose .name matches transport_type.
> >>>>>
> >>>>> I think this should keep any non-default transport-specific logic out of
> >>>>> ntb_transport_core, or at least keep it to a minimum, while still allowing
> >>>>> non-defualt transports (*ntb_transport_edma is the only choice for now
> >>>>> though) to plug in cleanly.
> >>>>>
> >>>>> If you see a cleaner approach, I would appreciate it if you could elaborate
> >>>>> a bit more on your idea.
> >>>>
> >>>
> >>> Thank you for the comment, let me respond inline below.
> >>>
> >>>> Do you think it's flexible enough that we can determine a transport type per 'ntb_transport_mw' or is this an all or nothing type of thing?
> >>>
> >>> At least in the current implementation, the remote eDMA use is an
> >>> all-or-nothing type rather than something that can be selected per
> >>> ntb_transport_mw.
> >>>
> >>> The way remote eDMA consumes MW is quite similar to how ntb_msi uses them
> >>> today. Assuming multiple MWs are available, the last MW is reserved to
> >>> expose the remote eDMA info/register/LL regions to the host by packing all
> >>> of them into a single MW. In that sense, it does not map naturally to a
> >>> per-MW selection model.
> >>>
> >>>> I'm trying to see if we can do away with the module param.
> >>>
> >>> I think it is useful to keep an explicit way for an administrator to choose
> >>> the transport type (default vs edma). Even on platforms where dw-edma is
> >>> available, there can potentially be platform-specific or hard-to-reproduce
> >>> issues (e.g. problems that only show up with certain transfer patterns),
> >>> and having a way to fall back the long-existing traditional transport can
> >>> be valuable.
> >>>
> >>> That said, I am not opposed to making the default behavior an automatic
> >>> selection, where edma is chosen when it's available and the parameter is
> >>> left unset.
> >>>
> >>>> Or I guess when you probe ntb_netdev, the selection would happen there and thus transport_type would be in ntb_netdev module?
> >>>
> >>> I'm not sure how selecting the transport type at ntb_netdev probe time
> >>> would work in practice, and what additional benefit that would provide.
> >>
> >> So currently ntb_netdev or ntb_transport are not auto-loaded right? They are manually probed by the user. So with the new transport, the user would modprobe ntb_transport_edma.ko. And that would trigger the eDMA transport setup right? With the ntb_transport_core library existing, we should be able to load both the ntb_transport_host and ntb_transport_edma at the same time theoretically. And ntb_netdev should be able to select one or the other transport. This is the most versatile scenario. An alternative is there can be only 1 transport ever loaded, and when ntb_transport_edma is loaded, it just looks like the default transport and netdev functions as it always has without knowing what the underneath transport is. On the platform if there are multiple NTB ports, it would be nice to have the flexibility of allowing each port choose the usage of the current transport and the edma transport if the user desires.
> > 
> > I was assuming manual load in my previous response. Also in this RFC v3,
> > ntb_transport_edma is not even a standalone module yet (although I do think
> > it should be). At this point, I feel the RFC v3 implementation is still a
> > bit too rough to use as a basis for discussing the ideal long-term design,
> > so I'd like to set it aside for a moment and focus on what the ideal shape
> > could look like.
> > 
> > My current thoughts on the ideal structure, after reading your last
> > comment, are as follows:
> > 
> > * The existing cpu/dma memcpy-based transport becomes "ntb_transport_host",
> >   and the new eDMA-based transport becomes "ntb_transport_edma".
> > * Each transport is a separate kernel module, and each provides its own
> >   ntb_client implementation (i.e. each registers independently with the
> >   NTB core). In this model, it should be perfectly fine for both modules to
> >   be loaded at the same time.
> > * Common pieces (e.g. ntb_transport_bus registration, shared helpers, and
> >   the boundary/API exposed to ntb_transport_clients such as ntb_netdev)
> >   should live in a shared library module, such as "ntb_transport_core" (or
> >   "ntb_transport", naming TBD).
> > 
> > Then, for transport type selection:
> > 
> > * If we want to switch the transport type (host vs edma) on a per-NTB-port
> >   (device) basis, we can rely on the standard driver override framework
> >   (ie. driver_override, unbind/bind). To make that work, at first we need
> >   to add driver_override support to ntb_bus.
> > * In the case that ntb_netdev wants to explicitly select a transport type,
> >   I think it should still be handled via the per-NTB-port driver_override
> >   rather than building transport-selection logic into ntb_netdev itself
> >   (perhaps with some extension to the boundary API for
> >   ntb_transport_clients).
> > * If ntb_transport_host / ntb_transport_edma are built-in modules, a
> >   post-boot rebind might be sufficient in most cases. If that's not
> >   sufficient, we could also consider providing a kernel parameter to define
> >   a boot-time policy. For example, something like:
> >     ntb_transport.policy=edma@0000:01:00.0,host@0000:5f:00.0
> > 
> > How doe that sound? In any case, I am planning to submit RFC v4.
> 
> Yup that sounds about what I was thinking. If you are submitting RFC v4 w/o the changes mentioned about, just mention that the progress is moving towards that in the cover letter to remind people. Thanks!

I'll include all the changes in RFC v4.

Thanks,
Koichiro

> 
> Any additional thoughts Jon?
> 
> > 
> > Thanks for the review,
> > Koichiro
> 
> 
> 

