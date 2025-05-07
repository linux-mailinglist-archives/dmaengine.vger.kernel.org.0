Return-Path: <dmaengine+bounces-5102-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB62AADCD2
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 13:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFFB986388
	for <lists+dmaengine@lfdr.de>; Wed,  7 May 2025 11:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CED52147F2;
	Wed,  7 May 2025 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fBNivRgE"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083471C6FF5;
	Wed,  7 May 2025 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615754; cv=fail; b=j7WZB3knWX6x5Ae6VHWA6BnKstXak0G+h9oRN0orp1kY0s9lYDwKLevUcsmUhMc5/SGMqF5lduk/iTEn+dgUAWxwF2M4AiHCYiz8lzTAikUpc2/isy8lyX9r9h0RU/pNPLraf0gJb+WjiTZCLIERc7AGKpWwGcRDUMAqZokQ5kk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615754; c=relaxed/simple;
	bh=1UZTGSbbq2Qp3NE1hhL1jdPyTh8WOTR6QslBT78d+lU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UmbuDPONZbIuzj08ApUCbevNcfvNmKGi/rK0IOelQ09bLWykim/Maa9NtVGN5Gdzap8P65ONvJWTLzdk7Vqo7qpFi635ceNcSb/c+lIYbw8XSZV1xRRtHqYbIaRMVSbj0fgNdOxS2GdWiRPpqTOGbVTErPbPX+GYSBiJaTR2YDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fBNivRgE; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Og6lxhb+2a5t28S7MpJNC6vTOSFCaPoBGn/XfRwVcQbxbmHsMKHSlYyr90erlRbdtMDmpV/nL+PTRvmAOAOlhc9cP1ak0CygVkbUTBbFDvNPBG3sSl9MCHLq+U+WC0W017XchK+ex4E0bV3U8xwoba+dm3glO64CH+22BnfUgDrTjPn+kYdJVAjIpby03dcfcqcIsTmRCNtTjPDUl6tWIZ6WXI9/QrKjWESsiBqguNSQ6c2NR39gI1JJcv4me2T0GfXpzPEmEU177QFYCtYmAdudeZocbpOqabzhFsE5bt49VZuoHzlszXDgIExPG5hnf/Y3CwDeBt6Sls2fN2UOwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UZTGSbbq2Qp3NE1hhL1jdPyTh8WOTR6QslBT78d+lU=;
 b=Jna4e7bWxmeSaAEwqe+iES1uOx7A6FPpK1lK0szTdy9GMkmodJU9L1rhENYxzWxkIRrno4Gvp5YTP67s7lmSVTYihV1vBcLNIVC6/Vaw/3WxYv7FdJ/LhoM5fws3Y5dcWxLgrQg2VNSKaWgDZt4wesvdCARUWeNUH9Z6y7WV8+dyj2QaKjDeQQGti/Oruq/ev/SW6oudZ8wSGw4QQVv62RxzUq9IisRui2z5tattAfgF2jTrt+qRrc0XCLAu+/CbXiEJDRcNgRNcdWKsHMrLmX9Iv+7HosAXaSfszgw391H6ZXtM1LHRbiqvm3lh8PyqKvh01///IItf0maG1BQs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UZTGSbbq2Qp3NE1hhL1jdPyTh8WOTR6QslBT78d+lU=;
 b=fBNivRgEJ4LGm35odna8VQ0lEfO9HDazuDls5mNFhdDElJ+Mo9G/t95nJXA7TiHc4Ya8BewLhv1Ruevg0MdMUxVDEWAr7NXHc2CEOYwimd3NZbUdIDAH2EYhudfgjuP2MAqKY8AkdxogQPSUIP5gXAkf+62e4rY35z0kcgEPSCo=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CY5PR12MB6623.namprd12.prod.outlook.com (2603:10b6:930:41::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Wed, 7 May
 2025 11:02:21 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 11:02:21 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: =?utf-8?B?R2XDn2xlciwgVGhvbWFz?= <thomas.gessler@brueckmann-gmbh.de>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, Vinod Koul
	<vkoul@kernel.org>, "Simek, Michal" <michal.simek@amd.com>, Marek Vasut
	<marex@denx.de>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@baylibre.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>,
	"Gupta, Suraj" <Suraj.Gupta2@amd.com>
Subject: RE: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Thread-Topic: [PATCH] dmaengine: xilinx_dma: Set dma_device directions
Thread-Index: AQHblOfyPgreEFaTb06QsgCB79kDoLN25v/wgFBhYuDwSRY+Zo+29krQ
Date: Wed, 7 May 2025 11:02:21 +0000
Message-ID:
 <MN0PR12MB5953671CE77EE1658DFEBA49B788A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250314134849.703819-1-thomas.gessler@brueckmann-gmbh.de>
 <MN0PR12MB59531CAA16616476F2E09EFBB7DF2@MN0PR12MB5953.namprd12.prod.outlook.com>
 <MN0PR12MB5953C8800220724906360D54B788A@MN0PR12MB5953.namprd12.prod.outlook.com>
 <1814404629.486377.1746615560560.JavaMail.zimbra@brueckmann-gmbh.de>
In-Reply-To:
 <1814404629.486377.1746615560560.JavaMail.zimbra@brueckmann-gmbh.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=c30a9f56-afdf-4530-b9af-d487d23e7d85;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-05-07T11:01:19Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CY5PR12MB6623:EE_
x-ms-office365-filtering-correlation-id: c55f5307-f48a-4fc9-db47-08dd8d56a427
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkVHK01HZmpRRmYrTW1ZNUpRNmhCOEE4UXQvMXQwTllIakdab2o2YVhIMStv?=
 =?utf-8?B?cWdtS3d5VE8wKyszNVVaM3ZpU0liTW9JQ0d1WVUxVkpEamFmYS95WllQTGJp?=
 =?utf-8?B?dVNtVjFRbHU0YkRiSHJwSWRzNDFRNTNDQ3lQbVR2Z3lJVkxYU3dCVEZJZDFP?=
 =?utf-8?B?VmhVd0NoQzF1bVRZOXFrQktOK2NibUhTM1g4T0pqcDdwbXN2UnJLWjRRakw2?=
 =?utf-8?B?bDRabGdiZi9LRFBuZmFZcWVvNVdOMXNUbTdnQzdGVklocVFuUWk5eWtqVmJJ?=
 =?utf-8?B?Y21LOU1GZmRRQVQvN2k1emhuSGFhNDJSWlpnU0k0VVdISWhQTmhac1paeUV4?=
 =?utf-8?B?R095dnBZU0M4YnAxd0tsOFA4a1JicXpFMHRtOXJWVHhRVTNldFdiUmd5c3pa?=
 =?utf-8?B?VFBkV0tzbzFGd1dsNEJqT0xLMHI5RHpYZTVoNU0xaDZTMm1RVi95aVpTcEwx?=
 =?utf-8?B?S0hVV0M4RktENDJyRlZMeXp6SXZkaUxNOWp0R1lWOFpzWVpGVE44OVZpWTRW?=
 =?utf-8?B?dUtmSUl2TW91dktNQUlOYTFEaEJRVjJtS3EvZjArKzIxS1NqVWRCbEM4TW04?=
 =?utf-8?B?S21JZUZLR0Y4TlpWejRpTGZydHByOU1RZUhXaUlQVFZVUmJ1d0VKYWNWNUVZ?=
 =?utf-8?B?NSs0UHdQWStoU3pDR0JaWkhMSjA4aVhzSHpnenhGWXdNbE1KQzBzWE16ZUM0?=
 =?utf-8?B?WlRUVmhxWUtKZXF4UDQrR2taeGxyanhpNjFUM0laUXBldmpWdGxRemplT0FS?=
 =?utf-8?B?N2xlczZLbkNsbWFTbk0yZlpXVEdiUWQ1aHNxN0FlWkt1S0l1YmNkc204MEE3?=
 =?utf-8?B?MW5oTDVCcjV0blZMeTQzZGw2MzBrdXBod01UODdLYjFlM0N3ZmZpWG1OZkZ0?=
 =?utf-8?B?dlRJQnZpUXBQVURKaFNGR2xxYmVFTUo2T09HRGdzcUdDRU9ydm1uRG1Tayta?=
 =?utf-8?B?bFV5TzVzNjVmU2xMUGdMcGIwa3pXK0I3Q3RjeGhEdUNGUEZ6eWlNYnk1L0hM?=
 =?utf-8?B?R29POEt3UUhuM3ZGbzhzeDdyZVBkNUpQdnJCWnZMSDh2VGFTVVFRYW9SQ29R?=
 =?utf-8?B?eWlWVU5ZbURURWtWT1NINzNONGhGTjhQVWVna1krOHlONTZSK0hWZGZhVmxr?=
 =?utf-8?B?MDBzMDVWdG1iUmMwaUlFRGpYSjg4eUxrSjAxZnJmWkcwMU9uN1VOSXNrSC92?=
 =?utf-8?B?SnlyeEpFY1NTRjM5SUx1ZFVkZ1dZQkVFOWtFMlFNYnlKcmlHeHR2bnczUmVp?=
 =?utf-8?B?QnYwTzZIcy9xemZvUGVnNGk2R2ZVODVxczlkVWtyVGN0anpId0lYQzRVZmpC?=
 =?utf-8?B?cjQybGNkeklZYmhValZuSHhrOENoa3M0blBxUWYyUitNQ0kyRnJjMkdoNVU2?=
 =?utf-8?B?V2Z4Ri9SanBzY2piN1NEOCtTZE1aQUJlb3p6Zk9ENDVLYktlWnZNbXQ2TWxz?=
 =?utf-8?B?UTFlME1INHlIcmR3MlIwTVR5aVpqTEloblc5aWYraGZZMEw3Yy9GRi9wUW54?=
 =?utf-8?B?SmhnblhUcGpla2J1NVNzVkZrUEl0WVRDVnVMa05HaVNMNnJuSDF6aFhwZlEx?=
 =?utf-8?B?WVAyZGF1SC9pZ21vdUlkOHk4N1ZEb0svMlNVbjlMU01pMDd0Q3RsWWpjMzBW?=
 =?utf-8?B?MnNqdUIvU0tCQU50YnBOS3BSYkVGWDFGMVdCYjU3eWdaRm1MeUJ5QU4wb3FL?=
 =?utf-8?B?djQ3RndTWi9lREkxdUFuZWZsS2o4Wnh6YWlucFhld00rUGhtNTdBNTlMRlNm?=
 =?utf-8?B?N0d0aFBPUjU1ZGdRbFlGZi92aWkzaUJKWGtzNG4zdlVjM1hvempkb29jeGI3?=
 =?utf-8?B?VlM0L3VFYjZGOFBkWVZOcmRPWUlqeUdQeEI4TXpYTnBYbkoxaXQ4M01pWW5T?=
 =?utf-8?B?Y0s2TktycmtFQlRacUVXbm5nYU5LdjdydVNicDVKbllxU3pqMk9PWjArNmF4?=
 =?utf-8?B?ZFBqMEcrVGJ6cWZNWGl2TWZsSDBxbnRkeEgzWEVKSXdYODVlZWowNVN3a0Ns?=
 =?utf-8?Q?JOmPkJQXpYU5xL4YY7lS86f5pf7BaY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Qmk3aDJod1NGc05qUHE0V2I2V3pwWkE0YkIvVzVFNmE1VnByQkplZzhwdTZE?=
 =?utf-8?B?SWxDYkJmRXRENTZBV0tZTXFqanN4U2tFNmhJUXlqV1hGOTFwWjhEbUpKQ1hy?=
 =?utf-8?B?MVh2VXhTVkhzd0M4MEhtVUlDaFJnMW84N3J0T2dBRUpxSnBzZDJsSTNhZW1h?=
 =?utf-8?B?UjZZSWF4dDJrWGlNbmFON24wNHVHK1BFSE5aT2EzN0Z5MWRHa3gvNnlBY3Ji?=
 =?utf-8?B?eTliOWREY0ZEMjZReFUvVHgyRE5KVWJDUHRTbmtaQzFQWjJwV2ZFdVVnNldQ?=
 =?utf-8?B?bDVOMEUvZXJZU256blRkTGhqV1ZUUHZvRGFyNVA2ZVZTaytYREVvZHQ1Z0Rq?=
 =?utf-8?B?S3lwY3ZtS1V2R2k2aXlxbDNvV1hXS3FTSDZiY1hyZ2RvbEV0UWJ0Z25EcmhM?=
 =?utf-8?B?ajFnVDRNMXJHV0VKNWtGQ3J4MXhlam9MckMrNW9XRGlJOE0zQnpmWGF4cm93?=
 =?utf-8?B?VmRxN0JYdXpTZ1hNLzZhWUxVNlBYdmg5c1c1R2xzOVEwTjk1bXFRTWZCb05R?=
 =?utf-8?B?d1R2cEtITlNaVjN1NFpXM0x5S3NTME9adzFsUHU0Y21kREY5WFI3QVprOUds?=
 =?utf-8?B?cWhuRjNxa2JGU1U2bzJ6VFBYTm9jdjN0dEh5ai80dy9GZmdZS1lGL1ZIUVBt?=
 =?utf-8?B?UnRLUGtZNWIxenp0aUV0ejAwU3o3aWdSRDh4ZkJ3MGFUc2phaW9lZFBBUFZD?=
 =?utf-8?B?SXVrV0loQ0Q2WFpOMEVuNUhhZmd6T0tiTUUrVUNXZC9OY0V0dTk5R1AxWHhs?=
 =?utf-8?B?NllSUjNZNEpGSkhYaktOc3FxQ0lpelhkYzZiclVHY0VKcXFBQUxoaXZBR0E5?=
 =?utf-8?B?T3ptbG9ZQ3JGWjVjdEw3dWJsODMzLzNuTmxEZnQ2L3pGakxscnZoWnoxQ3c3?=
 =?utf-8?B?Y28waXBSNzZCUjhURmI5OGhTMmtDVlRGUzBaNmRrbHdGSVlrYzVBa2NCekla?=
 =?utf-8?B?QVpsNjM1eTV4OWNDbitsYTR3eFBwMXFXY0U0RDNGb2NFWkUvblpISHZpZ0t1?=
 =?utf-8?B?YUxOc1p1Um8rdmZ6c3F2Vm8xbDJXMlJ2R1pTblB4cE9NYml1NmFNUFFSQVk0?=
 =?utf-8?B?d3Y3aXd4M0FaVnJJMjYyVHptUjE4RTAyL2ZOODE1SVhRcmlHdDdFdTZXYmdR?=
 =?utf-8?B?WEZwZW1LdmFNRFIxS3QyUmprRndPYWhQZE53QlVseExtV1lGL1M1REtubHZ2?=
 =?utf-8?B?azlKNjd3Z2FMNCtBVkFWd3Q4aU80eWVEc3pCeTdCVXZ4bytsVTJkdnJURFJa?=
 =?utf-8?B?WUpvZnAzY0NDRUxEQ1ExOG9VV0NKYnBwQzAvcUREU1VVV0ZuY2YwTGZBSkdM?=
 =?utf-8?B?QTFQbzM5TURtbWFIM25lZXdkV2NxUnpWb2hPK1YxaEc1Y29QSlczcDZaVktR?=
 =?utf-8?B?WkM1RGdMaWFLTlkwZVFqNFRaRnNrM2wvSVVSV1RMd2hHeXI1S1kwcm9zYXNU?=
 =?utf-8?B?QXFZWnBTVzdERk1WRHNjaU91N2Q0NmFxMXpGOVQrOG1RN3ZmbjlrUm9RejQ2?=
 =?utf-8?B?OW5nMWZKNWswWFR0VGdlMjZpeGhlMlN5aExjVE9uaXNsdldDZEJZMkIrTk5V?=
 =?utf-8?B?SFBUNHdvbjZyOWFXc3IyM0lNbndkc2Z0emFmdVhTUFR1bGRMMlh0TnBSL3oy?=
 =?utf-8?B?OEMwWlVZM0cyREVYV0tpaGpCdWxDSG1lZGpXMGZ5d0U2Nm9ibUp2ZjVTUkxa?=
 =?utf-8?B?SUo3dFpFd3NCRXJ3Z21xNnZkMmIrdHhzQXkwQVpnSjFwN3N5Vm9xYXA5L2F5?=
 =?utf-8?B?SEpBaG5DVnBZTGdJSUxKa3FOQjRzbHNQNzhpazBkZS9kdlpENE5TM3VpNmhv?=
 =?utf-8?B?ZDhweTZ0SjhRdDBzWkx6SWE4WUMreEZ4c04xUXc4aWZ2MGNMRHFJZlJ3RS90?=
 =?utf-8?B?T2hIU1lnemV2RG42a0VhU0oyaDFIcllqWk9rZE8wMEZnQmdmdkhGV3llMm5o?=
 =?utf-8?B?T0lYS3B1UWhjSzBRNDFKQWMxZTQrZWUvWmM3YkE1cEVaWmJ6NE1HSGFIUUds?=
 =?utf-8?B?dHFhazRGS3hadHFNMlZHTEJlR0txMklUbmg0SUtoYzlFWi8rWjhOVEJVbWMv?=
 =?utf-8?B?VnN5MC9RejdHVjZlMlFCb3lXRC9vOFNpYzlBOGtGWFNWZEFGdC91c285ek5G?=
 =?utf-8?Q?hdgk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55f5307-f48a-4fc9-db47-08dd8d56a427
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 11:02:21.6647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +4OXCm+qB9RSlwIFV3LMxwxPRzdULWp00GbdpI1LOA2Dv38Pn/5xeiTy0Y2L3hTt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6623

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZcOfbGVyLCBUaG9tYXMg
PHRob21hcy5nZXNzbGVyQGJydWVja21hbm4tZ21iaC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBN
YXkgNywgMjAyNSA0OjI5IFBNDQo+IFRvOiBQYW5kZXksIFJhZGhleSBTaHlhbSA8cmFkaGV5LnNo
eWFtLnBhbmRleUBhbWQuY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgVmlu
b2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47IFNpbWVrLCBNaWNoYWwNCj4gPG1pY2hhbC5zaW1l
a0BhbWQuY29tPjsgTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+OyBVd2UgS2xlaW5lLUvDtm5p
Zw0KPiA8dS5rbGVpbmUta29lbmlnQGJheWxpYnJlLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEthdGFr
YW0sIEhhcmluaSA8aGFyaW5pLmthdGFrYW1AYW1kLmNvbT47IEd1cHRhLA0KPiBTdXJhaiA8U3Vy
YWouR3VwdGEyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGRtYWVuZ2luZTogeGls
aW54X2RtYTogU2V0IGRtYV9kZXZpY2UgZGlyZWN0aW9ucw0KPg0KPiAtLS0tLSBBbSA3LiBNYWkg
MjAyNSB1bSAxMjoyMCBzY2hyaWViIFBhbmRleSwgUmFkaGV5IFNoeWFtDQo+IHJhZGhleS5zaHlh
bS5wYW5kZXlAYW1kLmNvbToNCj4gPiBTdXJhaiBhbHNvIHdvcmtlZCBvbiB0aGlzIHBhdGNoIGlu
dGVybmFsbHkgYW5kIGhlIGRpZCBzZXQgZGlyZWN0aW9uIGluDQo+ID4gY2hhbl9wcm9iZSgpLg0K
PiA+IFNvLCBJIHRoaW5rIHdlIGNhbiBzd2l0Y2ggdG8gYmVsb3cgaW1wbGVtZW50YXRpb24gPw0K
Pg0KPiBUaGF0J3MgZmluZSBieSBtZS4NCg0KSWYgeW91IGNhbiByZXNwaW4gdjIgd2l0aCBpdCB0
aGF0IHdvdWxkIGJlIGdyZWF0Lg0KDQpUaGFua3MsDQpSYWRoZXkNCg==

