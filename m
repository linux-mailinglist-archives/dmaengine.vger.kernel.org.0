Return-Path: <dmaengine+bounces-7026-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95648C189B7
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 08:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554EC1B21529
	for <lists+dmaengine@lfdr.de>; Wed, 29 Oct 2025 07:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF01E30F803;
	Wed, 29 Oct 2025 07:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Bk5JVmBt"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D48730E84B;
	Wed, 29 Oct 2025 07:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761721995; cv=fail; b=jwZz6U8l7T/HfjQBrXK8ZylUyiifDNIUJeSsbvoKXU7uL2sFbXH+NPgG1KXZDRZSXRqOMHKMR8xgkOa8ZIv8ivLJ2SXybFhL8i7wqgt911cQtBoxsoDdy0nEI07YKJOIrYcljYLlVBOX5qPSa+SyY9xJ1NIRKdLRdWd+H0LG4wE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761721995; c=relaxed/simple;
	bh=9OA6ay6FUBNZH3oexpe8i/XMgbtC+MO3j7F74mTe4LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fSmvdc1i9bWgcRUOHqkfC9qM3tDEy6wFPBKE1YEr9XgCzVciifAmeEKxICf0f1fLI5ODSXkHhv2bWu8MlCnBxCUIowCXx3u9fuQD9OlPa1EXPfety5Riyhmb13aG43KnKX8hW4koR8Krb6Zf2waAm0QGcluhZrF/zP2SHBwDVa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Bk5JVmBt; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hnb4KxNzHDyQzy4kn3Rwc2+nmgudvpyMIYgRzNYJ0KG3XPskDtanagOixFEX+26gE51J4Df4PpPHf3HMx2zd+mJwsHbHACczRmOYTrbLsO3E0UBn5EydV3JEmtZg1Xi8fIdbgHFVZUkBxHCdp5cNEUUqnT3dNNC9mXEjiSWhu1O/3PBvH+6R28iQ1XhEIc0Uhc/YTdhYS/study4n6Fz9Crf0mnNvxEseHUAZfwnqdAf0GVZxJDwmDwpNW34BIso01DWwlyClkh+lvSD0CTInUJfNlu7JFh8FivV4DOLR5ZFLZJJmj0koNZ9zf7vno8NW8RBt09dTE9rHxdpjWaY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrIz9GFQsDXa2M/J1MIBP5SxLuqO4UDR7tFcX8IrSK8=;
 b=p2GcucfXAJo/yZveBG2U6ISS2JA+1C+aun/Em8AOUE3zF1R97Fp9Py2WxS8DzaO0jNCAujhDAMUeajFVvKqd8RuGroGNEEU7gpCG2Tu91L7WR3GOEifGnqSncQR+87TdA8gVVgrYPGgX6K4LARZI4fA9jPd7ZkKct6meSEn/ccpGSf1w+SMNwPtGOVzzKhfeIuAy8LFg+k4R46KxSGtZUl4j1dtwb6t+/XjnleOE57xnpS1xNyPTuiILCxooWYEB+hiEnsEQxLXZVSgCG/+31MNA+gLPh3R8hEBGGPD1eCgIlWH/ifltv4hZI28z2aNMrfDfdRWxieeoqmrSq5oD1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QrIz9GFQsDXa2M/J1MIBP5SxLuqO4UDR7tFcX8IrSK8=;
 b=Bk5JVmBt/9SZd+9Tw/lPJ1szto/MfAlMc1eCZQs2vzvsRVX/XTmduR8C1xjre5wd20+mlD+UmJvAxFkUtKcjx2nJ28Q6JVtCswY8adfuZ0bFKQ0BV6zWegSaySJtftDm8/RCdWwZcZgkYqVv/vSb5R9wJvqiAlpYVavaILUryoI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS3P286MB2391.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:17e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Wed, 29 Oct
 2025 07:13:09 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 07:13:09 +0000
Date: Wed, 29 Oct 2025 16:13:07 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW
 offsets
Message-ID: <d33whpc7p2ijrs5xota5yjkrgiphqzrzlaaymupgcuhjg3qfbf@eaiclb6tqvrd>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <aPryDenvU7VTYpBp@lizhi-Precision-Tower-5810>
 <p6a5rfawgs3vcycm6ku23jpx4nhtmbuououfyfsypqli5t6zin@lekmytllocmc>
 <aPusw9M5kRA8G6NC@lizhi-Precision-Tower-5810>
 <igcadmsutjrert76iwfjhn7hg5j23z5blccxltwyuotbeislz4@3ze2av7sa32b>
 <aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY1PR01CA0186.jpnprd01.prod.outlook.com (2603:1096:403::16)
 To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS3P286MB2391:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc2bd85-7a46-4465-d44e-08de16ba9d1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1RuMGx4c0kvcFI1b1g4RGU5UVF3bUlDWDk5MW1FOHFkdkpYYVJ3Z3hBci9H?=
 =?utf-8?B?Wm9rTzlsWW96N2dLaSt3b2syN3FIRDZJUFEyOWxTbkVwdzhpckNYY282MFdP?=
 =?utf-8?B?Rng3dFgrOW0rcmhaWU1lTXpIWnUzOTRkQzROZHQ2SnhWR1hwdzJTbVZiWENa?=
 =?utf-8?B?UWFlUmQ1eTRtQU9NdGJGQy9CdmRuRkVCU08vNXp3MGpoa0ZtYks5YlZpTXl4?=
 =?utf-8?B?d29nR3VOLzdrS0ZDTU9tK2R5QUVyOGwwKzhTRjBZVUFJM3pVVTdRR0NWR3dY?=
 =?utf-8?B?NkhBMitmUGFQY3ZqRkJNdjUzTGFZWlNIbysrNkxMb0pvbUNKOS83eHFSdkc1?=
 =?utf-8?B?N24yK3Jrb2FYV1hDS05Cb3E3dXlmNndoUXdGanY3WUwxMVdENDBtbW1sbERY?=
 =?utf-8?B?cGhmN2pKWk5FZjQvczdSVWhZUERvQit6cGpmQWN4VytkVDVXRFFnaUdpQjVS?=
 =?utf-8?B?clI4NzU4cldTc1kwRlpGYVM1NENLMGRKZXlmZ0xROFUzZitidlNtK0ltcjJB?=
 =?utf-8?B?a09yVjZxdVJONVhOM1RBakRoMjFqZWV5NkxVcHAraFBjWHJlV0cwTnNLeWJG?=
 =?utf-8?B?WmxhK0d3WVBqZWdFMURmb09nKzg1UVdiN25GWDBSTlRNMkRtSDAvZEJydnRY?=
 =?utf-8?B?WTZ2RGJ5R2xxdzE4SWJ1WXdKalRKOXkwUnBrTkFqZzNhKzNvblVFY0xrZmlZ?=
 =?utf-8?B?YWdEcGdYb1dWTnFYS1VMdmVYTUpJaW9Sa3pTNXRha1R1QXpMbUlqL2JJQk14?=
 =?utf-8?B?WXkxbDdtakhyRzd4ZVMvU3JKbGd6VytPN2NjMDBSWkFtUVZ4TDc4b1hyVmhl?=
 =?utf-8?B?SmE4Y09QVWg2MVVESTdLN05WcEp2YUhrZ3h5T3B0KytLVG96VlI2Qy9aZkJR?=
 =?utf-8?B?ZXlQWHN4YWkzVU92UXJXQWxsWjVYK0pkbm9kZTVUUzRzTzRwYzRId0x4cXk5?=
 =?utf-8?B?QzZKMDQxRkQrbTVTUnpjUGJYQkszb1lkbC9nWGxxaVpEWlFES1NYNjk4bUh5?=
 =?utf-8?B?ZlFKTDlQRUZwUzNsN2gzQXpsOXZ0dnZucmJJM2dGdjg0YlN0OHQ0TG9rdUd3?=
 =?utf-8?B?MVpQZkNKaWc4VlhQdEpnM1dNQlRIMW5tSHhZeGpPYU1mUS95c2dVdWF6QmFP?=
 =?utf-8?B?dWxOZVIxRnJJaEIzVHpiY0x1Q29KUlloYWlHcmI0Z0dCMHpuU2J2WnZvNy9F?=
 =?utf-8?B?OE4zRklkYmRnOXpNQnZsU2V6U3VzU3RNNUUyU0hvQjd2MUNXcVFuaGlYRXBl?=
 =?utf-8?B?eEF6Z2hTYjc3Z1RnbndBbFNJT1paWC8zUlUra2RUZlUyaWN4Y1pMVjFteHhp?=
 =?utf-8?B?Zm51ekh2a2lSN0l1NmRRblEyRjB4d2puV1cvbjRRMUxuVkIxNm01eklRbTNu?=
 =?utf-8?B?dDdFcDVHblRwVUxoOWtDa2NBRk5VZTdEWVdaNVpEWERQK05sZnpJRWl4UklH?=
 =?utf-8?B?Q3VWQm9QVVpsYWpZTVRBZDdOUlNjZXZJUDQzNE9jNzFvUjd4TytMbHoyTmlv?=
 =?utf-8?B?bmpyVEh2UU5MbzJ4c2pkUEFiWjJ0SnllN0JyeDB3K3d1YnVBRDV6OWxOakQr?=
 =?utf-8?B?UVI5K05COXhBWTlXaTJ2U21IM3NtaTFUblRPMUhKbXYrZDFmZnNGV25ycG9x?=
 =?utf-8?B?V2pXVHhyYjFzdEN4R2VhelViVCs4WFJsSlJNNTQyR09lWHBlYXFWQUlWYUdQ?=
 =?utf-8?B?SjF3YWtLOXRRTVJPcCt5M1gvTDhmaitSczN0dExYVHlvcSs2THZPcitmejVY?=
 =?utf-8?B?NGZKVHMvVjhmT3c4R0dDZi94OVFwQmJRZ3hURE1jU1RBL3lYODVWY21SVmFX?=
 =?utf-8?B?OVlYc21aTEloRUVtdXQvL1BvK2tVUXFzeGhSTFBaektpVUMvYWIxT1FoRDVK?=
 =?utf-8?B?ckpYS3ExRDI3TEI1RzYwREQ2dm1QZWdhTlJOR1JQRTBxOEVEclVEWnNWQ3U1?=
 =?utf-8?Q?t+6L+iTQ2Ik6DNER6kzvw3JYPuZKhN7c?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHBPeFgybDBIRmJjczFra3RYTGdGT3d0UGFiNzBxZVNyeTdsS0tERnhIT1ZF?=
 =?utf-8?B?bW5PU2pML3dURWJuU2pLRjdLS2lIZ2xMczlBM0pnWHlCdWkxdzJKZks4b2xY?=
 =?utf-8?B?OG1TaEVubWNOK212dHhWSHFkYkVydFVmMWlaMlkxMnlhYWNGSk1XdTgzbkJy?=
 =?utf-8?B?RXVaOTNXbnRBOEhRMnM5eDRjUWZIc0s0RXhucU5mcHlWZnBhRzhadzVwaysv?=
 =?utf-8?B?WFgySk83MVFTdDJxU09NVTUrVlV4d0grc29icmZHbzBsNjlqSlE4OWducGRQ?=
 =?utf-8?B?bTdHK2tjRW01bUIzYkc5RzlDZzZvUG9OU1BwVGVEWVVYNERhQUVRd3h6M3Uz?=
 =?utf-8?B?RVZkY2ROQ1gxcjYzRTlUaTJJTW5QYlBsU3hUYWg5NjRmZjNKUU9CclFFSDB1?=
 =?utf-8?B?YW5heGQ0VXNPV3ZZVEtxVHlaaVgraERuS0g2NnRnV1FGNDdwcUlmcnFoUzF1?=
 =?utf-8?B?WlpYWVZFcWQyMEl3b1gvcktIYldJUnRCYjZEbjZKZEpNbk9FTGx5bDU5QWVJ?=
 =?utf-8?B?L1pkbjJleENMZjZPU1kwNWNoSzNhdVNpTmlZalFEU0o2THF0Z3JpYUxiQStm?=
 =?utf-8?B?NUw1U1I4eitXQVNabi85SXNmYXRIb3RxRkhtT3VBSHNEVXloZXMrNWFob2l2?=
 =?utf-8?B?aFZRWFMzNEJ6dm4vTDJNYlZ6WkdGY1pvQjZCcjZCYVVBd0RzbkJ1VDBLcmJX?=
 =?utf-8?B?aVFoNk84aGlsSEY1cjRvWTBla3RhcGJPUExwbE00dnl2M280dHZ0T1pjNXN5?=
 =?utf-8?B?QVN4dG8zczlKbDMrNGNyNjVHbjR6TjU0V3U1ZFFnRmVlVTNhdkNxRWxqWkxy?=
 =?utf-8?B?MFNrRDRKQnJ0ZjVaTzZqNityS3ZzQjFLeEFNWUtDUjd5VWpPb3djWmNSdjF3?=
 =?utf-8?B?RDNKUlJMRFprbVl6U3dxdnlIZThBbm9iNkhmRnd2YWVhV3FqUzFuc0JsdzA2?=
 =?utf-8?B?YkVUWS83N1Rnb2tLUWYvaHlicXo5d0syVzEvT1pGcG5abEs3SmN2UDJndWZr?=
 =?utf-8?B?K3J5ZVJwZ3BqM21XMUhDM2RqdzBXL0pmRCs2YWhLaGRuSnFwN3ljbEFPOVFX?=
 =?utf-8?B?WG1ncXFST1lWTGFaS0xGeDBKclpscEpoK3R0N1VzcStQOW96K2tKYkpqdTJC?=
 =?utf-8?B?aVcvVUtEbVZ5Yzk4TnhzRGkvVExaeEpCM1ltTnJVamhzMDJaVVBLTEVCenE4?=
 =?utf-8?B?NUZyUVJNK0p3aTA3YWo0REpSNWpWRDhYR3g3TE1JaGtpVWJqZWl0cEJvZWZl?=
 =?utf-8?B?QWwxbDZNa0MrekkzYzNRQmV0djh2RkVUVEJxSUJlWHRGWHNlVGxKYi9YblZM?=
 =?utf-8?B?cjZzWStLS1l5QitXdUt4M2xJcTJGdTJ4dzZTcVljMlhxQkt2MEQ0Y2dFaVg2?=
 =?utf-8?B?Z1FDRnF4Uzg2UmRtMlQvYXVSZUpqMGVpS3lTVC9CUFYzWC9ibnNzKzhrSjFF?=
 =?utf-8?B?eHVtQ3JwNU52NjhzWXg1YWl2TyswektRMkYrQXZQa2xTQlBiUFlCWnpBelF2?=
 =?utf-8?B?THg3OFI1bVJoM3FqM3pSOU1yMEI3d2M5RHdoOTN1cjdTYXJybU0rQWszNy8y?=
 =?utf-8?B?VGlhaWJiRzV6S2NjT1c4ZHpjbVMwVllBbi9GYm9xS1dacEZlTzd2VnphU252?=
 =?utf-8?B?c0RSQmdvNjNKbVN2R2h5NTVlUGNDUEs3MjNqQWQvSlZxMWRNK1VRenliK1E5?=
 =?utf-8?B?aVBBZFI2SXVjR0FHcUM2UEFJYjNYMTFPVVJoZXFzSVRSOVBPM3dvek1TenFu?=
 =?utf-8?B?OW9QeGRYa21Jd0FSNThTY05zWEhEN1BzSk81WG9KYWVIbytaanl5amhZUGU2?=
 =?utf-8?B?bHdBL0gyNlBoVC9WazNocWJCSElZUWJydkEyM0plN0t0MXY1MmFiNXFOMjFy?=
 =?utf-8?B?ajhKNXY5dFIyS0pJY3k2VGRjT1VvbjllWHU2ZHRCdmpiTmEvdFVKRktxSXBh?=
 =?utf-8?B?bTk1aDROazA4ZElvaUZMbzBXRkI2Rzd3MjI3SWp5QVNxR2lpU01nSjZnUnZm?=
 =?utf-8?B?aU12ZENHc3hKcXhOUldzUzVFaCswTzRsa1NpSnY4ZVBvWVNpbGpoRWNaV3l6?=
 =?utf-8?B?TEdDNVJjQmM1cm5PajhCbHBRVERvdS9GNzFzUmtoeGhCRngwVWtyR3Mwcndu?=
 =?utf-8?B?L3kyNkJ1L3ZvNnluSVRrSXJlVXltV05SUHJQWGpKQm1oV3lkd29xTlFLdEo1?=
 =?utf-8?Q?FrZPPBMEMydIYcjfdzS6wWM=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc2bd85-7a46-4465-d44e-08de16ba9d1a
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 07:13:09.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHDBGk15ofGlDG7KSALJ6RArKCUrC/kjujb0z2B8gQKGJ83Xv9kHgvpABxGMGlwL1F1Ou1DIW//CUw6JEc0ZEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2391

On Tue, Oct 28, 2025 at 04:50:18PM -0400, Frank Li wrote:
> On Mon, Oct 27, 2025 at 02:29:30PM +0900, Koichiro Den wrote:
> > On Fri, Oct 24, 2025 at 12:43:47PM -0400, Frank Li wrote:
> > > On Sat, Oct 25, 2025 at 01:04:01AM +0900, Koichiro Den wrote:
> > > > On Thu, Oct 23, 2025 at 11:27:09PM -0400, Frank Li wrote:
> > > > > On Thu, Oct 23, 2025 at 04:18:51PM +0900, Koichiro Den wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > Motivation
> > > > > > ==========
> > > > > >
> > > > > > On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> > > > > > does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> > > > > > result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> > > > > > (EP) is not possible even if we would add implementation to create a MSI
> > > > > > domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> > > > > > traffic must fall back to doorbells (polling). In addition, BAR resources
> > > > > > are scarce, which makes it difficult to dedicate a BAR solely to an
> > > > > > NTB/msi window.
> > > > > >
> > > > > > This RFC introduces a generic interrupt backend for NTB. The existing MSI
> > > > > > path is converted to a backend, and a new DW eDMA test-interrupt backend
> > > > > > provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> > > > > > parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> > > > > > windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> > > > > > The vNTB EPF and ntb_transport are taught about offsets.
> > > > >
> > > > > Map multi address to one bar is quite valuable, so we can start it as the
> > > > > first steps.
> > > > >
> > > > > But I have a problem about DWC iATU address map mode. for example, bar0
> > > > > to cpu address 0x8000000 (Local CPU).  but difference RC system, at RC side
> > > > > bar0 address is variable. May be 0xa000_0000 (RC side), maybe 0xc000_0000
> > > > > (RC side).
> > > > >
> > > > > Set bar0 mapping before linkup.
> > > > >
> > > > > How do you know PCI bus address is 0xa0000000 or 0xc0000000.
> > > >
> > > > Thanks for the comment.
> > > >
> > > > For vNTB this is done in two steps:
> > > >
> > > > 1). In the epf_ntb_bind() path we call pci_epc_map_inbound() with
> > > >     epf_bar->phys_addr == 0. On the DWC side this only triggers
> > > >     dw_pcie_ep_set_bar_init() and does not program an inbound iATU yet.
> > > >     (pls see Patch #5).
> > > > 2). Later, when ntb_transport's link work runs and we actually need to
> > > >     set up Address Match inbound window(s), pci_epc_map_inbound() is called
> > > >     again with epf_bar->phys_addr != 0 (and an offset for the sub‑range). At
> > > >     that point the RC has already enumerated the device and assigned the BAR,
> > > >     so dw_pcie_ep_map_inbound() reads back the assigned BAR value via
> > > >     dw_pcie_ep_read_bar_assigned(), computes pci_addr = base + offset, and
> > > >     programs the inbound iATU in Address Match mode (again, Patch #5 is
> > > >     relevant).
> > > >
> > > > Because we do not program the inbound iATU before enumeration, we don't
> > > > need to know upfront whether the RC will place BAR0 at 0xa000_0000 or
> > > > 0xc000_0000. We read the assigned address right before the actual
> > > > programming (again, see the Patch #5). Am I missing something?
> > >
> > > This should work for vntb user case. It needs generalize for other usage
> > > mode. maybe combine multi regions to one bar.
> >
> > IMO it's already generized infrastructure. I'm not sure if we need to
> > retrofit other EPFs (pci_epc_set_bar callers) in this series. We can do
> > that when there's really a concrete need.
> >
> > >
> > > Add a case in pci-ep-test function drivers to let more people can review
> > > it.
> >
> > This sounds reasonable, though it may involve seemingly a bit of duplicate
> > work, i.e. adding a similar configfs knobs on the pci-epf-test side, expand
> > the control register fields, make pci_endpoint_test aware of it, and
> > makeing sure that the selftest still pass. Please correct me if I'm off
> > here. I'll take some time to prepare that.
> >
> > Thanks for the review.
> 
> I like combine eDMA address to one bar, so RC side ntb epf driver can use
> dw-edma driver, (suppose just refer drivers/dma/dw-edma/dw-edma-pcie.c)
> to register a host side dma engine, so ntb transfer can use this dma
> engineer to do data transfer (with little bit modify to support periphal
> mode).

Thanks for the review.

Sounds like the cleanest path to me as well. I think we should modify
ntb_transport further to really benefit from this. As an example, for
ntb_netdev, by allocating RX buffers from a pre-DMA-mapped page pool (which
is no longer constrained by the MW/BAR) and exchanging those DMA addresses
over the control path for the other end to set as a DMA DAR, we can
eliminate the current double hopping model, i.e. local DMAC -> MW(BAR) ->
iATU -> TLP.

> 
> So data transfer speed can get big improvement.  Of source also use eDMA
> as doorbell work if there are enough dma channels in dwc controller.

As I understand it, the eDMA test interrupt mechanism used in the RFC (v1)
can be eliminated in this model. Instead, we can rely on real DMA
completion on EP side for the RC->EP direction, since RC kicks EP's eDMA to
initiate its TX.

I've been thinking of whether the test interrupt mechanism (Patch #23)
could serve as an intermidiate small step/practical workaround, but now I'm
inclined to aim for the cleaner way from the beginning.

-Koichiro

> 
> Frank
> 
> >
> > -Koichiro
> >
> > >
> > > Frank
> > >
> > > >
> > > > -Koichiro
> > > >
> > > > >
> > > > > Frank
> > > > >
> > > > > >
> > > > > > Backend selection is automatic: if MSI is available we use the MSI backend.
> > > > > > Otherwise, if enabled, the DW eDMA backend is used. If neither is
> > > > > > available, we continue to use doorbells. Existing systems remain unaffected
> > > > > > unless use_intr=1 is set.
> > > > > >
> > > > > > Example layout (R-Car S4):
> > > > > >
> > > > > >   BAR0: Config/Spad
> > > > > >   BAR2 [0x00000-0xF0000]: MW1 (data)
> > > > > >   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
> > > > > >   BAR4: Doorbell
> > > > > >
> > > > > >   # The corresponding configfs settings (see Patch #25):
> > > > > >   echo 0xF0000 > ./mw1
> > > > > >   echo 0x8000  > ./mw2
> > > > > >   echo 0xF0000 > ./mw2_offset
> > > > > >   echo 2       > ./mw1_bar
> > > > > >   echo 2       > ./mw2_bar
> > > > > >
> > > > > > Summary of changes
> > > > > > ==================
> > > > > >
> > > > > > * NTB core/transport
> > > > > >   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
> > > > > >   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
> > > > > >   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
> > > > > >   - Support offsetted partial MWs in ntb_transport.
> > > > > >   - Hardening for peer-reported interrupt values and minor cleanups.
> > > > > >
> > > > > > * PCI Endpoint core and DWC EP controller
> > > > > >   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
> > > > > >   - Implement inbound mapping for DesignWare EP (Address Match mode), with
> > > > > >     tracking of multiple inbound iATU entries per BAR and proper teardown.
> > > > > >
> > > > > > * EPF vNTB
> > > > > >   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
> > > > > >   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
> > > > > >     set_bar().
> > > > > >   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
> > > > > >
> > > > > > * DW eDMA
> > > > > >   - Add self-interrupt registration and expose test-IRQ register offsets.
> > > > > >   - Provide dw_edma_find_by_child().
> > > > > >
> > > > > > * Renesas R-Car
> > > > > >   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
> > > > > >
> > > > > > * Documentation
> > > > > >
> > > > > > Patch layout
> > > > > > ============
> > > > > >
> > > > > > * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> > > > > > * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> > > > > > * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> > > > > > * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> > > > > > * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> > > > > > * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> > > > > > * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> > > > > > * Patch 25      : Documentation updates
> > > > > >
> > > > > > Tested on
> > > > > > =========
> > > > > >
> > > > > > * Renesas R-Car S4 Spider
> > > > > > * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
> > > > > >
> > > > > > Performance measurement
> > > > > > =======================
> > > > > >
> > > > > > Even without the DMA acceleration patches for R-Car S4 (which I keep
> > > > > > separate from this RFC patch series), enabling RC-to-EP interrupts
> > > > > > dramatically improves NTB latency on R-Car S4:
> > > > > >
> > > > > > * Before this patch series (NB. use_msi doesn't work on R-Car S4)
> > > > > >
> > > > > >   # Server: sockperf server -i 0.0.0.0
> > > > > >   # Client: sockperf ping-pong -i $SERVER_IP
> > > > > >   ========= Printing statistics for Server No: 0
> > > > > >   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
> > > > > >   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
> > > > > >         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
> > > > > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > > > > >   Summary: Latency is 5995.680 usec
> > > > > >   Total 45 observations; each percentile contains 0.45 observations
> > > > > >   ---> <MAX> observation = 6121.137
> > > > > >   ---> percentile 99.999 = 6121.137
> > > > > >   ---> percentile 99.990 = 6121.137
> > > > > >   ---> percentile 99.900 = 6121.137
> > > > > >   ---> percentile 99.000 = 6121.137
> > > > > >   ---> percentile 90.000 = 6099.178
> > > > > >   ---> percentile 75.000 = 6054.418
> > > > > >   ---> percentile 50.000 = 5993.040
> > > > > >   ---> percentile 25.000 = 5935.021
> > > > > >   ---> <MIN> observation = 5883.362
> > > > > >
> > > > > > * With this series (use_intr=1)
> > > > > >
> > > > > >   # Server: sockperf server -i 0.0.0.0
> > > > > >   # Client: sockperf ping-pong -i $SERVER_IP
> > > > > >   ========= Printing statistics for Server No: 0
> > > > > >   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
> > > > > >   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
> > > > > >         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
> > > > > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > > > > >   Summary: Latency is 127.677 usec
> > > > > >   Total 2145 observations; each percentile contains 21.45 observations
> > > > > >   ---> <MAX> observation =  446.691
> > > > > >   ---> percentile 99.999 =  446.691
> > > > > >   ---> percentile 99.990 =  446.691
> > > > > >   ---> percentile 99.900 =  291.234
> > > > > >   ---> percentile 99.000 =  221.515
> > > > > >   ---> percentile 90.000 =  149.277
> > > > > >   ---> percentile 75.000 =  124.497
> > > > > >   ---> percentile 50.000 =  121.137
> > > > > >   ---> percentile 25.000 =  119.037
> > > > > >   ---> <MIN> observation =  113.637
> > > > > >
> > > > > > Feedback welcome on both the approach and the splitting/routing preference.
> > > > > >
> > > > > > (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> > > > > > later if preferred.)
> > > > > >
> > > > > > Thanks for reviewing.
> > > > > >
> > > > > >
> > > > > > Koichiro Den (25):
> > > > > >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> > > > > >     access
> > > > > >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> > > > > >   NTB: epf: Handle mwN_offset for inbound MW regions
> > > > > >   PCI: endpoint: Add inbound mapping ops to EPC core
> > > > > >   PCI: dwc: ep: Implement EPC inbound mapping support
> > > > > >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> > > > > >   NTB: Add offset parameter to MW translation APIs
> > > > > >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> > > > > >     present
> > > > > >   NTB: ntb_transport: Support offsetted partial memory windows
> > > > > >   NTB/msi: Support offsetted partial memory window for MSI
> > > > > >   NTB/msi: Do not force MW to its maximum possible size
> > > > > >   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
> > > > > >   NTB/msi: Skip mw_set_trans() if already configured
> > > > > >   NTB/msi: Add a inner loop for PCI-MSI cases
> > > > > >   dmaengine: dw-edma: Add self-interrupt registration API
> > > > > >   dmaengine: dw-edma: Expose self-IRQ register offsets
> > > > > >   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
> > > > > >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> > > > > >   NTB: epf: vntb: Implement .get_pci_epc() callback
> > > > > >   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
> > > > > >   NTB: Introduce generic interrupt backend abstraction and convert MSI
> > > > > >   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
> > > > > >   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
> > > > > >   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
> > > > > >   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> > > > > >     usage
> > > > > >
> > > > > >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> > > > > >  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
> > > > > >  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
> > > > > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
> > > > > >  drivers/ntb/Kconfig                           |  15 ++
> > > > > >  drivers/ntb/Makefile                          |   6 +-
> > > > > >  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
> > > > > >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
> > > > > >  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
> > > > > >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
> > > > > >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
> > > > > >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
> > > > > >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
> > > > > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
> > > > > >  drivers/ntb/intr_common.c                     |  61 +++++
> > > > > >  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
> > > > > >  drivers/ntb/msi.c                             | 186 +++++++------
> > > > > >  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
> > > > > >  drivers/ntb/test/ntb_msi_test.c               |  26 +-
> > > > > >  drivers/ntb/test/ntb_perf.c                   |   4 +-
> > > > > >  drivers/ntb/test/ntb_tool.c                   |   6 +-
> > > > > >  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
> > > > > >  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
> > > > > >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> > > > > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
> > > > > >  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
> > > > > >  include/linux/dma/edma.h                      |  31 +++
> > > > > >  include/linux/ntb.h                           | 134 +++++++---
> > > > > >  include/linux/pci-epc.h                       |  11 +
> > > > > >  29 files changed, 1310 insertions(+), 300 deletions(-)
> > > > > >  create mode 100644 drivers/ntb/intr_common.c
> > > > > >  create mode 100644 drivers/ntb/intr_dw_edma.c
> > > > > >
> > > > > > --
> > > > > > 2.48.1
> > > > > >

