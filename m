Return-Path: <dmaengine+bounces-10887-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP9FNqb/FGp2SAcAu9opvQ
	(envelope-from <dmaengine+bounces-10887-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 04:04:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4F95CFB20
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 04:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E53E7300A332
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 02:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FB2F12A5;
	Tue, 26 May 2026 02:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uceSA5j+"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020085.outbound.protection.outlook.com [52.101.229.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EFF2ED154;
	Tue, 26 May 2026 02:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779761057; cv=fail; b=Srap+PtJyAXt22RPagrete4NlIrttywbQluas/XkXdzTTI7I5NrCBmzO2SRCXkSYpnW7nh/eEKXaAnwvwx5rkqCusz5qNUvdDEXkSMp36b83BI1EHb2wwSuQWJa2JB/axuJI4mEhHRr8yuTrDV+6/mznfUljSzDMsZ7pDZrYOPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779761057; c=relaxed/simple;
	bh=sHpQJ1zRPAXcEqez6Jy5Z6UNNmkU8lsEzQPmPho2t6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a4ei6h7IciRkYVVZR4urrfz5Rzz4QfpAZF8eum6xHoEg0j36WPIDYasu4DKyDWFXB5IWX6rT3VZa0W2D8UaqTAdHIIEtyjhzUd8L86mw0DBUyGLW225n9CVm8jlzMImsTfQ6hWGSo7GacDLdOrXDVmjOrdLGCSO3ycj1k/g5sjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uceSA5j+; arc=fail smtp.client-ip=52.101.229.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OEseYkRGxstWN84ugzY3WaCAOHSwMZSXvpA2jfLpLMkogNkSG5h5GIUt6joc89St/ihLFeHLpMqlPPtYxA4sr7CeVVWVAHSlo34cz0WAONrDQlFUEMShHnMEL5UDj2swvhHfMokndNKkpbEeN+FZyII2xDziCso1xSzj6VDlbiPIkD0GAq1Qt+/u2qVmxUKUj/7b/skZM5acFqPl1RZuN16iBg55b5ko1W8pgmgXYLavllD6taA6dRtQ883c8x4H5kwRQv510U7lVzSwDX3drimiD/y3/FYrLntGctGHHvI/laQgK7rIAHO2lyaPW88+RzOr5tr9XIScJtlkBHfhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WB0AUp6IsRgZh+TFnrhh0cXIPS2KXdbXjRnu6TzHOE=;
 b=KYHTK2mIga92srmztnmED0vqtk/1hz/u7j0Zfgj0Rixgvb2g3NFIunb7KDsbosaR/ATgb00+IIldcf+tEuMXwRJOLRKvlFcpKfvu7PzUnQyBWBGNizCVAyaJsdh2bAXoj/BB2tENFtihtu9a/awEmM9UODxgEYIW/V6+wOr070rRp3QqcUOTLiSpVeVL67sYR0JvFHZVvst41vWrN0DuDSXIQ7KkcIROCCdH0FLX7vxUJ2aQQGQZHqPkOwYfyqAC57fjcpRwHD6n+fCX0Dt+3Yt1RniVudzpC37zQRFq0HQo3HiyRXA4gvBuzOfCwBGkRTfoNLUVSFWiMKI0ze1oyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WB0AUp6IsRgZh+TFnrhh0cXIPS2KXdbXjRnu6TzHOE=;
 b=uceSA5j+0EPH6bl8W6l0DzvN++BCq2o+qb6aF5z8fKzJJrS3ctvbRM0zLpa3T1nq5K9hzla3nwiYB6gFI+b/R0xJnvmXFR7pwd6PJ7LYsrWKJtoIESWLqREymojM6PVgd0kdm208Wp0vREtQUzmc6GisDu4NVf9Zhl63ugHUvPk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3318.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 02:04:09 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 02:04:09 +0000
Date: Tue, 26 May 2026 11:04:07 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Damien Le Moal <dlemoal@kernel.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: endpoint: Add PCI DMA endpoint function
 (part 3/3)
Message-ID: <ll76isrjb62ieiz4vhn3u3upp46vnzed3slpqxnni5hymsc4mw@avbx7k473uo4>
References: <20260525063456.3317509-1-den@valinux.co.jp>
 <xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi>
 <ahQJ4kuaBKMhj52L@ryzen>
 <3dkicfydmrlm2i6ks34kwjdmlvb22ryftkfw2yj62o4rtj5xvl@f4gby5vlwtdf>
 <F31848F5-5481-4402-9B45-9EC7BCC8B0B6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F31848F5-5481-4402-9B45-9EC7BCC8B0B6@kernel.org>
X-ClientProxiedBy: TY4PR01CA0050.jpnprd01.prod.outlook.com
 (2603:1096:405:372::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3318:EE_
X-MS-Office365-Filtering-Correlation-Id: 005584a0-7aeb-403e-6ae9-08debacb1304
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|6133799003|4143699003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	xVxMC/ESDPGAmBE9sKIgOziPt4Qny4jq3ks27ZfQa3svSvrCv5zHtoqsZmDvwPfBSerBTlN2Gfxe+anvhZohifAUyyavC/RgLvPWhsxRdB2klax1AzJd8G1h95e551hWUIbiQ9JXQf6kiJaTfNcEg4vkQH27gBkz5FCf5JTNKPfuyfTmnvkDb+c1btVKmdmwRQSbC/B60bey/m9rKuoBh/rqHaJHHO8AkQpfbAHVc8jU1LVFeR/iUkMZTnadSMO+tNcd6Kh86jKXfV0aErMCurRLfwTQyTKFh79xXZUoUpr7yY0evay720evlu+qG7B0yN+XJcIxsMq4uj3sBnuoCqZmSLlYyq5KA11Q8RaNW4MAwhhscjtOxcZmRdGPdv/mEWrTO1FJTL44UorzagHk3xiVXrmIOXy7SoqHPBKVRx6SRzEedtQA06ckNiGJF9b+8flzHw12pIEIgp+oLbP3mHL/m3MSVOqAPM/PPWQsGCJrDXH3NiQ1vGLmfA4aiJLurtH091gaCr68kk66VnVmKspK7SSEAZrfd9v0a+bEmZwWD1h+S+fZBX1bsQyKmfYb2qhCrrpHcoDHDaskPxdAT2UhrrvcWLXLPVwFs8H/62kyPZ1FUEhif114TYen9/jTEHJ6k8OQUc70xN9BZiTrltUxkkG6xb2EvNTLUV6JB1AX/PBVc6KhJY7bf7QY60nf1hXeX+5LrAY4ANRlS675Aw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(6133799003)(4143699003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VUSs/spRjCw0siL5n4rlOsLHh9B9SdQ31SaPlFJyHipkVkUyEf1IFGiUe8jK?=
 =?us-ascii?Q?91Q19KKFx8QsDkfwwwOG5DoRWlPYlU6A3KFXMSsjbqLUQOvm/2+QqTohFzV6?=
 =?us-ascii?Q?OsNU9RUjU5jGIA81qRGAYvjThKnkFhTrUWgJK6FGPP4un+hzJLaPdN31G/36?=
 =?us-ascii?Q?7/6yQXjf2+s++D8Pg39Dr01YZe51YsqGZr/hTydTgJb6buV+OfWNO+t2fzqR?=
 =?us-ascii?Q?wBbfuIxr6lyjkAMHmZUsOIS3/QZVicCy2wfYTH9A4cKYnJ63ewL+gmYqEA+m?=
 =?us-ascii?Q?c0gI7JDkCOmjRpYGS1U8dgn4tbXzND7FrBINTMXjDV8Np1FZNjy7RvmrL3Jq?=
 =?us-ascii?Q?7KwkaoLY4zvbFXaW/LKwIkohh7jgvbZzrVEtk0UKn41QmdNnAMwN8H47LnFD?=
 =?us-ascii?Q?W9D77qxc3JkO+o/rlGjsXtek1/mw4HLzPD0vM2XpaYsqZW0ICxV4ebPFoUUz?=
 =?us-ascii?Q?WrdNvI5auqksP9hbWIl41xXTVGwRKdHlKBDPKuiBYatPEFNicEuvgCpwen31?=
 =?us-ascii?Q?YQwTGJjrqzLjaX5eK51JYXuOaz0EqatB44+pD1WuO2nrT7j5ujF/UWAFf7SQ?=
 =?us-ascii?Q?Q9bfUSiXv+74Im/r7/kNELxUCdqk+xOoTI1wTYzsEM1XvJpmwIYf5p/Vs8Md?=
 =?us-ascii?Q?JzjRLGHeIxz7RJxLQjww2+SxO9REskGqvbWRZjcxfrpK2FcJ91osu/FNJixj?=
 =?us-ascii?Q?sARIHfy0MksXpM/EkDjSG5OrSYLmWneMxQr+DVoA1CRqTBOdgE4K/jfw7KSj?=
 =?us-ascii?Q?fx9PSnUhG63QlxZof/M4tZ7uoJSKAs/HQeL9Hyav0zjOlapR+VKG1A036UX6?=
 =?us-ascii?Q?rRGCb6Xmo0uxFdF/b7WPN5NupZ02qsveS7kStlBxcpbBiXCcvau8RWJnLXer?=
 =?us-ascii?Q?/N2+6/smeUamAdQdEV+FjeXapSFeUdz4B6VWDcoPdMqfewy744EimbeSlEW3?=
 =?us-ascii?Q?fH6UGIymUKXXtfm5+AQxEw17zGPHgHO8eOfUeOAdGyco+jfwnb4dFQc/S4ql?=
 =?us-ascii?Q?DD30uTvybWOGZSwchatEzF2XilfRipyvic+sOqR8YODrE1AFqjq003siiZJB?=
 =?us-ascii?Q?y3+Lu+3ygm1vRDD0CZ05o49ddIy+s/VxoXKdSWFK+uV8aK99pm2H4I+ybnfC?=
 =?us-ascii?Q?xd1feR2AybOX7JdJim8Y5UPCBF/7oKw6nZZLFTncB66EDQ1fILsx3MJ/YbJo?=
 =?us-ascii?Q?KZKd6Js5an/gStqGB3YZhbJdLcIAL9+tcQiQA6ApPLUoSNJemqf+GIVVcErW?=
 =?us-ascii?Q?+Ld0zpHI10oCpPCFFqsxpt/s2aJsnIPsJsGC7dgJDZurjnKmzCoHsGiBPPch?=
 =?us-ascii?Q?UQFutWpQ0blaL7jMCdKQEcNlF5hbrBWtFBKvmeAZHMpn7Yz3TY1SNaRNJfBW?=
 =?us-ascii?Q?LQPY/lAobLitjmQJ/QGpJMUzUE40zBq2zKEffttMzq0c/0NZDq9o+VmLgoPV?=
 =?us-ascii?Q?ELT0LLcN1Y776SzK+5hkq677YW15Zj8Dv0yzoTLOHrYhTakxZT/hTi3eK0al?=
 =?us-ascii?Q?pc5X0G+NZ2hPFLXN6e9c8+h7x6kTV4pK15x/OjoZkG2uvdBiCbBcXl9H9RE4?=
 =?us-ascii?Q?b0xr4GixJlHudhYviZb0kltVSsJpD+xn6v3ZDtNyjsccJjGW2tayhh1FErwh?=
 =?us-ascii?Q?syFs8C8F8LXIHjjnCKIFNqoE5pVMfUtVi0okVho5vrfdcwxEbWLkl2RNJcip?=
 =?us-ascii?Q?ij4T+J0PiBLxsI0aKvv53HSx6wfs+OxX6dTBUjZ2qub6TunMeySMgOixlVOH?=
 =?us-ascii?Q?QPFGrrfW4Ny2BeKVn7VNfvUeZ7G6tgerneV6uE+jMJi5yKQx9OWp?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 005584a0-7aeb-403e-6ae9-08debacb1304
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 02:04:09.4656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8ZSgfMyjkypCBqHS7WR1BDmCGq6kbfDE3vNU+BEXV3y3M2MZRtEQPFoYN58TxRpujVI/h7okJ/ckCiREYdSKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3318
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10887-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 7C4F95CFB20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 10:32:06PM +0200, Niklas Cassel wrote:
> On 25 May 2026 16:03:35 CEST, Koichiro Den <den@valinux.co.jp> wrote:
> >On Mon, May 25, 2026 at 10:35:46AM +0200, Niklas Cassel wrote:
> >> On Mon, May 25, 2026 at 04:05:02PM +0900, Koichiro Den wrote:
> >> 
> >That restriction should be documented with the new NTB transport, which I will
> >submit if the direction taken by this series is acceptable.
> 
> This is easy for me to say, since I am not the NTB maintainer, but it would be nice if we could somehow come up with a design where we don't only support EPCs that have 'max-functions' != 1, because IIRC, most PCI EPCs have 'max-functions' == 1.

Yes, that's fair point. As a quick check on v7.1-rc5, among DWC-based EP nodes,
only 6 out of 45 set max-functions > 1 (about 13%). Assuming there are no cases
where the hardware supports more functions than the DT advertises, that means only
about 13% of DWC-based EP instances described in DT could support the "NTB
transport backed by PCI EP DMA" use case. If I also count non-DWC EP nodes, I
get 15 out of 64 (about 23%).

If supporting single-function EPCs is a requirement, then the separate PCI DMA
EPF model is not a good choice for that NTB transport use case. We would need to
keep the DMA delegation metadata inside the vNTB function, or use some other
single-function design.

That is basically option 2 from my earlier mail:
https://lore.kernel.org/linux-pci/xnfnxv64hpil6if4ikyohxnarvsekbmjcc37k5zej264ix46z3@qtu6xj2uy3xi/

    [snip]
    2. Treat endpoint DMA as a first-class part of vNTB. The RC-side ntb_hw_epf
       would create an auxiliary device, and a new dw-edma-aux driver would create
       the delegated DMA channels on the RC side.
    
       [PATCH 00/15] PCI: endpoint: Remote DMA support via vNTB
       https://lore.kernel.org/linux-pci/20260312165005.1148676-1-den@valinux.co.jp/
    
       I added an ASCII diagram for the overview as a follow-up comment here:
       https://lore.kernel.org/all/sn67hi7kljh7cgmgodatb3naz2astlaklqfobdbxyyzgoohxqb@4nnetbhqwba4/
    [snip]

Do you prefer the vNTB-integrated model over this series?

Best regards,
Koichiro

> 
> 
> Kind regards,
> Nikla

