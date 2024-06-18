Return-Path: <dmaengine+bounces-2406-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E94D90D2AE
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 15:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931211C22D3F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E0E15AD9E;
	Tue, 18 Jun 2024 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fCxW8luP"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546DF15AD95
	for <dmaengine@vger.kernel.org>; Tue, 18 Jun 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716999; cv=fail; b=GaPK9766pK9+LIheaGWaEiN5A8sDr4lABg5iYKzNUmVqHCr1cRDaARyHYvgofxpr40ewQbQCqXs0U0YevQV9kkxqrOWWIrYnTLuAFY+r+vQE3BAw4rbNSsLiC3moz9fuUFNAhf5P2HjUG47moap2aNxYWtgERWAnzCtrJtXE4a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716999; c=relaxed/simple;
	bh=XtRSGyiCK2OYxL1wQgoHF1/Fh3Xm4xRJQtU2YLcY2AM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tj24ewAlNePfiwNdMB5fwc4jJIRYRzqDAqpsexYUQFPnkZ4/jgvilxjYr+YtUs1mObPTlGTs8S7DKJu09IJFD+C8BgQ2kDYhReNZUzqlqqUcMXJ5Lca7cfuubbQj2zF2pSeOZ7pS+94izRrDeg878w5d37jFQVqgHMbvxS0Tk+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fCxW8luP; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KodIYn7EtwfZyHMHiFBMRRGX+h8LbcayCO94j7W2LWGWb6Z0YLAdTWDiQv7wP4Bj7RezhBXw9sHLcox+KroLfY3njW3+SNnVeP2wECN88jO7ROk3KhBKg5S4ghs0KsScnZky6zavnmn+7m7RNkHJsQgpGS1NQ5YSEcXfhEcxowMr4a46eyO/sakO+d3kRjDmX31y12juvbfym/Fj+jBQrbYZjM9uT2OKj4Y5de2ORKMz90aaLatXh7STmZkfMg7FPbrOJEfu3Wybii2HKgJC0osupMmsiJfVrESLsmMCRhvsW2qiXCBWGXjjOzuLfEJ6ap5qqn0Vs7HCsDR41vJPEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv1k+2/MQGx9nXofQsdXG9dFIMmU+aMG9Oi7kM7c96Y=;
 b=aEx+S9TyI7EP6mI9YAHt+kQU2bF/gnKmrGC3qjXFyqlukAIsRt8moqHWo/cmkytJtlt0YDW9+JdYVB8AFWFXmRJOpW/h9o8/eOQ7+w/Si+rTw2z9G9BngLF1NCcSmMudZAnHrEP8LGV40dCAfphENyTCpNsB5d70tH9OVG92VbmETuuov4dtKBnKGe20F48mH9U5KYdIpd2sutRRtnKPLcKgWxqex5A1HCMTLbtyn8hmT1syMQzbNGeQEkwNIrM0BVpQ6ioIC4sVkumZVFroFVyELpSfSfLMcba1jP4mtfLMtidUmJtemPH7dnO07h6i4KWF4s5yblocQdIfbjwRvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv1k+2/MQGx9nXofQsdXG9dFIMmU+aMG9Oi7kM7c96Y=;
 b=fCxW8luP63KJuSzc4ZC8UF3bMiHBKUdKbBqfjzNAMPaD+4T2tG5rke10tfGj8QveanDKtrsr5UE7DR8YdwyPqPV9ervPMrnwO0WP0XS+X1soli87gsFK06P2iEyPmyrNKKTnfxo4V0DBlF/4mU5hC46vJH4M3y5pshqNTTUMpk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 13:23:14 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 13:23:14 +0000
Message-ID: <5bbeebbc-532e-45d7-865c-8ad057b4d429@amd.com>
Date: Tue, 18 Jun 2024 18:53:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
To: Bjorn Helgaas <helgaas@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
 Frank.li@nxp.com
References: <20240617164041.GA1217135@bhelgaas>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240617164041.GA1217135@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0133.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4699e9-02fc-4a6b-4eb9-08dc8f99cea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wm1EcXJjQnl4TFk2Z25GQTlZTWIzMTMvSUlTcUxQc1lBSUNIeGxYQlk5eFY4?=
 =?utf-8?B?bUJ6THVzSEoxcmR0RGxDbmJYVDloSXl0RHRHWUpBQ3pjN3JlTjg0UFVqemwy?=
 =?utf-8?B?dlNQNWdUQktLaUZWaVdFV3h0cGVrWmZCa1QyOVhEMzF0N3FHQXNaNE5UV2VP?=
 =?utf-8?B?MGZicTVwNjd3RlBwWW5sNjN5OHRKa2ZRVnJoaC9ienpNNWtlTS9tSHpZcjVG?=
 =?utf-8?B?VHlOV0ZFUTF0KzV2dXNuRUYrUEd1WkMrRVZlMFQyZzJpYzZSbnNzK0EyTHc2?=
 =?utf-8?B?Qi85RCt6elBVZVJJUVNCd0M0VlJ3VHhDWmNNbllMQStUeGJ5SlRiWUhKYi9L?=
 =?utf-8?B?cnpRRE9rKytEUUxkZ0tLNnhCUERWcE9pYVVMdG9zTitCbXFrUjVmMDZQWDJQ?=
 =?utf-8?B?WHZWd1pmR2lkakRNTk5SRkx3UXNRSU0yQytsc3VKRHVZM2tqSU5jWEZYbGNO?=
 =?utf-8?B?YldLT0RoQURodldGSFBLSm1QTmliT1BkSStSKzZ6Vm9TcVFmYjBadXBLaWk1?=
 =?utf-8?B?L3ZSMTVoOGo2QjBlNWRYenZTK01qazV6MGFiYzIzMlNvd1dKbFFiQ2crZXdF?=
 =?utf-8?B?VnRJZ3VhcSt0b2ZJSDJ2VU1QRkcydGIrVkdydTlEcUxCRVF6cHZ1KzQyVmFi?=
 =?utf-8?B?NWx5dVQ3bEZ2Smk5THdpd3UwV3hnbXVVcUJLNHY3cjc0Ulh2REZDSkRvb0R0?=
 =?utf-8?B?WERuTmxWQ3dYVmtVcyt0QitWaVhvZnNEVVU2NzIyK3R2eXZhQjUwblgvSXdY?=
 =?utf-8?B?WFVHdWpteUNwN0F4WVVGRU5hVzRhaDR2aVV0c1p5UHVLc0FSNnkwWGdNdml0?=
 =?utf-8?B?SElqOUJXSUNuTjlobzhlQ2NnSS83eHBleW9CVlRJSmpQUjFua3gyOVhTY2hF?=
 =?utf-8?B?RmhnSDQreGF0RDh3VUFYK0dxajMxOGJ4SnZ6Y3JGbjZUWVZnbVB1c2tRSnk5?=
 =?utf-8?B?N2hVdjQ4TndTSERWci9KQTl0bkgyMXlULzNLVFhORE9Ya083aGlpUVEvNGNK?=
 =?utf-8?B?QitPNjgzSUxtZWZGQXlBbmk2N0JNNnZlcHpxcGVaNGdkMkpKQXIzV1FtR1Nz?=
 =?utf-8?B?Nzdyd1lWc29qRUtpQzhYdkhRQ1dzeStPMGlMbExYekhqSnFxcXpIMWppNG9m?=
 =?utf-8?B?cmRuamIydllST3llUFFTMzBxc2dsU3hES09XSmIySDh0OHJxUTJQeVVKKzBG?=
 =?utf-8?B?VmxhOWN1TkM1eEc2MGw4REpjVmFQT09DQ0ZsaS9kcnBCTXBIeHllejRTYXh5?=
 =?utf-8?B?L3BaVXNYc0h4QTFxemhRWk0wNk5jQzAyTVBWaGw0UXVaL1dBYzdSYXpGeWpL?=
 =?utf-8?B?WjJkbFlWN3d5Y1ZCL0FvVlMwbUFreVg3d2o4d0VjRU9pSXlTaFNFbzgyUlRH?=
 =?utf-8?B?L3pOOGFaTmVlVkxrRmk3S2dpRVBYSjFDbnM3Qy9uV3k0YXZDd1ZqcGdnUFRG?=
 =?utf-8?B?RmNXWXk1Z0w5NnZhT005c0NLRjVlVTVOTy9CZUxpb3dOUFZEaDhVTHBnbmpt?=
 =?utf-8?B?VWYyc09lems2cUxpcDRwLzljT2QxOUtWQWNhaXFYcG8wdU9iU1dzeit4K0U3?=
 =?utf-8?B?Q05tcXptUzNVandjUi8zbVJsK0V0RzNyb0p3clZvS0dSS1NNL0ZudGtxSlkx?=
 =?utf-8?B?NXNUVWc3cS83NUdqbFRLNkk1OURVemN2WWF4WlFoVVZFNU1DSWdyc1ZZNUJu?=
 =?utf-8?B?NUpGQnpRRW12ZmhWalN6ajgzVDIwU0loWFFoWEMwVytINDIrVHBTOEJSNmcy?=
 =?utf-8?Q?pN6k/Gh0itJBX9SvzM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzNRODE2cEJFeWwzcGl6WHVuZlVvQWlKTUl6RjBreUtPbUY1WFQvRzdMNnNt?=
 =?utf-8?B?TUhlZ1dTOHRNZlRnWGc4RG9nS2xRNk9QMW0yMWp5RXhuWnpyT3BISjVpbnMw?=
 =?utf-8?B?TEkveEloRTkwMmhyTjhNS2sxcVlacHpYdzkzWEdkWkdIYXVGSUdYNzltQS9G?=
 =?utf-8?B?ZXNHMWRKSjhxbEFNTFYyekRPcUlUWW16blpuRVVlMmVQeUFuekpWcExtNys3?=
 =?utf-8?B?N2p5WjFLYjdVd1JxKzVnNTNKVTVPeFI0QWQwQjlTUWdoWHlZQS9TcW1ESVIw?=
 =?utf-8?B?R3pMeWJONjVmMVU0aVI5N2djSmhXMlZEOXlTdFFqVzJmUkNHalFZNXhkRmYz?=
 =?utf-8?B?R24wWS9uZHlXaU9OTVpOQW05eWxRUVNKS256Mk9BY0Rab0hLNHFwVFJBT090?=
 =?utf-8?B?SUJmMzZaM0lJRDFZb1ViL1o4THZuY1lvMGF0ZWYxU29BZ2JBNUNNVEk5V3hQ?=
 =?utf-8?B?M2lCVm5DczF3eDk1ZC83c2RoQXRvRUplby9ld1pQSU5QR01ObzdZN1dRWnFT?=
 =?utf-8?B?OVprVjdBZ2F6UVVVTlBCNk9WQjJtdE01dHJEcXdiMjMwRHJhUFdUSkRXbDF1?=
 =?utf-8?B?K3FUVUdoWWNXdll2OGZlbmFOVWNlSDRJRVpmVDJJQ3RIOFhtWm01VmZTMXFk?=
 =?utf-8?B?RlhEMnY4WjhzWDRjc2Y4VE1jZVNreHFnQ3B0dlNVVVhKU25xOUhheDZJcmY2?=
 =?utf-8?B?V09tZjdWclArOHdMR2s4c3laWHV1dnZQenJJcndLVnc4ZS9qeDNMaTQweFFX?=
 =?utf-8?B?K0liY2pmN1ZMbFczeFZ1SnpkWXRLMmxsZEIzbms3a1BuOURaZGJNSmFld3dR?=
 =?utf-8?B?akIzMm9nREFwMGpacTdtTmxJVU5pNFRJdFFBM1B2Z2NsN3R5TmVZajJUdmdy?=
 =?utf-8?B?K2xQQWIyRWdhUEFDUFRjMHFmSnp5dlQrSkRIUUhyNk1DdDhEWW5CM3ZBa2tK?=
 =?utf-8?B?M2tPcGFqc1hVanhlb2xuRUhtY2I0WlVDRWk0eWFWS0Vja2ZQVktraHliK3pC?=
 =?utf-8?B?UXplb3hra1p1allIWFZCa01iYy9GYzFUUGVobC9hSFVqUGdmUjNMR212ZHVS?=
 =?utf-8?B?ZlNHcHpkWkdYQURWL0o5OFIwanNJNDV6WVVCSzQvTDVldkFNektyQTI5N0hT?=
 =?utf-8?B?RmtCS0UreVZ5VnU2Vm41MDE3ZStSTE0vRHoraTc2aDhZWWtDV1RJcHBiS0dH?=
 =?utf-8?B?QldhNmNpNmt0czdFcE8wSjc0eGVTdHM5Q2RNd2xwV3BOVFpwejE0NTUyM3Vj?=
 =?utf-8?B?Mm5RZnpWTTRIb1dEVXBubG03SVl3ZUc2TTMwUWtlVWJVbERwVnFRTURNY1R1?=
 =?utf-8?B?LzZZOFZKWDVnektlOGdIcGRFVE1kR2tpTUdnaDZ2YVE3UmFiTE94SVVPZERI?=
 =?utf-8?B?TVFGVjRMVk1Jb3d5cmExZk1pWTN1YURPbXhoTjR2ak1Lb2NQUzBPWEYwV0Nm?=
 =?utf-8?B?MlRyeHRRVjdDN2szblJ4Tlo3SWkyaExaaW1Fc3RMditFMDhDbTVYamV2R1I1?=
 =?utf-8?B?WnpqVXJCSWxzWmRLUXJ5QXNFRDIxUzVYRFJrbVR6WHdJa1FhUkpCT1BEUXhQ?=
 =?utf-8?B?dm5takFqZUZ4dGIxTTlvUlJRMlZkQ0tOZjdNWHBISVBjT1JENjZFcmJ2NnZU?=
 =?utf-8?B?czhDdTk0ZldvVkxhTWhlYjA1WmJGRk93NUwxaFJPQzFpNGsrWXpnWGNndW5Z?=
 =?utf-8?B?ZlR3bklvMWFzSG9sZXMveU9MTk1sSnB6NkJ2VHJkd3dBeE10M25URXltWHFv?=
 =?utf-8?B?RHZXTElSZ0VwNHBvUFdQOGJRdjJtbjBGNGJyK2NnV2MyV3NGZ2Z6c0U2REpk?=
 =?utf-8?B?b3RGbjRoME9hS2xEd2RiUnhDYjNYbGtSeDU2REVpdFNMa1Z0TGF1Z0tlQm9l?=
 =?utf-8?B?cDlTcTJFUWpSS3NwczJwclNSaXpVeUp4eU4wekg1Z1o2N0Vud2RvWkV5MTdT?=
 =?utf-8?B?Y2IwSDEzN1lXbWFISi9GK2VJb05YdFI1ekkwbWkvd094TGRwaVAybGZITDE5?=
 =?utf-8?B?Qmo5c1hCNTNiekxNSVNuN09Kc29KZmNJUGNlZmQ4YTRJM1A1VGZDUXc2MjRw?=
 =?utf-8?B?Zm9qV3p6UWVmNEFqRE9lcm4xRDFmazc1SnBSMnBwdHRrT1JFNm5TUFcwSitS?=
 =?utf-8?Q?sNLwtB5WKSY8gbfqui/sGoWnb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4699e9-02fc-4a6b-4eb9-08dc8f99cea1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 13:23:14.3239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA3OoaBxGnUjct7YhKD+Ett0eFaBlNzdjE9GecC+APu+48aF7r/4GspKgJkUU8uBN7A6tj2E+Qkj91JQSiXUOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766



On 6/17/2024 10:10 PM, Bjorn Helgaas wrote:
> On Mon, Jun 17, 2024 at 03:33:54PM +0530, Basavaraj Natikar wrote:
>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>> memory to memory and IO copy operation. Device commands are managed
>> via a circular queue of 'descriptors', each of which specifies source
>> and destination addresses for copying a single buffer of data.
>> +++ b/drivers/dma/amd/ae4dma/Kconfig
>> @@ -0,0 +1,13 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +config AMD_AE4DMA
>> +	tristate  "AMD AE4DMA Engine"
>> +	depends on X86_64 && PCI
> Possible "(X86_64 || COMPILE_TEST)"?

Sure i will change this to "depends on (X86_64 || COMPILE_TEST) && PCI"

>
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> +static int ae4_get_irqs(struct ae4_device *ae4)
>> +{
>> +	struct pt_device *pt = &ae4->pt;
>> +	struct device *dev = pt->dev;
>> +	int ret;
>> +
>> +	ret = ae4_get_msix_irqs(ae4);
>> +	if (!ret)
>> +		return 0;
>> +
>> +	/* Couldn't get MSI-X vectors, try MSI */
>> +	dev_err(dev, "could not enable MSI-X (%d), trying MSI\n", ret);
>> +	ret = ae4_get_msi_irq(ae4);
>> +	if (!ret)
>> +		return 0;
> Consider pci_alloc_irq_vectors() and pci_free_irq_vectors() here.

Sure, I will change all code to use pci_alloc_irq_vectors

Thanks,
--
Basavaraj

>
>> +	/* Couldn't get MSI interrupt */
>> +	dev_err(dev, "could not enable MSI (%d)\n", ret);
>> +
>> +	return ret;
>> +}


