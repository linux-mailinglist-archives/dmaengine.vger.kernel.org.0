Return-Path: <dmaengine+bounces-6982-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A3FC0720A
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 18:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781A21C054C2
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF17B17A2EA;
	Fri, 24 Oct 2025 16:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Ruw5ydNY"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011032.outbound.protection.outlook.com [52.101.125.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E232BF5B;
	Fri, 24 Oct 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761321850; cv=fail; b=qdd/8q5maQ1H05Z4ZIhiVOOc6U+UMXlYotbfAibkGCqCVgpgr2cj29Ul9cenDy26hBaa8PSgUb5J60XqIvqXYrvFeRZvt9EXGbpwV73wc3Y9mtI/CBAmtidtL0LvvqZm9unPRT5jJr39m/NW2H+m0kq0rGmNm9CngGYMceYFnsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761321850; c=relaxed/simple;
	bh=XP3XWPcoiF6ePqE8FkqZmgB2IFNq+Z3+NAmVdvH7ea0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WoeyMKq8Q8hRW/2LKdbvwu4S1hZjxhj68OfYqZDPiKphMQTQcC8BZ/DMqNVTsI09JOhg8/l4yMjH/YXTojZusLR8Gjy2QsfBBBCTBIEdFsKZ+PA267KR0ANT6uNfE4Yu0bwfIJNfp4FGyXEObhBSC+GPwCL8DX1PcitUd/v6mm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Ruw5ydNY; arc=fail smtp.client-ip=52.101.125.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfniZIjxujW4gp485OUlghh7ahx4PymmqaE8MU2HzyO4brDlZDQk6Wtyg0k7HFpWiVOb204Ut3wCZUO8eldlUFAeNgBBPLaTFfLP4Qme33c56MteMbuvREVtmAcxnnTIhhO3U4yW2Us330d2hilTzLqxjkjRV7GLsa5YruH64Cxrw6Hfe7G1D/SvoM1gm80r844LLT4JK4EMQ93BFgy1YZ2MlfFUM2QOjSGySVQWAOrz+b18KIouFtbxi3I3MsV9fj23AEnVMzcNSM4LTt6HFegzpSln0vVDwVmPNLCwDZEtQVc07qLGFu0ot4PlgRX4BtP674KKAsSXkZb95BUdKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GgRC+t+7GXSRBX161vNgMv99GkOIMBe79GyUVgUPWlE=;
 b=KDPpQV04FgfS4d/i2L7pz8rPEQD/jweYNm2PpKjJTQfpfwIdW6mV6iptG7x/Kk6Vi+KKmNeUmGA/8cPiqohsle0AVKmWuDXsZX5AFlse/5lTmEdV48qPcyGwjuVTQrcCL6+d3sj12LKgOTuv7kaMSUwQS7rWqcdh9x/iZv81QnNuxEyyitG6glJ7fX2zxbMVBYBpdAr2fQ1DrCFK2gOt7ogeH4x7ZBmpPsLjHSFOd12PUIs/N3Rq4ffbotk36tz7WnzVA/sfjwrTN+VzM5ZNQbGXx/D9zm2mkquaNCUZJ08A/P+V5J/VlnuST72fQ9/II5ZDtMUgCxqTA4ahDAAsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgRC+t+7GXSRBX161vNgMv99GkOIMBe79GyUVgUPWlE=;
 b=Ruw5ydNY3nxXs974sy67SF2XguokKDm09tMpR+P02p5Jt2Lyp3z4R7hLiQ/XpWyMX8IRkyaId0kF/uwdKexC5TwMu59kTqCZp3OsCqNddLR3FbpU8jZhQyF53VFJTc6IdxoRa19BSoOebL1L50RyYkvi+EDWiPnKhRDlx5IWm3E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYYP286MB4675.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:197::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:04:05 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:04:03 +0000
Date: Sat, 25 Oct 2025 01:04:01 +0900
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
Message-ID: <p6a5rfawgs3vcycm6ku23jpx4nhtmbuououfyfsypqli5t6zin@lekmytllocmc>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <aPryDenvU7VTYpBp@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aPryDenvU7VTYpBp@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYWPR01CA0045.jpnprd01.prod.outlook.com
 (2603:1096:400:17f::15) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYYP286MB4675:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e459bf-ebbe-4fbc-b75c-08de1316f353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0FydFd6ZVhYOEJNTnNKS3VRbUFoTkJibEhtd1VjUjNXaGJaOFpXUVR5aGNE?=
 =?utf-8?B?bXlCdWdNdXBnc2dBT2ozVERCMlZkWTF1enFPS1YvVmphWnVhcUZLdlRnS1Nv?=
 =?utf-8?B?WmVIL1JjR1c0UC9UNnZFY0hPcE4vZ3A0RjMwQnh3RGlrbkNzYzJvUC93aVo0?=
 =?utf-8?B?UlRoR2ZTM210SUFsUGdTYWNkT3F0cXo5RUU5Y3V3UnBJamx5SEU4NmIxcGli?=
 =?utf-8?B?cDdGTmNwZG1YOWQ3UjF2RHllNWlrUTdVTXVLaGlZUmlQV0JxVnN0cVU2Q0NU?=
 =?utf-8?B?bGxISmdDSlVsd1lhaGd2cFhnWkpDRFJjdTdubkVOM3o0V1lRdVNtT3YzazVx?=
 =?utf-8?B?MG1EZkQ2MUVyanJVa05KaHQvUGdGV2Zma2IwUTZkOGhEZHRya3NjZmQrZlNl?=
 =?utf-8?B?UDh0akVQVGpOcGFGT25OazFxUDFpYmZYZk1pM0pvazVsNlo5UnljWkdRbU1u?=
 =?utf-8?B?eE5WOEowVFkvL2NLOE1qRGtjSFdUN0VDUEtBY1JQVTI2ZCtYUWtiZWpkei8z?=
 =?utf-8?B?Ky82WDhKUnppT0l4azNoV2V6clRibnRBQTM4WEFuOTM2U1BVbG9tZWYrYlZs?=
 =?utf-8?B?aHpLVTkvOEZ6KzVXanh3Q1dwRmJrM2xJa0dPZFBFWDdPRnVOZ0Y0aFRGaWtW?=
 =?utf-8?B?cGNGdU95aHNod0VXbTA0Si9tYXpud3FMenlxREdKWUdhbGFHY1lGTWZBaVA2?=
 =?utf-8?B?Mkw3VlNtZ0dicGVmQUJQVlFFd1JrYXhnN1BEcEx0eEo5TW9CUWJRRGZ1czNM?=
 =?utf-8?B?dStXRm9EeXc0aGE4WFh3b3VNR0lWdmJwM0hOMkdPTjVab1h3dElUdS8zREcw?=
 =?utf-8?B?WEJqRHI1L1dYREV2dWhURllZT1hhbTQ5bm4wcDBhSStlcFBOSjR5WVFyNkJ2?=
 =?utf-8?B?dlZJNldGRjBWTDNzSzlBdXJLc3p4Sm9CL24ybDZSMUpaUWxUZ29IWkFkakVM?=
 =?utf-8?B?MG80SWhuRE8yVzNTODJpeHdSZTVYTXJrRmZOQ1pIUzV3MThyYmxJZ2pNSGlm?=
 =?utf-8?B?bTBIK1pqdnAvMll4WEFzT1VlRFlnbi9WQTUzNEUwS05XL0pxMHBrNnVpVDZ6?=
 =?utf-8?B?bGg4RnAxWVNEQTArWTRaTldNQWRyQm1vRDUwOXJuSTdjbDkvWkJYY0tHcExa?=
 =?utf-8?B?a2dDd25jWkhCMGRZWDJSZDBDM0l1Q1Z6Vmo2LzJHbzkzYXVNa2NOT3E2dEJX?=
 =?utf-8?B?eTRlUnJ3VHo4dndNbURXb2tqUlpPa3p6ZGNjeEoyRnRZQ1ByMHhpZ3ZadlVX?=
 =?utf-8?B?cFF6OHBNbFJiT05NQ0lwV1VZVnRuK2FQaEg4TFBQQjRtTUVmRGtRV3JrYlBi?=
 =?utf-8?B?MlhPOTZ1R1ZYc2xISUl0TGNhSlhSK0t3Ujg4eDBvdDhualhtR1JNa2RmV3hk?=
 =?utf-8?B?eFJNNGh2SytGWTJmbUtsZFg2ZlpCQm1reTBlRDBuL0NBQko2UjhjVXVKOHNR?=
 =?utf-8?B?N0lseEVRcStlRXcyd0xTVUhwS29ranNiZStvN09hVzI4dWI3TFJWNnpnVWtn?=
 =?utf-8?B?N2Fzc0hDMlZkcFN0WVZKaWlFMFRDbVJJY3VzZ1hOeHVaZ2k5Uzd3TEZTWW9i?=
 =?utf-8?B?WmRZSDJvRlpudDRpNFo5dmxRMmswVHFBNWFoSU1jTXZVaG5nZkJqZkEvT2hE?=
 =?utf-8?B?S1ZlRXFFaWV3V1pNbkQvSU9oNGFXWk5XK2NHUVUrTjB1SGliTjhRMVJQbEk5?=
 =?utf-8?B?dW9aTVFtK01jZ3lnSGl4MjZzcy85TjV5YmlLZzNvTldyYkZEV3hMaEJwTmk4?=
 =?utf-8?B?cFVUVXZBLzV6WFNFY2M1eWFzQlJZYmZubFEwL0xqRWk0bUNFM1pDS2w4TDl3?=
 =?utf-8?B?WlRyMHNqdUNPMlYxUDNxK01aWGxVVGdwN0tiSWxyS0pZS0NQZGJQelpzMnpk?=
 =?utf-8?B?RTQ0MXp6Z3hNaS9iZTZ3Sm1FZTZIWWhyWFJwaS9CMGNMTDJuK3RtMzZ4Tk4w?=
 =?utf-8?B?OWh6WmFhWlNuc05GekoxODBLUVN3MG5ZVW96Sm5ZbTAwalNJYjdRWU4zNnMr?=
 =?utf-8?B?cHVKc0RSdzlpZHpRSzBFU1R5QlRJbzVFTmtCS0FocFB6WTZLNHBQeWgzdDkx?=
 =?utf-8?Q?alHdK/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnhValZ1d05ZUWtUNmN4WWNaT0NxTTZrY2l3K2ZtbVlPbk4zdkdBSjRFS2w4?=
 =?utf-8?B?QVJHY1daeENOdENVWUZ6dUdqVjJHTVRaVU9zZ1Q4TE0zYnVBdWJobTRNVEJ3?=
 =?utf-8?B?VnFPcUtDRG9pOXBvSmNrNjRROTVKMjg0YW93bU52WXUwU1J0bTMvT0ZqM2xU?=
 =?utf-8?B?Z2hoclNad1dYVVhYSS9pcTRXcEdqZzdsaENNWW9aMFpnNFNIZTc0bHpWL0w5?=
 =?utf-8?B?YjdpK0JlRmxRbW5rRjNrVlJrYlVjbjA3MXhxQm9LUU9KbCt6M1JqSnZTbFNQ?=
 =?utf-8?B?RC9DUWJlU0t2TU4xa1hLOUkzazZGU200YzIrdXhmWTdUMkd5Z0NzVU9Pend2?=
 =?utf-8?B?Q1p3TXBIQ1dGWkNwbDA2eHhrL1Bwc2N4RWFJMFdMTEEycjNlRjJ6cWtMNU5E?=
 =?utf-8?B?ZGdWRWppY2g1Kytmd21wL3hHRXJiUG94THpQMUVPZUFWRnpmaUhod0lDVHA5?=
 =?utf-8?B?V3pPV25yOThldEVvVGRPUXdCUW1LNU9FUjNwdmMzbG1sOFRwZ0c2N1JYNEZK?=
 =?utf-8?B?ZkcxcGhGSHpNQXJrMS9HbTFIM2NLMFhQalpIcU5SZ1FtVjJrTEUxZjhSWHM0?=
 =?utf-8?B?UncyRnN1Nk85R0pselRzV3dBMjlzZGNsNWZZeTh1R1B4cEEzOXo4ZVY3TldN?=
 =?utf-8?B?VlFlYXA4UjhvUFJ2UFpxWUR5WFI0UGUzSTdjS01wcWFjWk5vQWhOR1QxUmFq?=
 =?utf-8?B?OXNKS0RkWFc3aUMxemp5WnBWR3RCTm5pVytpTkZNNTEvZkxyY2lWS3MrQ2gr?=
 =?utf-8?B?Y0l6ZVlwSWV4NGFBSURYUWdhaU5GeXVSeTQzM3VlMjZtL0xwcUVVYkZzMVo3?=
 =?utf-8?B?OXV6Mk1NMS8zWUJ6d2dCSTBvY2R1ZERQSUZpbHBpaUhBaTlGN3Q4bG9YTHNQ?=
 =?utf-8?B?ekt2R2ZvNTdCWitTcXJMenh5MksrektHWjVuK3JCNnZ2b0p0MHRuTElSSC9m?=
 =?utf-8?B?NlM0UEdOc2lwWHN0WkwxZC9PeE5jR2tNdXlib1UwK3c1UzEzZFhvdHNSRFha?=
 =?utf-8?B?dEhYZUhFZENsYW1QZ0FmMyswYmVBOTBRcnlqTzBQbUpjWGk2bWZsUDd6NjEz?=
 =?utf-8?B?TDZ4NG1NZHkzUks2TWxuOEhzMG16VjU1S3R3UTlPdUxRa2ZtdzRKbGN1aU9W?=
 =?utf-8?B?TWFkek9FbjFYbms5Z1ZKakZrcUpzcy9ZeEJTSVFvbkk3NnArS1JOczFFOWpE?=
 =?utf-8?B?aGpnbWQvejQvZGJ0ZXE1dnhFc2VsVGdIckFJSitpbUtGaHY3b0RHeHNyZFJZ?=
 =?utf-8?B?OHBRMkJjRUY0WWloNGZlMDMvdTE2U2pVYmRzenhienFMa29HK0NkdkNvOGJ6?=
 =?utf-8?B?YkIxMm56ZXNtM0VuNGpBcFlWeUxvbUM0dXdycHBHWDFMMGhnSXc1Sm9ReTdV?=
 =?utf-8?B?T0dwRk9GeXM1cGovVUhOMnJoLzdGc2V5VnlEL3IyaVdCMWswVklsaE5OVDRr?=
 =?utf-8?B?Y2J6a052Z3FtNjVIQVd5UE1tRGkxd05YSmZnekRkbTEzbFVxZVpUdVNpMGx2?=
 =?utf-8?B?MmdhaThBWElURFE1VlRmdEZNUFZGampIWklYVkgwTU9XVVRPdTlJWjZlZ2sx?=
 =?utf-8?B?OU5NNm1KTWsweGVjOTlHYjVZM2hRbDNSdUIyWkRyblRnN3hQZTJXWC8xYlYr?=
 =?utf-8?B?NWJmd3JuUFp4UTJCZDJLT0ladkwxOXdvM2swRUFEWTJub2tad0YvdDNidkFF?=
 =?utf-8?B?ZUZyNGZIbFcwbS9DTjJ6VDNwV2FiYnZrdEpoSmcvbG1UZmMzN3AxOFRoQnQ4?=
 =?utf-8?B?bEZndmVHLzNlUjUwTjU2cXRZNXJ6MjNRSUpMaGFkQTdkRXJrTnhWSHZNWDho?=
 =?utf-8?B?MS94cmJaL0RMM2txNXJCMDBZWE94VGdKY3c2MmRCOWVZME55Sks4TC9EaTYz?=
 =?utf-8?B?d0hGdEVGWFpkQjE5dWZtNHNZWCtoeXhwMTh1RE9EaG4zWkRRRUUzeklXV2wz?=
 =?utf-8?B?SjJiM3pmQTljQTRWSXpoemFpVGpmUENFRGs1RXNjeEFPbUhaYmtPQXVRM2t5?=
 =?utf-8?B?elc4OWthUkEyQ0srVnh2KzgvejQ2Yzc4Q3V1bmlFdUY0QkRnNTY1eDc0bWhM?=
 =?utf-8?B?RURhMllGVHRDZUVaUHduYThnSUJMRS83aG13T2I4QStrQUZpRHNWUk9kNEhR?=
 =?utf-8?B?SWdEbE1ldnpibDZaRWhyOVM0L1AyQzUyalA1Nmp2RnExemJERGVyUkh1c0dW?=
 =?utf-8?Q?xgiSLMoAvM/hziQL6DUtUYk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e459bf-ebbe-4fbc-b75c-08de1316f353
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:04:02.9204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 55rIT5VEEZVGVRl4ypyb0cHtfKZlLI9QSlFj2imTd5jl7rGJkAZGp3NwL98M45oYpJewqvpyECIf83Pyxwe1fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4675

On Thu, Oct 23, 2025 at 11:27:09PM -0400, Frank Li wrote:
> On Thu, Oct 23, 2025 at 04:18:51PM +0900, Koichiro Den wrote:
> > Hi all,
> >
> > Motivation
> > ==========
> >
> > On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> > does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> > result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> > (EP) is not possible even if we would add implementation to create a MSI
> > domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> > traffic must fall back to doorbells (polling). In addition, BAR resources
> > are scarce, which makes it difficult to dedicate a BAR solely to an
> > NTB/msi window.
> >
> > This RFC introduces a generic interrupt backend for NTB. The existing MSI
> > path is converted to a backend, and a new DW eDMA test-interrupt backend
> > provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> > parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> > windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> > The vNTB EPF and ntb_transport are taught about offsets.
> 
> Map multi address to one bar is quite valuable, so we can start it as the
> first steps.
> 
> But I have a problem about DWC iATU address map mode. for example, bar0
> to cpu address 0x8000000 (Local CPU).  but difference RC system, at RC side
> bar0 address is variable. May be 0xa000_0000 (RC side), maybe 0xc000_0000
> (RC side).
> 
> Set bar0 mapping before linkup.
> 
> How do you know PCI bus address is 0xa0000000 or 0xc0000000.

Thanks for the comment.

For vNTB this is done in two steps:

1). In the epf_ntb_bind() path we call pci_epc_map_inbound() with
    epf_bar->phys_addr == 0. On the DWC side this only triggers
    dw_pcie_ep_set_bar_init() and does not program an inbound iATU yet.
    (pls see Patch #5).
2). Later, when ntb_transport's link work runs and we actually need to
    set up Address Match inbound window(s), pci_epc_map_inbound() is called
    again with epf_bar->phys_addr != 0 (and an offset for the sub‑range). At
    that point the RC has already enumerated the device and assigned the BAR,
    so dw_pcie_ep_map_inbound() reads back the assigned BAR value via
    dw_pcie_ep_read_bar_assigned(), computes pci_addr = base + offset, and
    programs the inbound iATU in Address Match mode (again, Patch #5 is
    relevant).

Because we do not program the inbound iATU before enumeration, we don't
need to know upfront whether the RC will place BAR0 at 0xa000_0000 or
0xc000_0000. We read the assigned address right before the actual
programming (again, see the Patch #5). Am I missing something?

-Koichiro

> 
> Frank
> 
> >
> > Backend selection is automatic: if MSI is available we use the MSI backend.
> > Otherwise, if enabled, the DW eDMA backend is used. If neither is
> > available, we continue to use doorbells. Existing systems remain unaffected
> > unless use_intr=1 is set.
> >
> > Example layout (R-Car S4):
> >
> >   BAR0: Config/Spad
> >   BAR2 [0x00000-0xF0000]: MW1 (data)
> >   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
> >   BAR4: Doorbell
> >
> >   # The corresponding configfs settings (see Patch #25):
> >   echo 0xF0000 > ./mw1
> >   echo 0x8000  > ./mw2
> >   echo 0xF0000 > ./mw2_offset
> >   echo 2       > ./mw1_bar
> >   echo 2       > ./mw2_bar
> >
> > Summary of changes
> > ==================
> >
> > * NTB core/transport
> >   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
> >   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
> >   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
> >   - Support offsetted partial MWs in ntb_transport.
> >   - Hardening for peer-reported interrupt values and minor cleanups.
> >
> > * PCI Endpoint core and DWC EP controller
> >   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
> >   - Implement inbound mapping for DesignWare EP (Address Match mode), with
> >     tracking of multiple inbound iATU entries per BAR and proper teardown.
> >
> > * EPF vNTB
> >   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
> >   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
> >     set_bar().
> >   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
> >
> > * DW eDMA
> >   - Add self-interrupt registration and expose test-IRQ register offsets.
> >   - Provide dw_edma_find_by_child().
> >
> > * Renesas R-Car
> >   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
> >
> > * Documentation
> >
> > Patch layout
> > ============
> >
> > * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> > * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> > * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> > * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> > * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> > * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> > * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> > * Patch 25      : Documentation updates
> >
> > Tested on
> > =========
> >
> > * Renesas R-Car S4 Spider
> > * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
> >
> > Performance measurement
> > =======================
> >
> > Even without the DMA acceleration patches for R-Car S4 (which I keep
> > separate from this RFC patch series), enabling RC-to-EP interrupts
> > dramatically improves NTB latency on R-Car S4:
> >
> > * Before this patch series (NB. use_msi doesn't work on R-Car S4)
> >
> >   # Server: sockperf server -i 0.0.0.0
> >   # Client: sockperf ping-pong -i $SERVER_IP
> >   ========= Printing statistics for Server No: 0
> >   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
> >   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
> >         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
> >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> >   Summary: Latency is 5995.680 usec
> >   Total 45 observations; each percentile contains 0.45 observations
> >   ---> <MAX> observation = 6121.137
> >   ---> percentile 99.999 = 6121.137
> >   ---> percentile 99.990 = 6121.137
> >   ---> percentile 99.900 = 6121.137
> >   ---> percentile 99.000 = 6121.137
> >   ---> percentile 90.000 = 6099.178
> >   ---> percentile 75.000 = 6054.418
> >   ---> percentile 50.000 = 5993.040
> >   ---> percentile 25.000 = 5935.021
> >   ---> <MIN> observation = 5883.362
> >
> > * With this series (use_intr=1)
> >
> >   # Server: sockperf server -i 0.0.0.0
> >   # Client: sockperf ping-pong -i $SERVER_IP
> >   ========= Printing statistics for Server No: 0
> >   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
> >   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
> >         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
> >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> >   Summary: Latency is 127.677 usec
> >   Total 2145 observations; each percentile contains 21.45 observations
> >   ---> <MAX> observation =  446.691
> >   ---> percentile 99.999 =  446.691
> >   ---> percentile 99.990 =  446.691
> >   ---> percentile 99.900 =  291.234
> >   ---> percentile 99.000 =  221.515
> >   ---> percentile 90.000 =  149.277
> >   ---> percentile 75.000 =  124.497
> >   ---> percentile 50.000 =  121.137
> >   ---> percentile 25.000 =  119.037
> >   ---> <MIN> observation =  113.637
> >
> > Feedback welcome on both the approach and the splitting/routing preference.
> >
> > (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> > later if preferred.)
> >
> > Thanks for reviewing.
> >
> >
> > Koichiro Den (25):
> >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> >     access
> >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> >   NTB: epf: Handle mwN_offset for inbound MW regions
> >   PCI: endpoint: Add inbound mapping ops to EPC core
> >   PCI: dwc: ep: Implement EPC inbound mapping support
> >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> >   NTB: Add offset parameter to MW translation APIs
> >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> >     present
> >   NTB: ntb_transport: Support offsetted partial memory windows
> >   NTB/msi: Support offsetted partial memory window for MSI
> >   NTB/msi: Do not force MW to its maximum possible size
> >   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
> >   NTB/msi: Skip mw_set_trans() if already configured
> >   NTB/msi: Add a inner loop for PCI-MSI cases
> >   dmaengine: dw-edma: Add self-interrupt registration API
> >   dmaengine: dw-edma: Expose self-IRQ register offsets
> >   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
> >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> >   NTB: epf: vntb: Implement .get_pci_epc() callback
> >   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
> >   NTB: Introduce generic interrupt backend abstraction and convert MSI
> >   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
> >   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
> >   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
> >   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> >     usage
> >
> >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> >  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
> >  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
> >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
> >  drivers/ntb/Kconfig                           |  15 ++
> >  drivers/ntb/Makefile                          |   6 +-
> >  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
> >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
> >  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
> >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
> >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
> >  drivers/ntb/intr_common.c                     |  61 +++++
> >  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
> >  drivers/ntb/msi.c                             | 186 +++++++------
> >  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
> >  drivers/ntb/test/ntb_msi_test.c               |  26 +-
> >  drivers/ntb/test/ntb_perf.c                   |   4 +-
> >  drivers/ntb/test/ntb_tool.c                   |   6 +-
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
> >  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
> >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
> >  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
> >  include/linux/dma/edma.h                      |  31 +++
> >  include/linux/ntb.h                           | 134 +++++++---
> >  include/linux/pci-epc.h                       |  11 +
> >  29 files changed, 1310 insertions(+), 300 deletions(-)
> >  create mode 100644 drivers/ntb/intr_common.c
> >  create mode 100644 drivers/ntb/intr_dw_edma.c
> >
> > --
> > 2.48.1
> >

