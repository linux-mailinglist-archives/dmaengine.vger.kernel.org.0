Return-Path: <dmaengine+bounces-6986-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C6FC075F0
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 18:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D0771A603A2
	for <lists+dmaengine@lfdr.de>; Fri, 24 Oct 2025 16:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ABE31D742;
	Fri, 24 Oct 2025 16:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ypj+xsjM"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011060.outbound.protection.outlook.com [40.107.130.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9E2DC787;
	Fri, 24 Oct 2025 16:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324245; cv=fail; b=HfiSkZuAo8RLxJyUXuo7+L9KqZ2aFR2kNrI8d4Q2L+EOcWBqxHviZMUt/6Uh6NIIayTO8a1qH+AYdtMqoILnEZJ+Dkg+zEHXotrAQNiAUfuzNICVQ1h2kEKJvRtrDSrLTewT9H0wg5evWZj8TlOhmDpV2H7VOhE3T8c6hVBYarw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324245; c=relaxed/simple;
	bh=M9b9/pBVLgNQs++GXKteJ4yrLFz/n4ElNqTXRBnEJEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lrdfKWtAFVUpVy8DtnfqxxFmzyZPC+7TBW0xDIFyeLYl3rWFMM2uD66IcHllW2RWQbYYD0tJxSuJL77Ae7Fkpi29ZkUAkv4wdLaqLAKkiVUrEGzsBietKavS1PkEIJUKUSUObMan6Bgn4Dcvv97l6Ou7mZei6o1p8CXILu0urrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ypj+xsjM; arc=fail smtp.client-ip=40.107.130.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nykS0CkxVhhuuMHse8oboEjtzBtYCEVUrgcRmmuiAStdM2Cww2y97vHZf3PI3uqx1GsAHmohCyngrxb3tIoyuM34PxDfSiMNwsuGBguL+CZOOIY1gRfON7rYyeijTr4bdUveZHA90+ON4P3cv4noH2ofy8uSHpW+B391Xmrp/DfSnYndNRxW2mRtYrSphItVFC93AXnPNYRqFSWVRirv1WLj4yoP85J6/Ua3f6sEVheA5g24JzxpdinOjRC2rQpP9grq7M/lOsJKzj/aF5g4ELmma0YG65l546WUQ6kNP4Ui0zH3tfrHGtGdsnlvVpD1RiI6BpxKWQyTe3XJ/NsJcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5IvFThGBAqZtNeTuFkHrNA/yOnd/vWuu5naRe4KLF0=;
 b=nWo1EiH4l9WJyxgw6MBXcSoOBZjrA60t+MYAtwqs8aaLtsl44paB6WWAWlxWHLOzIltR5tocKUEA8/RCWCd9xecNv0lsM1y70Hx/b4nq4abj1OEF4yTDDLwhLh2yNtI7A9jdKNErLoecD97mErnr7CAc/EYhEtylVv5dCPsadq5L0c941AEt+Pja/gFiIbPceHNkr4vn+tfDMX6V/VawiMSL2DRYPtSpiXDE3BIF6w4wBozwrXkLCvBiRs9l4ypyFQg+/cKesglKTC5hTp5PmRimT6AVwXixffZ4kZg10IDnxpzJN5l+se/dKK9mw6Jnfi7R/uoCOE6HbGxzSD85tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5IvFThGBAqZtNeTuFkHrNA/yOnd/vWuu5naRe4KLF0=;
 b=Ypj+xsjMhIlf1Vtp5VGEYswCNr0juAn5lokLMosVFMxMPpCOoH/Rv3OmWpnC93Wd1JbbRgSFoxnzN2+RkD7L32iAKhn01PaGRJshivz9C8sMCaN5iLtzQ63EjrHdiwW1r8ROCfToIE85yXVrkNyQIgXNcFA3o9Y2LRijHLqgV4j9yHw5bD1hWYamwhVysKDHxxu7Ajr31rWfiq7Sv5kPn/oP8XRAbiK5UHDPzKCA6+l4uy17cK68M3JRc9tjMNNEiAYKQ94g0WwLnjoiHNQyTNTCyNgtZeStcL8wd2VIVNonZcvL0hxdzamaactPS8aFo9L1ZEDPg7LuiAypG/Hweg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by DU4PR04MB11457.eurprd04.prod.outlook.com (2603:10a6:10:5ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 16:43:58 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::55ef:fa41:b021:b5dd%4]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 16:43:58 +0000
Date: Fri, 24 Oct 2025 12:43:47 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW
 offsets
Message-ID: <aPusw9M5kRA8G6NC@lizhi-Precision-Tower-5810>
References: <20251023071916.901355-1-den@valinux.co.jp>
 <aPryDenvU7VTYpBp@lizhi-Precision-Tower-5810>
 <p6a5rfawgs3vcycm6ku23jpx4nhtmbuououfyfsypqli5t6zin@lekmytllocmc>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <p6a5rfawgs3vcycm6ku23jpx4nhtmbuououfyfsypqli5t6zin@lekmytllocmc>
X-ClientProxiedBy: SJ0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::14) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|DU4PR04MB11457:EE_
X-MS-Office365-Filtering-Correlation-Id: f81de0b4-0cbf-4add-f8dd-08de131c872a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|19092799006|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFFxNm5tVzE2aW1zZlgyRjNoS1V5eHM4VlZRMklDOGpFamN3dUwwcFhEdjBl?=
 =?utf-8?B?eExuWTVTeVpPK1Y0TnorcVNabnFvYyt5eGtGNmhueFkyNnliNTBwZmxOSGd6?=
 =?utf-8?B?c1QrcVRDNzJZaW5tTXBRRkZ2MGhIQjAyQ3phTlpmTFU0RGtwODdZUExieE9G?=
 =?utf-8?B?eEtEM0NFU1NkVDFpWkxrVFV2Z2k1RFE1bEhrQzZSMlhVcVJ5ZGhWZEpBdnZM?=
 =?utf-8?B?YUhxY2lzbWYrZ0dyV2ZmMFFhVmdqcHBOK0tCa0dhTEMxZHRFRGtkc2Q0UWcv?=
 =?utf-8?B?Yk5JMEZjQ0JsK1BtOEt5Kzl5anRDSDRES3ZDU041OXZTRWlYbS9oL1BFRWpy?=
 =?utf-8?B?UDE2cEdrWWk0WXc5Vm5TRnc4bzU3YUJRRHZIMnhnTHh1QndMakwzUXJhUWdN?=
 =?utf-8?B?QWFNL1RDcGZkdDExQUEySXdEOHFZVng3Zy84a0JqdkVIM3kyYzFyY05XRTlC?=
 =?utf-8?B?NC9nVEpjVytwMkhpOVZLenhTdWlvNXZhdnc2WmFFRnFTS3B2eWZiaEV6Wkt6?=
 =?utf-8?B?QW9PNVJJTys2a01qOThIOERYZ2pleDZiYkpmS2RUQUtuUGhSV0s0V0lXNXhH?=
 =?utf-8?B?c21KakpyeEpad1RKci9uS1FFN2VqMCthZGMvd0VMS0pDWTYxdi8rT01XZWR4?=
 =?utf-8?B?bm9FenRmNWJOVVVHKzRsVGtaU0hHUHZjQ013eVlhRGpMdmg0ak5rT1NLcnJa?=
 =?utf-8?B?aytsUm5odXhhMk9jd3phYU1NK3pLSUgwN3BkOVJoayt4V2F1Nk05ZitxUGhE?=
 =?utf-8?B?WFh0Zi9wd0lacXVPVGFMS2ZKNjdzaTJhVjNHVlBWaEk5bnhHdUF3SjRZZXN4?=
 =?utf-8?B?R0NkdmRjdWp2MkFJb2hOVHU2SVp0by9OUXp2ZEJoWWNFTWNiRFg3THd4bWhO?=
 =?utf-8?B?a2pmRUFZVUlLUnpGc1NJTS9kZlVpc1dLY0p3NFExemJ0Ymp6SVprYW1wYnp2?=
 =?utf-8?B?b1pDRmt2MndHOUU4cDNGa2dSUXdFNTBPVzQ3OU1VQWRZcWNHamNVZkR4Slc5?=
 =?utf-8?B?Smtkc0V4M21wTjN3bjFPRjROVW1sRDY2Y0UvOW1UL21YYjIwQ0l4Qkh1UnFo?=
 =?utf-8?B?bnd5N2c5aURiVGY3ZWNWNitqL1BNWDFKcXNoNysxZlRNUWhNTzFQQnNsZ1dr?=
 =?utf-8?B?RWZPUHVrOVpkeUZhdnpVcTBaa0xTbDg0RHpXcjVQZkZyRU1naXYzWTdKWHFD?=
 =?utf-8?B?QlA5cVl2S05pY2I2aXYyRmVKc3Rtd0gwT2pyMURwTXdSYTJOdG1hcHE0TWRy?=
 =?utf-8?B?Smo2ektSSERJbXJuS2RhUG1Camh5S2tvTDVlODZyaXpCUmZ0U2QwRC9KWEph?=
 =?utf-8?B?QVBwNXh1QndGdUkydTN2WGFmUUdQcDBlTDVOM1A0OTRWQzM4eENQRlFsR21t?=
 =?utf-8?B?aThNdW00SlNWK1pBUmQ0c3kxbzdTSWFzZDl1cVh5Yi94MzFTTEFBa1kwUHdQ?=
 =?utf-8?B?bjFWdDBCUkFueVlJa0dybk1hakVWbGhOK0IvS2tlSFJEZzV0NmloRnVvQ1B6?=
 =?utf-8?B?UTUwZ3UxTGQxdDZ3OUE4MUczaGhNbVdpT2tGRkNGWUpNUXdad2dkRTBLRmpu?=
 =?utf-8?B?V3VveE0wWml5azVxYjllMlNrUE5zSmQ3SlNoMlBmNlRiMWk2QXFSQy84Y2pj?=
 =?utf-8?B?Mm85cGp5NklaL0ZSLzdEU3N5cHBMRUhuUDBJZkdDVVEwZTlBQXBmaXBRVjRQ?=
 =?utf-8?B?eTFXRHNKekpVR2lORlM0TWJLOHpyM3ZscFpnOUs5SGdZcnU3Z2R3MFViVmNQ?=
 =?utf-8?B?QXo1MzM2ZENRUnlncGwvSndhZUZuU29YM3VXdFVOYTM5MU00RTVBRVlFb1JN?=
 =?utf-8?B?ZE02OHhteUM5YzE5ZkIyY0tJUi9nLzBHMHR2bnVwM3RWenJ3d3dqNkZPL2ZU?=
 =?utf-8?B?RUpYRlJVTGd4RTFxOGtqTlN3NjRMdnJ1N2JmZDJpbDY3cEUrS3JSYy85Q0xT?=
 =?utf-8?B?L0g3eXlKSnRZS3MwMWNPVFRzY0NhQ2ZkK05CUElxaVZ4bDNtSDJ6OWtWcnUv?=
 =?utf-8?B?TEtKeWNzVWtoMEdoUkQ3SzBXQjZMMmR1VmJPNlZRSmpiZ3JhajBCeWVDTFRJ?=
 =?utf-8?Q?LnRtJZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(19092799006)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eFBFb2I2OCtHbmY1QkxYdGVZZmlXSnRTdFhTb2h6eWorTHZSMndnTFdqZ2ZV?=
 =?utf-8?B?Z3g4bE9lQ1NDZDFMQTJUM0NrN2pKSk1FMWo5SEhoN1RFREs5ZnVrVlBWNGs1?=
 =?utf-8?B?UDI5WWdyOHVGbStYdU8zT2FTQ1cxZTRMYVNCWEtkYVhyb2lhRXBkT0VhK3Zw?=
 =?utf-8?B?dVNib0RMN0pGTnE0VGZwM2hHelBjeW1FYUF6RzNzb3RsMzhmRy9ZVHVKSmQv?=
 =?utf-8?B?KytYbjhOOW1OVkgzR3dyZk5RdUo1ckZGakRQSEpBOTJVWERCOHhKWXF0V0VT?=
 =?utf-8?B?MUtMMWkzVGRVYm5JUm9vWWFhWWgwRCsxdWc3dS9rajJidThZbjVGZU5FU0Rn?=
 =?utf-8?B?cFR1aTk5Rm4wRHBjWTNsTVc0YmFsWFNwMUZic2dTRmhwZVRGU0h6SHgyVG9s?=
 =?utf-8?B?THdubGdCcTZpWS9BSlZkcmlIUWU4SUVwUHJZbW54MVlxMFhhV1piV2REWlht?=
 =?utf-8?B?RUFwR2YrMVk0cmY1QVY3eHZHbVBXSkhORmt3V3pVMFZxYjE1ekJCUjFrS1k5?=
 =?utf-8?B?RGRtYkRoY1VlL2ZFSGphQnN4Mi84aDJFZ0tpN3VUS1dDZzFxb1dhSnRGSlNj?=
 =?utf-8?B?WFptc3NzdG5IT3pEcWVYdFJSQzlIZndDMUNCZmJ3Z3NTSXVxOTRUSVg5VU9r?=
 =?utf-8?B?bTBpUGo2SDQ4Qi9tRW1hOGNFWHI2ZGVtSnZaTkh0WFA4Q0N1c0ttVTNENExP?=
 =?utf-8?B?VG1BdGlRSHpYbTkyZG9xTGQyT1VTL1prTWNhemdkY0J6UWFnK1A1WFJady9J?=
 =?utf-8?B?eWhQZWhBY2p1Wm53Q2tlSXFXUTZxc3dSeGpoaDhVUW5HYWFBc0dnWVFjNW53?=
 =?utf-8?B?b1RDSVBoVi9mTWdNTTdWcmhJNTFnOFRsbFBVdXEyYkNlb2FnYU5mR2UwQWx4?=
 =?utf-8?B?WUNjMDBCaWk4YWprUFBpZDdKWm9NY21NdmRPZ3FNclY2RUFPV2FTY0xwbmhz?=
 =?utf-8?B?S0lDNGdRTXQrakxsRG5iTTd3TC9KMSt0Nm9JSGdnbmdiRmVWVTU3UEtOejVC?=
 =?utf-8?B?ZTlGOHU0Y3p0cWUxcTZxNXpUV0VCcHI3a3R6NUUzamRudVIwM3JlbnQ4aStU?=
 =?utf-8?B?amRDY3R6QlN5UEFSajJ1bVZORjV4RjN5SHkvY1MyMzdhYzFjZnkya3o3bzVh?=
 =?utf-8?B?a2pVT2NQYkUyVi9ob3k0MXdoNVU2UFlNajRLc1kvZGhvTkFrYnZWdTJsN2dj?=
 =?utf-8?B?Z05KTXhaTEU2VkN4Mlc2MXdtZXZ1UW5NNUpjYUFOUTB6Y2N1d05oNHFLV3kr?=
 =?utf-8?B?R0szMkJkSnMzRHluTlROZEJpYjhuOVoyWWlvSVZhRE1La05SeEoxMXZiSDVR?=
 =?utf-8?B?T0l2TytPNVRDVjRqQmd4TVJMeUVLOGdLcVZON0tnZEd1aHkzODNXZkRQVUQ4?=
 =?utf-8?B?UDFQQ3lnOHdsR3FKWVRjRXNqT1RoV2w2QlRabGljNHpQUTM1bjFoVjcxbUli?=
 =?utf-8?B?QU1NSGhMQzE2ZjRJRzIxdjZLbXQ0aFoyd3pCeG5XVGlKak4rdjNIcGhyS0Fu?=
 =?utf-8?B?bEUxNTF4VzlCdHFzRHB1QWhEZ0QwbEtHT2ZEQ1dSUjlxU3ZsTVZ4Y2RrQVAz?=
 =?utf-8?B?RHNMQy96NTNNNjZMOGdTSjU4K2JVMHVtejF5enhWaHUrUERpOUd5MmU3eDhB?=
 =?utf-8?B?ZjdpMjdNM0VwWFpLS1U2dTVEY1lmendGd2RwRmhVTW41ZCt3bXErMitFY2VK?=
 =?utf-8?B?TFFrUUdqY3NxeDlpbmhrZ0ZWZFZ0UGlCYjRzTzNyTm1zZzRyMUZKQ2FFZHVI?=
 =?utf-8?B?TXdyQmtPM002TmI5QzZuZjRUL2V4TGM2dk5WdGhHYWxMV2x2ZklyNGZ4LzN1?=
 =?utf-8?B?MlVFcm90VXBRSVkxejVKRktWbnF2OTRvWWt5N1JIa092eGd3SW9XaEVLMnB4?=
 =?utf-8?B?Tkp2eEI1ZFkzMG8yMUxKR0xpRStrdWNRS1NqRTFvdEFyNXVKbEoxUkl0NjZT?=
 =?utf-8?B?UndYRmkyRThBbUZ4ME9VUHBmV2JENTRUY2YwQ2tIUGJXS21vd1NqU1pDQkxv?=
 =?utf-8?B?NlhjUUkwdlFycDFkK0svOTIrUUhHNTRUZ2dMNUsvSS9tVnZSUWd6a3p2cDVU?=
 =?utf-8?B?U2RrZEhLQVVOT3daaXU2Nm5sL2U0VmFUSVkwR25ia0g3L2lETlpZTG9PRzZz?=
 =?utf-8?Q?67cY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f81de0b4-0cbf-4add-f8dd-08de131c872a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 16:43:58.4146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3b0QVtaZoly6yzMnb4ppc1VVKdrPLmM6qYx2NNF9WouCWyN+ym6tXCcNbcaskl47AMHVfphtYLM1yCsciMr+5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11457

On Sat, Oct 25, 2025 at 01:04:01AM +0900, Koichiro Den wrote:
> On Thu, Oct 23, 2025 at 11:27:09PM -0400, Frank Li wrote:
> > On Thu, Oct 23, 2025 at 04:18:51PM +0900, Koichiro Den wrote:
> > > Hi all,
> > >
> > > Motivation
> > > ==========
> > >
> > > On Renesas R-Car S4 the PCIe Endpoint is DesignWare-based and the platform
> > > does not allow mapping GITS_TRANSLATER as an inbound iATU target. As a
> > > result, forwarding MSI writes from the Root Complex (RC) to the Endpoint
> > > (EP) is not possible even if we would add implementation to create a MSI
> > > domain for the vNTB device to use existing drivers/ntb/msi.c, and NTB
> > > traffic must fall back to doorbells (polling). In addition, BAR resources
> > > are scarce, which makes it difficult to dedicate a BAR solely to an
> > > NTB/msi window.
> > >
> > > This RFC introduces a generic interrupt backend for NTB. The existing MSI
> > > path is converted to a backend, and a new DW eDMA test-interrupt backend
> > > provides an RC-to-EP interrupt fallback when MSI cannot be used. In
> > > parallel, EPC/DWC gains inbound subrange mapping so multiple NTB memory
> > > windows (MWs) can share a single BAR at arbitrary offsets (via mwN_offset).
> > > The vNTB EPF and ntb_transport are taught about offsets.
> >
> > Map multi address to one bar is quite valuable, so we can start it as the
> > first steps.
> >
> > But I have a problem about DWC iATU address map mode. for example, bar0
> > to cpu address 0x8000000 (Local CPU).  but difference RC system, at RC side
> > bar0 address is variable. May be 0xa000_0000 (RC side), maybe 0xc000_0000
> > (RC side).
> >
> > Set bar0 mapping before linkup.
> >
> > How do you know PCI bus address is 0xa0000000 or 0xc0000000.
>
> Thanks for the comment.
>
> For vNTB this is done in two steps:
>
> 1). In the epf_ntb_bind() path we call pci_epc_map_inbound() with
>     epf_bar->phys_addr == 0. On the DWC side this only triggers
>     dw_pcie_ep_set_bar_init() and does not program an inbound iATU yet.
>     (pls see Patch #5).
> 2). Later, when ntb_transport's link work runs and we actually need to
>     set up Address Match inbound window(s), pci_epc_map_inbound() is called
>     again with epf_bar->phys_addr != 0 (and an offset for the sub‑range). At
>     that point the RC has already enumerated the device and assigned the BAR,
>     so dw_pcie_ep_map_inbound() reads back the assigned BAR value via
>     dw_pcie_ep_read_bar_assigned(), computes pci_addr = base + offset, and
>     programs the inbound iATU in Address Match mode (again, Patch #5 is
>     relevant).
>
> Because we do not program the inbound iATU before enumeration, we don't
> need to know upfront whether the RC will place BAR0 at 0xa000_0000 or
> 0xc000_0000. We read the assigned address right before the actual
> programming (again, see the Patch #5). Am I missing something?

This should work for vntb user case. It needs generalize for other usage
mode. maybe combine multi regions to one bar.

Add a case in pci-ep-test function drivers to let more people can review
it.

Frank

>
> -Koichiro
>
> >
> > Frank
> >
> > >
> > > Backend selection is automatic: if MSI is available we use the MSI backend.
> > > Otherwise, if enabled, the DW eDMA backend is used. If neither is
> > > available, we continue to use doorbells. Existing systems remain unaffected
> > > unless use_intr=1 is set.
> > >
> > > Example layout (R-Car S4):
> > >
> > >   BAR0: Config/Spad
> > >   BAR2 [0x00000-0xF0000]: MW1 (data)
> > >   BAR2 [0xF0000-0xF8000]: MW2 (interrupts)
> > >   BAR4: Doorbell
> > >
> > >   # The corresponding configfs settings (see Patch #25):
> > >   echo 0xF0000 > ./mw1
> > >   echo 0x8000  > ./mw2
> > >   echo 0xF0000 > ./mw2_offset
> > >   echo 2       > ./mw1_bar
> > >   echo 2       > ./mw2_bar
> > >
> > > Summary of changes
> > > ==================
> > >
> > > * NTB core/transport
> > >   - Introduce struct ntb_intr_backend and convert MSI to the new backend.
> > >   - Add DW eDMA interrupt backend (CONFIG_NTB_DW_EDMA) as MSI-less fallback.
> > >   - Rename module parameter to use_intr (keep use_msi as deprecated alias).
> > >   - Support offsetted partial MWs in ntb_transport.
> > >   - Hardening for peer-reported interrupt values and minor cleanups.
> > >
> > > * PCI Endpoint core and DWC EP controller
> > >   - Add EPC ops map_inbound()/unmap_inbound() for BAR subrange mapping.
> > >   - Implement inbound mapping for DesignWare EP (Address Match mode), with
> > >     tracking of multiple inbound iATU entries per BAR and proper teardown.
> > >
> > > * EPF vNTB
> > >   - Add mwN_offset configfs attributes and propagate offsets to inbound maps.
> > >   - Prefer pci_epc_map_inbound() when supported. Otherwise fall back to
> > >     set_bar().
> > >   - Provide .get_pci_epc() so backends can locate the common eDMA instance.
> > >
> > > * DW eDMA
> > >   - Add self-interrupt registration and expose test-IRQ register offsets.
> > >   - Provide dw_edma_find_by_child().
> > >
> > > * Renesas R-Car
> > >   - Place MW2 in BAR2 to host the interrupt window alongside the data MW.
> > >
> > > * Documentation
> > >
> > > Patch layout
> > > ============
> > >
> > > * Patches 01-11 : BAR subrange and MW offsets (EPC/DWC EP, vNTB, core helpers)
> > > * Patches 12-14 : Interrupt handling hardening in ntb_transport/MSI
> > > * Patches 15-17 : DW eDMA: self-IRQ API, offsets, lookup helper
> > > * Patches 18-19 : NTB/EPF glue (.get_pci_epc())
> > > * Patch 20      : Module param name change (use_msi->use_intr, alias preserved)
> > > * Patches 21-23 : Generic interrupt backend + MSI conversion + DW eDMA backend
> > > * Patch 24      : R-Car: add MW2 in BAR2 for interrupts
> > > * Patch 25      : Documentation updates
> > >
> > > Tested on
> > > =========
> > >
> > > * Renesas R-Car S4 Spider
> > > * Kernel base: commit 68113d260674 ("NTB/msi: Remove unused functions") (ntb-driver-core/ntb-next)
> > >
> > > Performance measurement
> > > =======================
> > >
> > > Even without the DMA acceleration patches for R-Car S4 (which I keep
> > > separate from this RFC patch series), enabling RC-to-EP interrupts
> > > dramatically improves NTB latency on R-Car S4:
> > >
> > > * Before this patch series (NB. use_msi doesn't work on R-Car S4)
> > >
> > >   # Server: sockperf server -i 0.0.0.0
> > >   # Client: sockperf ping-pong -i $SERVER_IP
> > >   ========= Printing statistics for Server No: 0
> > >   [Valid Duration] RunTime=0.540 sec; SentMessages=45; ReceivedMessages=45
> > >   ====> avg-latency=5995.680 (std-dev=70.258, mean-ad=57.478, median-ad=85.978,\
> > >         siqr=59.698, cv=0.012, std-error=10.473, 99.0% ci=[5968.702, 6022.658])
> > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > >   Summary: Latency is 5995.680 usec
> > >   Total 45 observations; each percentile contains 0.45 observations
> > >   ---> <MAX> observation = 6121.137
> > >   ---> percentile 99.999 = 6121.137
> > >   ---> percentile 99.990 = 6121.137
> > >   ---> percentile 99.900 = 6121.137
> > >   ---> percentile 99.000 = 6121.137
> > >   ---> percentile 90.000 = 6099.178
> > >   ---> percentile 75.000 = 6054.418
> > >   ---> percentile 50.000 = 5993.040
> > >   ---> percentile 25.000 = 5935.021
> > >   ---> <MIN> observation = 5883.362
> > >
> > > * With this series (use_intr=1)
> > >
> > >   # Server: sockperf server -i 0.0.0.0
> > >   # Client: sockperf ping-pong -i $SERVER_IP
> > >   ========= Printing statistics for Server No: 0
> > >   [Valid Duration] RunTime=0.550 sec; SentMessages=2145; ReceivedMessages=2145
> > >   ====> avg-latency=127.677 (std-dev=21.719, mean-ad=11.759, median-ad=3.779,\
> > >         siqr=2.699, cv=0.170, std-error=0.469, 99.0% ci=[126.469, 128.885])
> > >   # dropped messages = 0; # duplicated messages = 0; # out-of-order messages = 0
> > >   Summary: Latency is 127.677 usec
> > >   Total 2145 observations; each percentile contains 21.45 observations
> > >   ---> <MAX> observation =  446.691
> > >   ---> percentile 99.999 =  446.691
> > >   ---> percentile 99.990 =  446.691
> > >   ---> percentile 99.900 =  291.234
> > >   ---> percentile 99.000 =  221.515
> > >   ---> percentile 90.000 =  149.277
> > >   ---> percentile 75.000 =  124.497
> > >   ---> percentile 50.000 =  121.137
> > >   ---> percentile 25.000 =  119.037
> > >   ---> <MIN> observation =  113.637
> > >
> > > Feedback welcome on both the approach and the splitting/routing preference.
> > >
> > > (The series spans NTB, PCI EP/DWC and dmaengine/dw-edma. I'm happy to split
> > > later if preferred.)
> > >
> > > Thanks for reviewing.
> > >
> > >
> > > Koichiro Den (25):
> > >   PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
> > >     access
> > >   PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
> > >   NTB: epf: Handle mwN_offset for inbound MW regions
> > >   PCI: endpoint: Add inbound mapping ops to EPC core
> > >   PCI: dwc: ep: Implement EPC inbound mapping support
> > >   PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
> > >   NTB: Add offset parameter to MW translation APIs
> > >   PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
> > >     present
> > >   NTB: ntb_transport: Support offsetted partial memory windows
> > >   NTB/msi: Support offsetted partial memory window for MSI
> > >   NTB/msi: Do not force MW to its maximum possible size
> > >   NTB: ntb_transport: Stricter checks for peer-reported interrupt values
> > >   NTB/msi: Skip mw_set_trans() if already configured
> > >   NTB/msi: Add a inner loop for PCI-MSI cases
> > >   dmaengine: dw-edma: Add self-interrupt registration API
> > >   dmaengine: dw-edma: Expose self-IRQ register offsets
> > >   dmaengine: dw-edma: Add dw_edma_find_by_child() helper
> > >   NTB: core: Add .get_pci_epc() to ntb_dev_ops
> > >   NTB: epf: vntb: Implement .get_pci_epc() callback
> > >   NTB: ntb_transport: Rename use_msi to use_intr (keep alias)
> > >   NTB: Introduce generic interrupt backend abstraction and convert MSI
> > >   NTB: ntb_transport: Rename MSI symbols to generic interrupt form
> > >   NTB: intr_dw_edma: Add DW eDMA emulated interrupt backend
> > >   NTB: epf: Add MW2 for interrupt use on Renesas R-Car
> > >   Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset
> > >     usage
> > >
> > >  Documentation/PCI/endpoint/pci-vntb-howto.rst |  16 +-
> > >  drivers/dma/dw-edma/dw-edma-core.c            | 109 ++++++++
> > >  drivers/dma/dw-edma/dw-edma-core.h            |  18 ++
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c         |  15 ++
> > >  drivers/ntb/Kconfig                           |  15 ++
> > >  drivers/ntb/Makefile                          |   6 +-
> > >  drivers/ntb/hw/amd/ntb_hw_amd.c               |   6 +-
> > >  drivers/ntb/hw/epf/ntb_hw_epf.c               |  46 ++--
> > >  drivers/ntb/hw/idt/ntb_hw_idt.c               |   3 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen1.c            |   6 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen1.h            |   2 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen3.c            |   3 +-
> > >  drivers/ntb/hw/intel/ntb_hw_gen4.c            |   6 +-
> > >  drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |   6 +-
> > >  drivers/ntb/intr_common.c                     |  61 +++++
> > >  drivers/ntb/intr_dw_edma.c                    | 253 ++++++++++++++++++
> > >  drivers/ntb/msi.c                             | 186 +++++++------
> > >  drivers/ntb/ntb_transport.c                   | 155 ++++++-----
> > >  drivers/ntb/test/ntb_msi_test.c               |  26 +-
> > >  drivers/ntb/test/ntb_perf.c                   |   4 +-
> > >  drivers/ntb/test/ntb_tool.c                   |   6 +-
> > >  .../pci/controller/dwc/pcie-designware-ep.c   | 242 +++++++++++++++--
> > >  drivers/pci/controller/dwc/pcie-designware.c  |   1 +
> > >  drivers/pci/controller/dwc/pcie-designware.h  |   2 +
> > >  drivers/pci/endpoint/functions/pci-epf-vntb.c | 197 ++++++++++++--
> > >  drivers/pci/endpoint/pci-epc-core.c           |  44 +++
> > >  include/linux/dma/edma.h                      |  31 +++
> > >  include/linux/ntb.h                           | 134 +++++++---
> > >  include/linux/pci-epc.h                       |  11 +
> > >  29 files changed, 1310 insertions(+), 300 deletions(-)
> > >  create mode 100644 drivers/ntb/intr_common.c
> > >  create mode 100644 drivers/ntb/intr_dw_edma.c
> > >
> > > --
> > > 2.48.1
> > >

