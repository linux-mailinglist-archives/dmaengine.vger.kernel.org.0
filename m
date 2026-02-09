Return-Path: <dmaengine+bounces-8823-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id R2YrM1RdiWmZ7gQAu9opvQ
	(envelope-from <dmaengine+bounces-8823-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 05:06:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1810B820
	for <lists+dmaengine@lfdr.de>; Mon, 09 Feb 2026 05:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2620B3001338
	for <lists+dmaengine@lfdr.de>; Mon,  9 Feb 2026 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2A523D7CE;
	Mon,  9 Feb 2026 04:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GBfXwBPr"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020087.outbound.protection.outlook.com [52.101.228.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950FD1CEADB;
	Mon,  9 Feb 2026 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770610001; cv=fail; b=dqTjpnkkCEN/Y6eUqMr5RDGsz1P6GG26Bnn/JE+IbEL4hhdMB8Q4UTgI2W0SzSxPnpPZRzfVDNCAygQ8YR8/ysE7za6yI4Z8HC78cfmsLU3yABv6caQVJhYbrVniHNjpHsSGaAZgMXNW7IKSEI8QrSiN5zWDIbuiZZMr/xHAJWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770610001; c=relaxed/simple;
	bh=+C2+u1NW89L0OfBEi6rw8T+aSddYLTUY9iWFDS+HvM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dZoYJFmjblVMou9BzElkY4f3AhHzkS7vuqsyhuWrV5f+nO/S1B3/gHW8b8L+4Az6ukWbomagJMG2gK8xzrzGDnEpP63cKGQdeQYLEWwObXQDpb960lE3bRg0+VkgARgB4AqgGszRJOqCIr66hqBWXjuKuFj+6um/asLxVFu0+no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GBfXwBPr; arc=fail smtp.client-ip=52.101.228.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n6PFa+p65uLika6C7FEVtdjqzgIh8aHQr4kchQHy+qgmtwXGpneHewVVmMHC0iDukL6JE6c70w6OERU4qkbN8yqWR+BH2C/35M/U8UTcfbBVs2FDYteGwXMOkNl34HN7Jv2P39suhVf578TR+Jfw5JaBUT6nxFEQO0k53rxtHVFaqwyhl+2HTIP+GhVZKuS5I26e8KRW9mTyESNZR6ctT+koF1giwRlzkF0aJboAcfMZEeAHpzFpwesPLVdixkmZD2lPuqvzDnSL2AUmmJmpG+t7WAO4Fo25iEKVldxN9DXpYshkSNB9YaP7LuN98Hetmbru9XzM30zH0M1vZn45zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOLPA3AmiPdcsPDV5+zU9RALYG33eNgWzOed6Gu1Jos=;
 b=SjCkQc0kO/nearCqOtHFZzU7bjuxyLB9OpM+Kb5Ovw3vrW6fbiKcU/bRXUlWAMgtqF7aVaUFClNAa/c7FcNvwp+Qm972dwsXyf+UYPdfh0d8IBVFRJR4782t4gEVdID6sYiQ/eUdbtiPYc2RtuvRDx38XNUywvHyKFWT3iNhjL2D8KP36f1tallUzkXS5Ye7KcnOhzOmTpwp4nXRgozlvw9igLjwp99vcFVZZRLC3FI0UTaU7awLoFlUs5pf8fRFblXR0QdyVdwD4QCOma3rs7W8JIBPhg2LgR5/WxPFVIBfl2F2RvnNy8sxfvgsfqGT896MSUbJHRAYgmkdNffoAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOLPA3AmiPdcsPDV5+zU9RALYG33eNgWzOed6Gu1Jos=;
 b=GBfXwBPr68Vpvoummh8ITnEbks8mCHpNN+LaabJW/ViJLK6AcI0J9m5QkcFkCrFwtQnGxYwjtm5KFYiLMs6+M01x8Coq6b4b4uWa3Qs8saPYYQG588COn0EFbUS8Ov+vc56I6P/XIPu3a5FtQ7dcGp/g6nOmZSfA3QFef1gKn4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3662.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3d7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 04:06:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 04:06:36 +0000
Date: Mon, 9 Feb 2026 13:06:34 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <qktad6ggosznbznej7n2luxwkhr34f3egtojzjnkry4v2balbh@sfxxoii5yxoa>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-2-den@valinux.co.jp>
 <aYYoWtkM0EhP1Od9@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYYoWtkM0EhP1Od9@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0281.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3662:EE_
X-MS-Office365-Filtering-Correlation-Id: 45693da4-af5e-4951-714d-08de67909e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Nkczek1ZQ1hTdnJRWTVyMkpERXE2L0FBU202d2RpQVEzK1ZMeHhzTFJpOTh0?=
 =?utf-8?B?aFRhZ1c0TC9iK0Qybk9LUkJMR3NiM3lYOWhvRkgwY2xqYzUva3FlbVlJZmhU?=
 =?utf-8?B?cG8xaTBISzNUZjE5NVpYdjhYRjFCbXU1SklSTzFFQWQrV2JSek5jbkdWK2xY?=
 =?utf-8?B?Mnh5eU1yeVhrTHkzbXFOZ2tueDZFVkJhYnpzWUFHTkhYb2ZYNVB2WmIrai8z?=
 =?utf-8?B?MDJPUHdBZlZqQVlrNG9YejBMZDltY0lKOGJWT0RhakQyWUp3SzdqQ29LLzZj?=
 =?utf-8?B?NGw0QkdSbFFIV1ZvNXcvdUt2bDU2MDRObTBGU1doRHpEQkphQ0hCT1p6RlQ2?=
 =?utf-8?B?M0VhS2FLeVFzMWdsUUVoUTJ3cnVwcDRSa0x2VUt2T2p5OU9BV1dnUTloV29H?=
 =?utf-8?B?aS9mNjdMN1RpNVVtcDhQM3B4VkRCWjlzYThEdlZ0dGFyVTA3ZXkrTzRGckZa?=
 =?utf-8?B?Q2xNZDBlOVNuK0RNNmxFQXlnMFBlYW9XU3dna0FvUzVtLzJxZk1Yb3NEa2Vz?=
 =?utf-8?B?WTYwWnU0Rk5IMUdVTnRoWHl5aG83V29obUpZUi92RUp1bjh0eU9qNUhiQ2VO?=
 =?utf-8?B?djZEOFBsbFpVdW9pdWowTU9yQUY0ZTcyWnc4akhGbjZyamc4TCtPOWpPVVFL?=
 =?utf-8?B?ODBQYkh0bHZCYXVORWpxYkVHaUgvY0R4VVJOYVhib2JCVUdGVEdaKzlRTUU1?=
 =?utf-8?B?dFNHV3lxbDVMNTRRN1luOTBYemtXYmtYbmtqOHplRzlrY0pncHJQOVJ5VTlH?=
 =?utf-8?B?N3lQTHgvZDhKNFl4OEdxM3Fzbm5oN0UxeWRveDlFZER5MlVpZnMwU2loWVk5?=
 =?utf-8?B?OE56QTEwVDYybWZqa0E5RWdjSm8yN1Y3dGVsaFNQc1hJTFZBNm56WGNCU1gx?=
 =?utf-8?B?UnRNdllUMmhoRWlSUzV5V0ZQdG9ZWWpZdGo2eDlZQ0t6bDEvYkdtaWZmTmg5?=
 =?utf-8?B?cHIzaW1Ub3hSazYyRkZhQWE1clJ5NUxnZHF0TU5OTzRDeTd2UWMyWktmcE5D?=
 =?utf-8?B?ZWhRUTJ1R2tvUEJoVkJDb2xaSzgwRFNBeFJNSlRtS1Y3V1UwWnNSbUVDY1Nh?=
 =?utf-8?B?V3hxQkcvenJIbndBTWhDVjFDZW15VENXczY0dVQrOE5QUDJBRExqMzRLQTFV?=
 =?utf-8?B?U1RneWhuQWpHMUlObDVQNW9rSVo2MXVGOVpuN0hFdXF5cUFKeXBMMkpSOUpK?=
 =?utf-8?B?K0FCdE43UE5WNEprRzhCZFBlWkpPaE56dDk5b1h0cWRWOHc1UDkxaWRsbEZN?=
 =?utf-8?B?cFZUbHNnOVM4OVkyMGx5NTcvRE9HZGdYajFhdlZYUm5MdkJDM2d0OUtyanEw?=
 =?utf-8?B?bkdXVUU3Qzg3aGljWFBGRjkyNC9nM1J1UTBZRjNXSEJoYnRMaTZQNlNyWVd4?=
 =?utf-8?B?dVMrUXFSeXFDb0V6NUh5eW9ZMnJKbWNPSnFsS0NLY1N2NG9WOWR4WFFQMXZh?=
 =?utf-8?B?WU9xSXQ4dktzMit1QmVWS2N3cmo0V2Q1Y3hQMW10VzIrRTZxVVhMREEyQ1R4?=
 =?utf-8?B?T29NU3MrTWRIcFE1OXVTUjBPVElPNVpoRWUwb2Z5cnlhTW9hNGpwNDZXZkNF?=
 =?utf-8?B?WW5vc0FnY214blZoY2ZvOHJPamRYc3JndUVFMWdJMGNmeWZTWkhhYWdUWkRi?=
 =?utf-8?B?K3RUOTNKM1FZSUlFalJtZnJJMGZpVFV0NmhsR3JJQUdpOGoxdS9qNDJjbThy?=
 =?utf-8?B?aHNKWmpHOWptUVo0YnNGTFd4YXZzdDVzak5iVXBhWEFIK0swMktXNVNDT0NJ?=
 =?utf-8?B?S1JpcVgrQUd5L0l1TjRReTN2T2NOYVo1S1duczZraURWa1lQTTAwazF1djdl?=
 =?utf-8?B?enVmQTB2ejVHWlh4YmVNVWx2Mmpvc3VQUzNla0U0VWNveHdQRUpVT2hmTmVI?=
 =?utf-8?B?RWJzQUhqdTIzSHlDeGZXWG5ZL2Izc2ptYkYvV2lWTnJiNDRPSVVkMFg3VEJR?=
 =?utf-8?B?dFYrcFN5VnJmTllNYnYvTGtzTC9DWTRvSlVZL0FSU2dOZWx1WGNPU2Y3VWpV?=
 =?utf-8?B?eDdsV2p2VDF6dW9YY2VoR0hXZ1lVMS9zbXFsbnYrUkFNcWZ2R1VOR3BTV3FL?=
 =?utf-8?B?UU1vNHZjUW1Tc1lVVlZwdnFkMFE1QituR1dsSVFRcW11YnhhajlhWE10MlBT?=
 =?utf-8?Q?gDw8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N0FkRHBoclNiK0ZCU0MvZk14NGFFaFkxaHpwSlFKMzhsTFJObWp5aTZ2Vmpl?=
 =?utf-8?B?clAyRUZwd01Xa2NCbDRZMWNrYVg0R3Jwd0ZSZ1cvcWJjYTF1NUxDYW1Ybnhn?=
 =?utf-8?B?OUFIVy96T1ptcWZaQVBVeERZaXZRdzNEclEyK1RWT3VwWENJRVVOK2FUOERN?=
 =?utf-8?B?Tk1BT2EzRjVNUEQ0TU53d0todVZWQmZ3RkxVUTlrT2dIY2RnVzJnSkRac0s2?=
 =?utf-8?B?OW1KaFVXL0F1YUZ3cUZyb3pWOURjNWlmbHV5YVBlOTRFSi9NVG8yTjdCdmpv?=
 =?utf-8?B?ZHFIaWV6dHFneDRHSmpVcythQ0NONGxVUG1sTytEcXd5NG55S0cza2hEblZO?=
 =?utf-8?B?SlU3ZTMvNTNjaEJ3bDdJeXpxb1RZZTM4Y1ZUcjdaSGFQZDBqWTN4UC9JZkZ0?=
 =?utf-8?B?WVVyNys3WDN4enNjUWx2MDRIY1pCdTFhSVZaZE1uNEYxc1dBcWdBNDQ5WE9z?=
 =?utf-8?B?a1VEUW05Z0xObjUvcjhqYnd4U2RNQ2ZQcGl2azBXblptNGNRZVIrNFYzL0JW?=
 =?utf-8?B?MWVzbEI3SlU1cjg3YVBobkhoNTRWUDM0VkRvaUxtMUN6eWtBSWFITE4zbFp2?=
 =?utf-8?B?R1JTMGRUOUxWUDZrb3loTFowQnNIWFQ3WlhGWStSdVhTNlNsQWx5S3h0cWtY?=
 =?utf-8?B?R0ZFNEdLUnphYlNsR0dEcHNnaTlGWkhIZ3NxVDEraWpUMmdtRGxvRVNzZ3ZX?=
 =?utf-8?B?NFpzYzA5RXFUS0ZZaGFVK0lpK0E2WllpQkJ2VThyVnY3VE5rVHlFV2s0dTJ3?=
 =?utf-8?B?SFU0OWNzTWlUZzhjQS9mNzlObVozendqcDRUR2lwTWxEcjlhalZKNXFCRnhr?=
 =?utf-8?B?b1FmSWdwQ2QrVmQvVk04OHk4YkNKdFVYeC90dW0wTEk2ZStyaGFYM3NyWHB3?=
 =?utf-8?B?amZMNkcrcXlsanRTb1FwM1hSVkYyaC84TnRxaHpTVzBHMG5WcWxFYUhGbHl0?=
 =?utf-8?B?KzFJWVM5VCt1cGViWVhqUzgvNUh0Z1JVQkVuWWhKZCtmY2xyb3N3MjFOaldU?=
 =?utf-8?B?clZlMVhHMFd5OUJSck1jRTFVUVExd0tCZlU4Ri8wUFRhK1E2YXJkZkYzNGZz?=
 =?utf-8?B?WFFwU1M2MUJoTXF2YmtYckpaeUp6L1Awd1Q0WVRLNGJ0UkZwczB1Umx0d1FE?=
 =?utf-8?B?V0dwcTZlcmU3RElydUJOTCtzRmZPQkgrMmhKODRDaGVaYzZKaFYvZTF5Qms1?=
 =?utf-8?B?ZFYxTzUyWVIzL3c0RUt2MjJ1SVBvQ0pwMFRnQkxXaWFjL3YwY0puOE5WaTJD?=
 =?utf-8?B?aitQQkVPTXpFSzZ5SkJsbTdVOEw5T0VvcTNFMmpiY1h1YkwvcHVBNm9seTMw?=
 =?utf-8?B?RE9UcGRRSENvcjZVdE1aMjBVTDZ4VkdkeXN5c21vNzNwT1pKTktaRjcrMVh6?=
 =?utf-8?B?Nnk1aGMvU1JJWVgybnA1TkUvL1lPWTB6K0NKdFZVTkVTMEZVNWtRZHNhWGRX?=
 =?utf-8?B?cldhVDBtT0tIcDBXVHVORGM5cURMeW03dzJxRGhaWDJVeG1yRjRld0ZHS0NB?=
 =?utf-8?B?VHBGVlFNODNrZE9oU1UzeDEweFZnRlRkZlpqZ2FJeDhDb1ZuNnZXelA3VG5R?=
 =?utf-8?B?VVRoQ3dDUVdYK21XSzVPV3N4aUNOWWtQaGlhOHJaUEVIQW02YXVoU2hLTytq?=
 =?utf-8?B?eHlUcnlrci9UMGdtUDJrM21oMjluaE9XYm5ycHNrMGZsZGJiQTFzRnBCcGt3?=
 =?utf-8?B?T2ZpeEJJNktwSlNIdlFQUm1LRkNqSWlPUytzT0lFRFdpOVJ6ck9Xb250cTU0?=
 =?utf-8?B?djB1YTBUdEY5bko5d0ptaFVXRW5lTVdCbTk4NjIwc24zd2JUR1FIalNDQURm?=
 =?utf-8?B?N2dIOUdmRDJrd1cvaDZYQy9Ob2J5a1ZNNjNGdmUySDhHZDFOL2k5SUFNUzdx?=
 =?utf-8?B?aHFza0dYUEdPdUdrekIyV0ZSdU1JdXFLSnI5dkNQVDMzMXRyQitNUUx3QVE5?=
 =?utf-8?B?TmEvZXNkQWE5T29XbVlPdUw4aGNvaE45ZlhZQUtsejJwUUtOaFRZU2IweGJE?=
 =?utf-8?B?c0hicE52bzlDakRKWnZDOHY2K2RvOXFLb3k0RUlqeFJGQVFUcTlibnlnemxj?=
 =?utf-8?B?UlR3NE9qY0NuQzBNOHUvaW96YTRpNkVLeEdwWitBbUYwY21pbnkwd1dpcGM4?=
 =?utf-8?B?azEzMitnTnBYQnRNY2h4WHZqRlIrZXhobkY4eVRBMFJSak1jYWlld2xQa3JK?=
 =?utf-8?B?WnMvS2NzL1BRVEJyTlpvbzFyeGNEY3d2OXlFSzFVZ2huU293ZEVKVkhLSzBt?=
 =?utf-8?B?QTFrUllra2xFV0ZQQ0phVm1lZlpiOXdXaGo1NHhkUy9BcnZFT0NUNzcxWFRQ?=
 =?utf-8?B?MlYvTmVnb3hHMWF0dEZ3L05xbjJwNHh6QWZseS8zRC9VZHROdFpyRURYbGly?=
 =?utf-8?Q?pLb53LgE5TaWf3D20lsOjJhFhycjjq/xZ8LZS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 45693da4-af5e-4951-714d-08de67909e4b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 04:06:36.2901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQwnQrd5R/5xO22W7Cbecw6TECeTEc0IdBcwlDEXDA0qY185LsaTaH99y6ig6rcwoOd8T+c98h1HEsswi6u+XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3662
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
	TAGGED_FROM(0.00)[bounces-8823-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: C3C1810B820
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 12:43:54PM -0500, Frank Li wrote:
> On Sat, Feb 07, 2026 at 02:26:38AM +0900, Koichiro Den wrote:
> > DesignWare EP eDMA can generate interrupts both locally and remotely
> > (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> > completions should be handled locally, remotely, or both. Unless
> > carefully configured, the endpoint and host would race to ack the
> > interrupt.
> >
> > Introduce a dw_edma_peripheral_config that holds per-channel interrupt
> > routing mode. Update v0 programming so that RIE and local done/abort
> > interrupt masking follow the selected mode. The default mode keeps the
> > original behavior, so unless the new peripheral_config is explicitly
> > used and set, no functional changes.
> >
> > For now, HDMA is not supported for the peripheral_config. Until the
> > support is implemented and validated, explicitly reject it for HDMA to
> > avoid silently misconfiguring interrupt routing.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c    | 37 +++++++++++++++++++++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h    | 13 ++++++++++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++------
> >  include/linux/dma/edma.h              | 28 ++++++++++++++++++++
> >  4 files changed, 96 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 8e5f7defa6b6..0c3461f9174a 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -219,11 +219,47 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
> >  	}
> >  }
> >
> > +static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
> > +				  const struct dma_slave_config *config,
> > +				  enum dw_edma_ch_irq_mode *mode)
> > +{
> > +	const struct dw_edma_peripheral_config *pcfg;
> > +
> > +	/* peripheral_config is optional, default keeps legacy behaviour. */
> > +	*mode = DW_EDMA_CH_IRQ_DEFAULT;
> > +	if (!config || !config->peripheral_config)
> > +		return 0;
> > +
> > +	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > +		return -EOPNOTSUPP;
> > +
> > +	if (config->peripheral_size < sizeof(*pcfg))
> > +		return -EINVAL;
> > +
> > +	pcfg = config->peripheral_config;
> > +	switch (pcfg->irq_mode) {
> > +	case DW_EDMA_CH_IRQ_DEFAULT:
> > +	case DW_EDMA_CH_IRQ_LOCAL:
> > +	case DW_EDMA_CH_IRQ_REMOTE:
> > +		*mode = pcfg->irq_mode;
> > +		return 0;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> >  static int dw_edma_device_config(struct dma_chan *dchan,
> >  				 struct dma_slave_config *config)
> >  {
> >  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> > +	enum dw_edma_ch_irq_mode mode;
> > +	int ret;
> > +
> > +	ret = dw_edma_parse_irq_mode(chan, config, &mode);
> > +	if (ret)
> > +		return ret;
> >
> > +	chan->irq_mode = mode;
> >  	memcpy(&chan->config, config, sizeof(*config));
> >  	chan->configured = true;
> >
> > @@ -749,6 +785,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> >  		chan->configured = false;
> >  		chan->request = EDMA_REQ_NONE;
> >  		chan->status = EDMA_ST_IDLE;
> > +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> >
> >  		if (chan->dir == EDMA_DIR_WRITE)
> >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
> > index 71894b9e0b15..0608b9044a08 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > @@ -81,6 +81,8 @@ struct dw_edma_chan {
> >
> >  	struct msi_msg			msi;
> >
> > +	enum dw_edma_ch_irq_mode	irq_mode;
> > +
> >  	enum dw_edma_request		request;
> >  	enum dw_edma_status		status;
> >  	u8				configured;
> > @@ -206,4 +208,15 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
> >  	dw->core->debugfs_on(dw);
> >  }
> >
> > +static inline
> > +bool dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
> 
> nit:
> 
> static inline bool
> dw_edma_core_ch_ignore_irq()

Thanks for the nit. I followed the style of the neighboring codes, but I
agree it's better on its own. Let me fix that in the next revision.

> 
> > +{
> > +	struct dw_edma *dw = chan->dw;
> > +
> > +	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
> > +	else
> > +		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
> > +}
> > +
> >  #endif /* _DW_EDMA_CORE_H */
> > diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > index b75fdaffad9a..a0441e8aa3b3 100644
> > --- a/drivers/dma/dw-edma/dw-edma-v0-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
> > @@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > -		dw_edma_v0_core_clear_done_int(chan);
> > -		done(chan);
> > +		if (!dw_edma_core_ch_ignore_irq(chan)) {
> > +			dw_edma_v0_core_clear_done_int(chan);
> > +			done(chan);
> > +		}
> >
> >  		ret = IRQ_HANDLED;
> >  	}
> > @@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> >  	for_each_set_bit(pos, &val, total) {
> >  		chan = &dw->chan[pos + off];
> >
> > -		dw_edma_v0_core_clear_abort_int(chan);
> > -		abort(chan);
> > +		if (!dw_edma_core_ch_ignore_irq(chan)) {
> > +			dw_edma_v0_core_clear_abort_int(chan);
> > +			abort(chan);
> > +		}
> >
> >  		ret = IRQ_HANDLED;
> >  	}
> > @@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
> >  		j--;
> >  		if (!j) {
> >  			control |= DW_EDMA_V0_LIE;
> > -			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> > +			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
> > +			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
> >  				control |= DW_EDMA_V0_RIE;
> >  		}
> >
> > @@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
> >  				break;
> >  			}
> >  		}
> > -		/* Interrupt unmask - done, abort */
> > +		/* Interrupt mask/unmask - done, abort */
> >  		tmp = GET_RW_32(dw, chan->dir, int_mask);
> > -		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > -		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
> > +			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		} else {
> > +			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
> > +			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
> > +		}
> >  		SET_RW_32(dw, chan->dir, int_mask, tmp);
> >  		/* Linked list error */
> >  		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 3080747689f6..53b31a974331 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -60,6 +60,34 @@ enum dw_edma_chip_flags {
> >  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> >  };
> >
> > +/*
> > + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> > + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> > + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0, local interrupt unmasked
> > + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> 
> You'd better descript remote interrupt also.

Thanks for the comment. Hm, while revisiting this I noticed the current
enum comment is overly LIE/RIE-specific and can even be misleading (e.g.
*_IRQ_DEFAULT does not imply a RIE=1 behavior when the eDMA instance is
operated purely in a local-only setup).

I think it’s clearer to describe the modes in terms of behavior and add a
short explanation of what each mode means outside the individual field
descriptions. Below is a draft of the updated kernel-doc comment. How does
this look to you?

    /**
     * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
     * @DW_EDMA_CH_IRQ_DEFAULT:   Keep legacy behavior.
     * @DW_EDMA_CH_IRQ_LOCAL:     Local interrupt only (edma_int[]).
     * @DW_EDMA_CH_IRQ_REMOTE:    Remote interrupt only (IMWr/MSI),
     *                            while masking local DONE/ABORT output.
     *
     * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
     * bus, and remotely using posted memory writes (IMWr) that may be
     * interpreted as MSI/MSI-X by the RC.
     *
     * DMA_*_INT_MASK gates the local edma_int[] assertion, while there is no
     * dedicated per-channel mask for IMWr generation. To request a remote-only
     * interrupt, Synopsys recommends setting both LIE and RIE, and masking the
     * local interrupt in DMA_*_INT_MASK (rather than relying on LIE=0/RIE=1).
     * See the DesignWare endpoint databook 5.40a, Non Linked List Mode
     * interrupt handling ("Hint").
     */
    enum dw_edma_ch_irq_mode {
           DW_EDMA_CH_IRQ_DEFAULT  = 0,
           DW_EDMA_CH_IRQ_LOCAL,
           DW_EDMA_CH_IRQ_REMOTE,
    };

Also, for v5 I think I can drop this patch 1/9 to keep the series minimal
and focused on the doorbell fallback implementation (and its testing). I
can repost this patch later together with the actual consumer. Please let
me know if you have any objections.

If you're ok with the updated comment above, I believe it should also be
fine to keep your Reviewed-by tag on the repost.

Thanks for the review,
Koichiro

> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > + *
> > + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> > + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> > + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> > + * Write Interrupt Generation".
> > + */
> > +enum dw_edma_ch_irq_mode {
> > +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> > +	DW_EDMA_CH_IRQ_LOCAL,
> > +	DW_EDMA_CH_IRQ_REMOTE,
> > +};
> > +
> > +/**
> > + * struct dw_edma_peripheral_config - dw-edma specific slave configuration
> > + * @irq_mode: per-channel interrupt routing control.
> > + *
> > + * Pass this structure via dma_slave_config.peripheral_config and
> > + * dma_slave_config.peripheral_size.
> > + */
> > +struct dw_edma_peripheral_config {
> > +	enum dw_edma_ch_irq_mode irq_mode;
> > +};
> > +
> >  /**
> >   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
> >   * @dev:		 struct device of the eDMA controller
> > --
> > 2.51.0
> >

