Return-Path: <dmaengine+bounces-6306-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B79B3EC57
	for <lists+dmaengine@lfdr.de>; Mon,  1 Sep 2025 18:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A6A1B20089
	for <lists+dmaengine@lfdr.de>; Mon,  1 Sep 2025 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9252E6CC6;
	Mon,  1 Sep 2025 16:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5ePbRV2H"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE78F2EC0B0;
	Mon,  1 Sep 2025 16:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756744677; cv=fail; b=Y08xczHmCWlOnYrvyC5Zf04ZfZ1MOWiVNBF0W3c86lXClQ+upSxSNS6Kyzkz0ibO/kwEkYN94HvsJuo4SUOsM5D9LO44IGKBx/gCdndMHNRtz6MQtjrulypnZ6vybGGqsnjO0qLxlhjDDGQsGmyefK60B0Er+oqucZjFY2y8TtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756744677; c=relaxed/simple;
	bh=7yy+Fi4GVfBcQ+rqafBKlEO31uGpdoN+md4FW+MxHx0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QbknHHnwGO9pZUlnG3SML74Z94Dukd6xOivNW7C+fX6NF82YCJE7x8P3Qm6GZpcBD0ScOBLULUR/zcBemieIGCR4/PHwAqP2ixBFDSJR9RSV0UZX0bJqpXWckCK7y9qj2jVNRzRYFKxVwUzpNRD4tb5tJtCaDsRBjJw8D6+xmWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5ePbRV2H; arc=fail smtp.client-ip=40.107.244.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNU+IyiWcyDUwOkDdPJwuoUNSaO4VvwI/IqZspkVGeFlK76NTc+rXm+Ez7P2p+oUgk0CpRH6x/5RFk9qrATl3DUUWKqjbFeNa9AGaV90wUJH93lK2HKlcvkOUaDPW1W2yLbLVV6iAIZUOpA3j7Ynxidt9F4vUcQThgaYKgifLSOpULpfNOB+EhDehx6uxGXETvXDpt0ptiNOmvM+y9f935l3vixLOHEpiPcDML2RrYXCnYzDLqN/8CZubcLdvMDdCy4F7Q/KhwtV5vdZZxSkPDSZ7bzlCbWV/e8VcL/FBIxeA14H3Q9uVyBB+W9exCyrZDBgGnQBvJLoh2K8GUWkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yy+Fi4GVfBcQ+rqafBKlEO31uGpdoN+md4FW+MxHx0=;
 b=foSF+h7IK0Rp6JmXM2HsgoW8nwTZMVj+F8ugqXk/jVRsApOWCO12GkPmzBBa/kH336rSF+xj+3Iz5RXJxo84OQJwe264vzboWTguWHePkAictPfOY4viGOeBJ6x6SNEw48vnoloE8aNJM6jejXTMLK8yuvAh7MTFB+f+wd+LkXYMVWBMtaQTliVozDKbEo7sJShoHqLGwmGL8W9wV0FUC6jl4ZYU+5pqTlCb1fRZqfMY+mkeXb826lsUdiRH2EZXhBjUlD+EWSexqa627338W8CEOwG1Ui9fCOF6TF9rLBW6AZPbSrINE6TOtclsG8z2zJ/H3dcLzhii3Cyi4K1mWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yy+Fi4GVfBcQ+rqafBKlEO31uGpdoN+md4FW+MxHx0=;
 b=5ePbRV2HnIHwbqNbveAcFTJDQi8a8IYpQEFGxBC9ynLc0HH/mQPm/Bo6mBvKB1siZ1e/WaUqJihPtzN6hbKo7OWSz8s+2u8YXtK1F0xSS3f6YlUgkqXXiAlNY1HvbnLqJif7rYZSkMIZxkD5nF8xp/u6N76k5HIEIknKSX3mjAY=
Received: from DS7PR12MB5958.namprd12.prod.outlook.com (2603:10b6:8:7d::20) by
 BL3PR12MB9051.namprd12.prod.outlook.com (2603:10b6:208:3ba::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.20; Mon, 1 Sep 2025 16:37:52 +0000
Received: from DS7PR12MB5958.namprd12.prod.outlook.com
 ([fe80::7f21:5e2e:f838:f3c5]) by DS7PR12MB5958.namprd12.prod.outlook.com
 ([fe80::7f21:5e2e:f838:f3c5%4]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 16:37:52 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: "anthony@amarulasolutions.com" <anthony@amarulasolutions.com>, "Hou,
 Lizhi" <lizhi.hou@amd.com>, "Xu, Brian" <brian.xu@amd.com>, "Rampelli, Raj
 Kumar" <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>
CC: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dmaengine: xilinx: xdma: Fix regmap max_register
Thread-Topic: [PATCH] dmaengine: xilinx: xdma: Fix regmap max_register
Thread-Index: AQHcGzTSydcPIRA5+UK5WH3na8qh7LR+hbDw
Date: Mon, 1 Sep 2025 16:37:52 +0000
Message-ID:
 <DS7PR12MB59581DE67ECA59637F73D4F9B707A@DS7PR12MB5958.namprd12.prod.outlook.com>
References: <20250901-xdma-max-reg-v1-1-b6a04561edb1@amarulasolutions.com>
In-Reply-To: <20250901-xdma-max-reg-v1-1-b6a04561edb1@amarulasolutions.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-01T16:32:47.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5958:EE_|BL3PR12MB9051:EE_
x-ms-office365-filtering-correlation-id: 7d226002-b1d7-4d15-bc82-08dde975e567
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UDZlWC9tTXgvUUt0WFpvMlNjUnA1TkhyWHhaa3YxRjB6cDdCV2lpbUpzakw4?=
 =?utf-8?B?cFczZ0dGaFpNYTcxcUczTXZ2TFpWRjVwWUFoWk03MDl1ejlTb2VSR3JyamEr?=
 =?utf-8?B?RHhqQ3RiQnlEY2Q1SzlKaGUxVzRqdmNPT2hiQllCTWRKQzFhSnNtNzJQZDhp?=
 =?utf-8?B?MExjdzBqeFVTQWdIOHBOMHJSOUdPb09vbFlBbVZZTWc5Y1dXYlArWDR6QUdy?=
 =?utf-8?B?OWxXZW5obkNLWFB2VU5yQWh1VlFiVFpvWndwMmJEMTc2M1BvbSt4TllJejc4?=
 =?utf-8?B?dnRLdDB4K1JyOUtJR1NUV1d1OFJGNkE2NGlQU1NwYjRvR2NXcHBRWEd2a3l3?=
 =?utf-8?B?aVUvUU9GRjhid3JjeUFrVU02VVZhZ2dpcllhZkhhT3RleDkxNnIyRGp5WjVz?=
 =?utf-8?B?VXh0WWYzZmtpQjhMeUV2T2JrQ3UwTE1iM1ptazNSdTQ0a2R6ZmM3a3E3dk9h?=
 =?utf-8?B?VFhMQjN3UTZHNFF5QWpSZGZSblZLYldxWmlMSmdsVER2a2E3aDQ1OFVkYk9i?=
 =?utf-8?B?Z2NOT05oc2V6UStwVEVpMm1jUklEbXE2UlE2L2FTQXVoSjdTcE1BV2VESUtD?=
 =?utf-8?B?RElaZGNGTWRScWV0ejRsZktHZlo3aVgwMkVqTjhaRTJXTytCS3JsYVRSQ0xs?=
 =?utf-8?B?L0d0S2duUzFXMnk4eDVadmVsVyt0NWJPM0QzSjA1RXpSQnM3T1E4ejhFTXVE?=
 =?utf-8?B?ckNwRTRIRCsrbVVIcW4vZi9ZMlpIUU03YjZ1TkNJWjRQQzBScG9IMmpGMzBZ?=
 =?utf-8?B?bzRRVW8xK0xxblJKWjJ6L0kwNWRzUXJzVHN5bGcyanM1QzNOWWZzRVhRcHJz?=
 =?utf-8?B?M3JwanRvYmczMWpTUFVrOHZxdys2Zk1pK3BINnFiTTYwZU5rV3k2Myt4SGRu?=
 =?utf-8?B?WkRNZ1NaK05DaXI5eHZpTVBPSHFpMFVaY1UrZ3FzRGVRSFk1WnBQT2ZIMVhk?=
 =?utf-8?B?WFRzaHpsSXN0aUxLYVZRT3BuNTJHMy9Mdi8yc3FmMTArSVczaGkwRXp1YVUr?=
 =?utf-8?B?c2dPK1IzR1pCRGhwdGFEOW1iTktOd0o3R0R3dWtIb0xWQjkvWUM1V3Z4MjJn?=
 =?utf-8?B?YnZ6V1JyRkg4RjMzNFFFclFLaUxGaVpRNklTVmhBMllpaEdKaktsOWRGeFlE?=
 =?utf-8?B?UU5ubXkwNXhTQnNPWGJST3lVbG52VVpScUhlQWNQN08veW1Yc1ZYejdpVFRU?=
 =?utf-8?B?U3haY3hRQXNMSjF1QkFqMUZmZmlsdmgyQkUyR3pNdWFZWmpQbnFjQ1NOSnAy?=
 =?utf-8?B?QXc0eXBGaDJPOFA2RDN3WU8zblE1MW95UXB4VStVdWdiaFl0MmdlUjF5czZs?=
 =?utf-8?B?Z00ySE9LcWIzcDBzYnd2dHZyVitiZlNRcENtaitCTEFLcTJidEtkdFBISXk1?=
 =?utf-8?B?TE5wSldlYWlyRG10eVkzb2l5UUlPS2llYjQwMnpib3A5NkVoaGJTY2luQ3JN?=
 =?utf-8?B?R1JUaWxvR0lidDg1ck82Q3ljL1ErcTRGKzJKeVhnVWF3U0N1VGZmN3djcEtw?=
 =?utf-8?B?YWhFeERkeWFQb3pFTzMrVjhhNWhBZi9xc1RObzBrYkdzMCt3STVvaHpmSG12?=
 =?utf-8?B?ald2VkF2UkN3LzVKVmpWNkFTbVA4Y0haekJ1WlhJaW8zM0xoc2RTT3dkMUZv?=
 =?utf-8?B?eEVZZGtTMGJEMXU5MjJQNVFSa25zUmJ3alF5MmNLNnpZdllIaThzK1pqK2RZ?=
 =?utf-8?B?VElkV1d0MWgvWjc5V3RPS1ZRb3dXSDFFQlFobGNxZFE1ZStRcXNXT0JMM1FR?=
 =?utf-8?B?VnVSTVZDWk9TRFRsZlRFcnFYY1VmUzFLbGRlUVlOcXJ5WkZTU1FTOGFjNUc4?=
 =?utf-8?B?eHpGU3RVbFhJMTdDUkJEcUQ0OWg0ejdGNWhBNkpLamlrMHJpY0N6S3BTRmNC?=
 =?utf-8?B?aEZlZzJxSU9ZYVJOcHdKRGx1UXQvMEZlM1FGKzUxbDVkenBFRXF0UlNjOXVo?=
 =?utf-8?B?aTdFMEU3TmpJZlgxUVRibEhCc3hEYXFBUVlDYmhRb3gzZnNFb0Q2SlZVNnY2?=
 =?utf-8?Q?WDi6LXBSU4p28YvwrMl61ITj+d+eAk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5958.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cDdxamNzWUtwMXJ3ZUVDL0FtdDVmV0xzNndrUWR6WE96YXhDZTZRUkQrU1Fp?=
 =?utf-8?B?WlkvYzlPYktmMVRWQmpFdWdRL1hLT2hPdmRkYmNmc1VMS2NISHlBektiWlBo?=
 =?utf-8?B?WVl0ODNPMGxka0VtcUZMTGhvNEJIbFpPNTQvclQyM0dSa21mQ0l4aENDVEJv?=
 =?utf-8?B?aCtnSGQ2YUF1bHRwUm5ObHVRVnEzQTNzbWFWVTJ4cGtWaXgrVXhhR2orSFJp?=
 =?utf-8?B?TXYvaGdjenltSnBHNlhwcEFZUlB1M20zeGZoVmxHWHNlYTNrNDVxVXlVLzRs?=
 =?utf-8?B?UCt5VnJkN1dJLzhEaWNnUkVPWnJtbGxONXhGVzhBcXkyUzZ2YnFITEVZK2tr?=
 =?utf-8?B?OEZBNi9mOEVWd09EM3BoL1RwbkZueHprRHg3d1EvL2RuTEhSVHBiRnFXVDRr?=
 =?utf-8?B?QWQ4Z2M2TGJPNHJhRytFMWxnNzdyMnorY1dUZ0ZqWTE4VCtpbERjYTlhanE5?=
 =?utf-8?B?UEZNNGtvRXJmYXJEV2VzbGNPOG9yalFvMnUxMFdMTDRKeUxHR3d4dFZtT1p2?=
 =?utf-8?B?elZINUxnS2dFVHFxakt1cUJvVzlFWWh2cEdLTlJwRnc1bWlMdTRqckhxelda?=
 =?utf-8?B?Z0pheTV1a2VxY25oS1ZCdGk3djhoUWc4NTI5YjVlQ2g5dkpiRE5YMGRQZVpu?=
 =?utf-8?B?WXB3TWtPbFQwdytpVGprakNPKzZCMmRZdWRiOTQySjUvU0Z6dGlKMHpFSXVn?=
 =?utf-8?B?N2U4K1c0RGRmdFNFQUJ6N1lhaVlQNHRxVzVSSlppYjRTT0FwVWx3RDEwbW1G?=
 =?utf-8?B?Mi91TjNieWZCYTJKUVRxcjhiS1VpamlXSFJIeXJYWnAxd0grQWs5Q1VHU2tT?=
 =?utf-8?B?R0UzUGs5WDVKMldKaUhPMHZWZXB4V1BHWmdlemhIUDg5ZWZWeEVBRFlmcWlO?=
 =?utf-8?B?T3FabUpGZ29wV2JpQUhEck94NDNBRWxuM0U5NkcxSWJBRVl0eS9kblhORlAy?=
 =?utf-8?B?RDhJNkJTYVpvNG1Gck5sak1ERXYvK2dFYXNCTnNMa1plclBPbXJqV2lLRHJq?=
 =?utf-8?B?TUhKN1M2WDdwRTFPUGozb2ltZWJSc0xjT0NkMUV5Z282M0JWWm5GTEl5U2M0?=
 =?utf-8?B?Tng5ekluSEpMZGtyTnRNWnY1MVp4NVBZYTkvbnliUFNxYlJoV2VWZDY3dWFo?=
 =?utf-8?B?OUZEcHltc3cvdXU1OWFLdDErTE02ZTJJVXJHMG02RkE3VklLaWVkYmo1K3Bs?=
 =?utf-8?B?aVlEK3RIbzVGUU55LzNTbVdqd3FwSElHTVE2a1JuU2hSbGQrTmFlZUZBK1JR?=
 =?utf-8?B?RVBTOXkwTVoxNExEZWY3NjFjamVEaWFLN2s1RmgyNkJZYlppcm96THlRMU41?=
 =?utf-8?B?N3M1bVRVS0NzeGFqcTB2bnFBTFp3VklEenQwcHMxVDhHbm45WTFUMmZFNng3?=
 =?utf-8?B?cnRXekxQcG84eVhlYldxbDQwZVJWT3QvUUUyeVNHRjhudGJ5ZkNxeHVKbW1u?=
 =?utf-8?B?MFRtMW94Y29iMU5heDc1MnBuS2cvaXgzUWNTWEcvN3ZGak1aMVJpc0UvODJI?=
 =?utf-8?B?by9BaUMreUFadDNQanJKREVxZDhFYWNMRG9MNjM5Y2hycjVKOC8vNWRKczZT?=
 =?utf-8?B?V2Z4V2RlUjVWVnEvaUlSZjR2a0lEVkxTOVNGeVN1Tm1YbWw3Yy8yREZQU0x2?=
 =?utf-8?B?OEM2NjhRakY3eC9scnZNVWwreXhuQ3kydE85ZG90MU50R2lacER2K0Nlb01x?=
 =?utf-8?B?SDBXNmFNdkkwOEVYdmVpR1VYdUNYa2xGUncyblY0dXkxYkw3dFNzaFh2ZUZR?=
 =?utf-8?B?Q0VyRGE1am80K0ExeHhQWTBnTkpXUGVwb21HdW11cHhERkV3UEQ4ZFlyaUFE?=
 =?utf-8?B?N0tUTUdpamZRVHBhaFRua3JtM0VUN2NGb3FLRFNRaTJEdlpkbEZUQWsyRWpk?=
 =?utf-8?B?M3g2cW8yMCtRdy9MMnRTYlg2MXljSlpxazh0YU53L2dOV0tBMmZUbkw0WFZp?=
 =?utf-8?B?WGcxUXhjcTFicHBjb2ZkOXVyYnZyT3pwNEVUeG1LV1pnOXJRWnVoRzZGb0xu?=
 =?utf-8?B?eTNZa3ZEVkxUVHhZNEJ5b1JmNVUvWEd2T0F0TDkxWjV2ZVUzQ0JLcXpCVXJF?=
 =?utf-8?B?ZjZEV3pwazI1ZnpNTzlJVUU3V0RnbHBwd0FlVWdFSHVCNnVnV2lJUVJKQVdC?=
 =?utf-8?Q?nipk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d226002-b1d7-4d15-bc82-08dde975e567
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 16:37:52.5526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03KfITiAj5XyHC0s9sgdmH4+ciJ6rE/oEAb3WxPmAMppp3cGRn4ipnwZqM21wucG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9051

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbnRob255IEJyYW5kb24g
dmlhIEI0IFJlbGF5DQo+IDxkZXZudWxsK2FudGhvbnkuYW1hcnVsYXNvbHV0aW9ucy5jb21Aa2Vy
bmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIgMSwgMjAyNSA1OjA3IFBNDQo+IFRv
OiBIb3UsIExpemhpIDxsaXpoaS5ob3VAYW1kLmNvbT47IFh1LCBCcmlhbiA8YnJpYW4ueHVAYW1k
LmNvbT47IFJhbXBlbGxpLA0KPiBSYWogS3VtYXIgPHJhai5rdW1hci5yYW1wZWxsaUBhbWQuY29t
PjsgVmlub2QgS291bCA8dmtvdWxAa2VybmVsLm9yZz47IFNpbWVrLA0KPiBNaWNoYWwgPG1pY2hh
bC5zaW1la0BhbWQuY29tPg0KPiBDYzogZG1hZW5naW5lQHZnZXIua2VybmVsLm9yZzsgbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsgQW50aG9ueSBCcmFuZG9uIDxhbnRob255QGFtYXJ1bGFzb2x1dGlvbnMuY29tPg0K
PiBTdWJqZWN0OiBbUEFUQ0hdIGRtYWVuZ2luZTogeGlsaW54OiB4ZG1hOiBGaXggcmVnbWFwIG1h
eF9yZWdpc3Rlcg0KPg0KPiBGcm9tOiBBbnRob255IEJyYW5kb24gPGFudGhvbnlAYW1hcnVsYXNv
bHV0aW9ucy5jb20+DQo+DQo+IFRoZSBtYXhfcmVnaXN0ZXIgZmllbGQgaXMgYXNzaWduZWQgdGhl
IHNpemUgb2YgdGhlIHJlZ2lzdGVyIG1lbW9yeSByZWdpb24gaW5zdGVhZCBvZg0KPiB0aGUgb2Zm
c2V0IG9mIHRoZSBsYXN0IHJlZ2lzdGVyLg0KPiBUaGUgcmVzdWx0IGlzIHRoYXQgcmVhZGluZyBm
cm9tIHRoZSByZWdtYXAgdmlhIGRlYnVnZnMgY2FuIGNhdXNlIGEgc2VnbWVudGF0aW9uDQo+IGZh
dWx0Og0KPg0KPiB0YWlsIC9zeXMva2VybmVsL2RlYnVnL3JlZ21hcC94ZG1hLjEuYXV0by9yZWdp
c3RlcnMNCj4gVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFnaW5nIHJlcXVlc3QgYXQgdmlydHVh
bCBhZGRyZXNzIGZmZmY4MDAwODJmNzAwMDAgTWVtDQo+IGFib3J0IGluZm86DQo+ICAgRVNSID0g
MHgwMDAwMDAwMDk2MDAwMDA3DQo+ICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwg
PSAzMiBiaXRzDQo+ICAgU0VUID0gMCwgRm5WID0gMA0KPiAgIEVBID0gMCwgUzFQVFcgPSAwDQo+
ICAgRlNDID0gMHgwNzogbGV2ZWwgMyB0cmFuc2xhdGlvbiBmYXVsdA0KPiBbLi4uXQ0KPiBDYWxs
IHRyYWNlOg0KPiAgcmVnbWFwX21taW9fcmVhZDMybGUrMHgxMC8weDMwDQo+ICBfcmVnbWFwX2J1
c19yZWdfcmVhZCsweDc0LzB4YzANCj4gIF9yZWdtYXBfcmVhZCsweDY4LzB4MTk4DQo+ICByZWdt
YXBfcmVhZCsweDU0LzB4ODgNCj4gIHJlZ21hcF9yZWFkX2RlYnVnZnMrMHgxNDAvMHgzODANCj4g
IHJlZ21hcF9tYXBfcmVhZF9maWxlKzB4MzAvMHg0OA0KPiAgZnVsbF9wcm94eV9yZWFkKzB4Njgv
MHhjOA0KPiAgdmZzX3JlYWQrMHhjYy8weDMxMA0KPiAga3N5c19yZWFkKzB4N2MvMHgxMjANCj4g
IF9fYXJtNjRfc3lzX3JlYWQrMHgyNC8weDQwDQo+ICBpbnZva2Vfc3lzY2FsbC5jb25zdHByb3Au
MCsweDY0LzB4MTA4DQo+ICBkb19lbDBfc3ZjKzB4YjAvMHhkOA0KPiAgZWwwX3N2YysweDM4LzB4
MTMwDQo+ICBlbDB0XzY0X3N5bmNfaGFuZGxlcisweDEyMC8weDEzOA0KPiAgZWwwdF82NF9zeW5j
KzB4MTk0LzB4MTk4DQo+IENvZGU6IGFhMWUwM2U5IGQ1MDMyMDFmIGY5NDAwMDAwIDhiMjE0MDAw
IChiOTQwMDAwMCkgLS0tWyBlbmQgdHJhY2UNCj4gMDAwMDAwMDAwMDAwMDAwMCBdLS0tDQo+IG5v
dGU6IHRhaWxbMTIxN10gZXhpdGVkIHdpdGggaXJxcyBkaXNhYmxlZA0KPiBub3RlOiB0YWlsWzEy
MTddIGV4aXRlZCB3aXRoIHByZWVtcHRfY291bnQgMSBTZWdtZW50YXRpb24gZmF1bHQNCj4NCj4g
U2lnbmVkLW9mZi1ieTogQW50aG9ueSBCcmFuZG9uIDxhbnRob255QGFtYXJ1bGFzb2x1dGlvbnMu
Y29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZG1hL3hpbGlueC94ZG1hLmMgfCAyICstDQo+ICAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4NCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZG1hL3hpbGlueC94ZG1hLmMgYi9kcml2ZXJzL2RtYS94aWxpbngveGRtYS5j
IGluZGV4DQo+IDBkODhiMWE2NzBlMTQyZGFjOTBkMDljNTE1ODA5ZmFhMjQ3NmE4MTYuLmNiNzM4
MDFmZDZjZjkxZmM0MjBkNmE4YWIwYzk3DQo+IDNkY2RiNTc3MmY1IDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL2RtYS94aWxpbngveGRtYS5jDQo+ICsrKyBiL2RyaXZlcnMvZG1hL3hpbGlueC94ZG1h
LmMNCj4gQEAgLTM4LDcgKzM4LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfY29uZmln
IHhkbWFfcmVnbWFwX2NvbmZpZyA9IHsNCj4gICAgICAgLnJlZ19iaXRzID0gMzIsDQo+ICAgICAg
IC52YWxfYml0cyA9IDMyLA0KPiAgICAgICAucmVnX3N0cmlkZSA9IDQsDQo+IC0gICAgIC5tYXhf
cmVnaXN0ZXIgPSBYRE1BX1JFR19TUEFDRV9MRU4sDQo+ICsgICAgIC5tYXhfcmVnaXN0ZXIgPSBY
RE1BX1JFR19TUEFDRV9MRU4gLSA0LA0KDQpOaXQgLSBCZXR0ZXIgdG8gY2hhbmdlIHRoZSB2YWx1
ZSBvZiAjZGVmaW5lIGl0c2VsZiBhbmQgd2UgY2FuIHJlbmFtZQ0KaXQgdG8gWERNQV9NQVhfUkVH
X09GRlNFVD8NCg0KV2lsbCB3YWl0IGZvciBMaXpoaSBhbmQgQnJhaW4gdG8gY29uZmlybSBpZiBY
RE1BX1JFR19TUEFDRV9MRU4gLSA0DQppcyBoaWdoZXN0IHZhbGlkIHJlZ2lzdGVyIGFkZHJlc3Mg
YXMgcGVyIElQIGRvY3VtZW50YXRpb24sDQoNCj4gIH07DQo+DQo+ICAvKioNCj4NCj4gLS0tDQo+
IGJhc2UtY29tbWl0OiBiMzIwNzg5ZDY4ODNjYzAwYWM3OGNlODNiY2NiZmU3ZWQ1OGFmY2YwDQo+
IGNoYW5nZS1pZDogMjAyNTA5MDEteGRtYS1tYXgtcmVnLTE2NDljNjQ1OTM1OA0KPg0KPiBCZXN0
IHJlZ2FyZHMsDQo+IC0tDQo+IEFudGhvbnkgQnJhbmRvbiA8YW50aG9ueUBhbWFydWxhc29sdXRp
b25zLmNvbT4NCj4NCj4NCg0K

