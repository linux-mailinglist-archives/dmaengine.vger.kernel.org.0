Return-Path: <dmaengine+bounces-5899-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4FB15B1E
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 11:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EF4418C0D2C
	for <lists+dmaengine@lfdr.de>; Wed, 30 Jul 2025 09:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2A6293B5F;
	Wed, 30 Jul 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="S36L+XnI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C2325771
	for <dmaengine@vger.kernel.org>; Wed, 30 Jul 2025 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865975; cv=fail; b=UrLbNPg3wH6yB8KLmNnSkSt5udfXMEZUFutr00mwDNQK+3LcBg7/fMTZgPaDDL//1pfuH42A+q+fCGLjRIjVslrEPuwm5jn1M47KLr0AIcInhX6GmqBI2PXIrgTorsfacRUNh2FmSCnHiZA44OyJN4gwPzeLMrnBwO6czo27KrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865975; c=relaxed/simple;
	bh=EMnMRvIqe0Lg4ROncZbcHUSv3pZ37OiPUoWTocz08jg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NNtHGdRGiGJCobZ1KByY3hmpfjvCJeKUDMz/A7ANpJQBgrbhA+U3ltYX8CStQR4z/QHcEHWAdQ9c1+9AsPoiahtljOwBChdez8ARCjMRtGeWBMXIRyb6N5Md+hvBoADQKSXabgbvRn+okiiJpM06kmyaSQz+OU9NZncBdW+FvGM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=S36L+XnI; arc=fail smtp.client-ip=40.107.102.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QmGemExPqmMOCfJbkN6jESccncww0VmlbXOj7wbHEBMKDCvt8zx433Dp269fUaLPd4Q6z1X12vvV2jWWE6JOM1Q2GdWEHUpdylTzTqnDQWdYhhb3b/SEy270GJ3wL8jhwFlVflCoT/OOHkwnO/gahKewxozEVtG2p/BZvciNxid9nC1BJrkCHfeBUb3jknnxH40SaCypcqODY8yUUODRzBI1aMfGFl8D4P3V3xJIcK40U+OH7esAsNvIngpnBQlz74XXtxUjksjujskEHGckd/aPDZnQSo1cJk7gCCI5HzjhWDq7x6EuYQpPYRpb1Ln/WBM6UHmK1wqCYnQXG3AHVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMnMRvIqe0Lg4ROncZbcHUSv3pZ37OiPUoWTocz08jg=;
 b=OmHvlmmj6KNSlpa/Zv1lJeX1EEREvv+YXDecHkbQhf1xtSo96PejK/0SBwffBI5U3PsDbDmfYx5YRUHLYO10lZ1rdyW8s7JEu/4ZDWTReY23Wi+6jmZhlmV9KqUN8kvXsAdqrJieFyhGIQGs8aKWQxc2kkbc4IiwK2rTeKrgObZ/jtGNPBa+fQ86Gsaw1XaH+uoNVlTlo7c3oewa4cyKO1wMa7DuYDnr+4CTn8YCsTMtdE2NB6teVFKOO6Dc/3z2RVCJse+T3V9TtQGuSvQkdSzW1s/Sy0/mnbi2xc+jozJ2PvkO1udUeeGzdzI/SuQwPBdnonbczdXpgcvp0jGyAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMnMRvIqe0Lg4ROncZbcHUSv3pZ37OiPUoWTocz08jg=;
 b=S36L+XnIlgxkUtF6Rhdb5pMI5wGUaOdEHgvCTJJqUtGlJeZDJFHDRfO+JdTSdAA8gFgWFVckC9+xUa4AYARZ8eic8sAF12D+hJcDaybXYCae6oiogHlziX1BLb4asFHg2wrksT6/3BzDAq5vAOLHOJr50TFYc2eJB5Acvxs/DnZ0V8tGIrJs5hEmMQVfurK5jYOflZ0C+H7+YyqLpamI5j5ys4kwqDhYZLY1I1c5kAXVWGMRhDpqPgWPTZwW+iC/EUrS1bJNt2ZfN6zrExiPoz96QmrisgsXgc7V0rRioDa7eKu3Mtw8EaEc9lb48ggGJwNDIIHqK/rAS6uAX8hr8A==
Received: from SA1PR19MB4909.namprd19.prod.outlook.com (2603:10b6:806:1a7::17)
 by CY8PR19MB7713.namprd19.prod.outlook.com (2603:10b6:930:7f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.9; Wed, 30 Jul
 2025 08:59:29 +0000
Received: from SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f]) by SA1PR19MB4909.namprd19.prod.outlook.com
 ([fe80::6ff2:7087:8d0f:903f%4]) with mapi id 15.20.8964.021; Wed, 30 Jul 2025
 08:59:29 +0000
From: Yi xin Zhu <yzhu@maxlinear.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
CC: Jack Ping Chng <jchng@maxlinear.com>, Suresh Nagaraj
	<sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH 4/5] dmaengine: lgm-dma: Added HDMA software mode TX
 function.
Thread-Topic: [PATCH 4/5] dmaengine: lgm-dma: Added HDMA software mode TX
 function.
Thread-Index: AQHcAP2Og4RVSGaCtUao+qYxV0lZerRKMlEAgAAqRwA=
Date: Wed, 30 Jul 2025 08:59:29 +0000
Message-ID:
 <SA1PR19MB4909DB3634A8871C17F34B0DC224A@SA1PR19MB4909.namprd19.prod.outlook.com>
References: <20250730024547.3160871-1-yzhu@maxlinear.com>
 <20250730024547.3160871-4-yzhu@maxlinear.com>
 <576472a3-663d-41c0-9c6d-1b25e0707dcd@kernel.org>
In-Reply-To: <576472a3-663d-41c0-9c6d-1b25e0707dcd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR19MB4909:EE_|CY8PR19MB7713:EE_
x-ms-office365-filtering-correlation-id: 7fe9fe02-c05c-4e85-3b61-08ddcf47647b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OFE4ZFd1T243TW5ITjVsWnU3N1FkZ3cxdVh2cTZybnFFSXF6bnB1d3kyOU42?=
 =?utf-8?B?bVNHMjBxZmxUVXRRbmxsUFpKVDk1MjFxajdPQWVlejRXS3RIeEx3Q3RKdW5E?=
 =?utf-8?B?UlJIWUc0ZUMvNmswK1k4OFZtSVBPVnpkc1RKVGl5MGJ6cWt2N2l6V0xmOEkx?=
 =?utf-8?B?M2JpeWFlcksyU0JpdmxJbDJTdUJGL2xuRmhjZjhnQ2FDSUVMWEdXdU5XcE90?=
 =?utf-8?B?OVNZWFVzaXpXNE1jTTdrS1pmNDhjR0g3N3dVM2RNUXJRaHc2SkNPN0lFK1hL?=
 =?utf-8?B?NmhaYWp3dzlkY0tvdUdzajYxYXR5eDFVc3dtZmFVVTVyRmxBK1BLOUI0a2l3?=
 =?utf-8?B?TVlqc2FvQzVkMkR5aTYrbEZ6bkhBOWVPelo0RGNFUFY5NTJ4cmdmWHptSFc2?=
 =?utf-8?B?NGhBZW8yV0xPWi92anhTRURhbmVKOGlDeGIzVHlQWDVEdENpVnU2ZXJhU0p2?=
 =?utf-8?B?MDhiR0Y1b01FamZWNXF4MDdqUGdwazh5Mll1aHNzSDViSm5SUTBFcXJLbHBa?=
 =?utf-8?B?d0thdC8rcXc3Z1pMMDRFN3JHaW9SS0FWbTZhdEE5Vk85TzN6TFAwcEs2U1M4?=
 =?utf-8?B?MGJ6bk1XendmYTVFcTlZS2djbDQybEdreHBob3dIRnMxNVY2SWMvSDU4Tndq?=
 =?utf-8?B?VXNncWRQODBSVkZ5V2l4cEJBREhRZXhtdE5aUkxUSDNXYUJaUnZqaUdtUXVB?=
 =?utf-8?B?TjlXUG96eE1ZcEQzWmFxdENid0J4NXZUck9TNllMNjE0MGtOc05LTURxL3pT?=
 =?utf-8?B?MjgzcFZpS3VVL3ZQRkc1NzZZWi9hTExydTBQcWNlbHhjT1I2VFAwK2RqUi9u?=
 =?utf-8?B?ZzJkcWNrb1k1eVVGa1l1R1VIN0xPbS9waTF2WTErcCt2OUNpN0ZTZTR2T2NZ?=
 =?utf-8?B?S1J3T1Uvb3dSclhqR0NzU0h4b09CeTR2Y01WZ2pXTWR0d2hFYUtrdlF3V1oz?=
 =?utf-8?B?V084Rmh3VEtjMTZ1QVFOT0FJdUg3bDJxNDhhVUpadVB0bGlwa2N3M3F6SkFD?=
 =?utf-8?B?OWJRTDNMVGhiSmg4MTArN0tOQnZUKy83OFlYd01CM2o0eDdla0lHZjZsNEFz?=
 =?utf-8?B?Y0J3TG8yNmNibkFzc2srcy9GSW5SeTVDY09YVVNNZDM1anNPNkhCamtmcXFV?=
 =?utf-8?B?VWdZVUYxS0VBbCtrS1NnRGVzdzl2clZuVlB0S3pqZG12bEtrcmFzcWdjMUR0?=
 =?utf-8?B?eE41RVE2a1FxSEJJUlh4Ky9WY2JDVHAyWmx3M0R6Vlk4UStPTFNOOCswdzlJ?=
 =?utf-8?B?YTRMODF2ajdQU1h6eUdMZzFiTmx0aE85UnhBWTExTUZQOWsraEdTTVpTTTY0?=
 =?utf-8?B?Vnp0amRFV05NVGUwWGxnQmVsZ1RQQVl3SHUyVFBOVC81NzFQVm0wdmtsa2th?=
 =?utf-8?B?VFJZSnlQbmZSaGloY1owcjZPMDdlSlgxT2R0blEyNmViM01Da3E5RVdsRWhM?=
 =?utf-8?B?cmI5MGRRTTREUmMzOU9Vb2J6clQ3MnY4VE9XdFVmS0xQMjV0eEFjN0tMVTRT?=
 =?utf-8?B?VERxV3plTkxiVFVxeC85YlRCRWR5TTI2Wllvc0tTdnlhZmIwOTAycWdUaDJI?=
 =?utf-8?B?YlZXTGlpMW96RFVJQjFxeFlQdGw5bUV0Qm8yMFdYNDJqZFJTTEU0QmV0N01X?=
 =?utf-8?B?NndHajZjeHd1K2h3RStRTC81WndhRXRMM1lmNi9LM2ZISi9OVy8yOHhXWTBP?=
 =?utf-8?B?NzI5VWg2SWwvbk1KTnFFRmtvWUR6WGxsMVozR05DQlhIOTN5S1craWQ2VHJF?=
 =?utf-8?B?RVQ3QmptRmZpT2sra0F4ems4Y3ZocXE3cU9PS1NuYkZ6ZmdqVEZmUXpxOG0x?=
 =?utf-8?B?VG9Td0JraVhMNHEvc21mZis3RjZ1R0RDU0RteTJuU28rbzIxd0dLUlJ1bFQz?=
 =?utf-8?B?QU43YmIwUW85aDFoWVFPZXlTaDh4STJUUnV0WW0zL2RpbEFPbXF1ejROWVNM?=
 =?utf-8?B?ekRvU0xVc3FQQzlHdVNEcjgrd1JVSCtVNS91MUVYSUlmRi9TUms5THFKdEhy?=
 =?utf-8?B?QnhIKzZVRWl3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4909.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MkRNR3lGME5XakMvVUlyYy9tYVFBMXUwRFRERFNmdXhLL21RUnp6dUZmM1Fx?=
 =?utf-8?B?QVN4TjlUdkIwbkREMGJETmhGckFSZ1VvOVJFaUlEeG1LVGVHMkh2NWVranBB?=
 =?utf-8?B?Vy9qakRPSDJEcFllU3pabE1ncVZacjZSRUVuT2VLTU43UTdWRFZvSU9Ddmla?=
 =?utf-8?B?YitSUlMrNE5oRysvQU1uWHZseDFBdjV5TnUwS0N6cWNkbC9GOWhKdzBVRjJo?=
 =?utf-8?B?ejRxREZraVRMd0JxeEhZalJmN2swVUg1TmphZ2FBV3UzdlczL3BSUEdTMW54?=
 =?utf-8?B?bXJxSktORW1TT0NuaXZJZEczT29reHRzOUpSN2J3S0twK251YlB1Mk5XWDF6?=
 =?utf-8?B?TDlrdm5vYXVYN3Zzb2YvTUd2R3pPalJ2WmFWVkhJSGpxTjl3dWEzWnFNdnNR?=
 =?utf-8?B?MThHd3c3cU1xVGFHL0NDWmE4QXI5UlJoMlQybFAzaTV1ZjBwVy85NmEvdHgz?=
 =?utf-8?B?V2FyWkJqNU1OOGt6bkc3UW93S1RHTjFzSGtFREl3Q2x3dGtjdS95U29VcEF0?=
 =?utf-8?B?c3h0YVhSSkhEdU93VmdtYWl3d3VTWjcvNi9DVk5hWWhEbllUSWp5OHdUU2V5?=
 =?utf-8?B?M01KQUUvWWNDRDZ6eDJqdC9KZ2hIdHNvell4UmExQkVoODh5Szl4R3ptbmxG?=
 =?utf-8?B?SStVaDdiU21PamRhZ2hqTzdZOXNXTHdaQzdLUWp0aE5rRnVhZ2pGZjhwaC9O?=
 =?utf-8?B?YUhoM1JScmdQd1g0eHNoMEk0bWR0ZzE3azlZYUlxR3lYR0xRU2RtVjhla0J2?=
 =?utf-8?B?UnFVM3d5T2tYdXdaSTFQcmVXTUZ5OHFIZEhBTkNCdHV5cDNwWUxGY2FRMU1r?=
 =?utf-8?B?WU9HU3liQ2NCNDhJVzFwQ00yZXdGb3lSc3VaYlBWQXRja21uNGtTai9QeTJn?=
 =?utf-8?B?WG5TdWl2eHUrUmNUblFKc1NoRXFnWndBN1hqOU1PbE5PTWE4Mk9TdlBYZmg5?=
 =?utf-8?B?b2RnQkhzaG9tbHQ5VUZ2aWFTTERBL29EZ3c4UU1sdVpGWkFpcllDMmNlMkhQ?=
 =?utf-8?B?eFQ4aVpFdUw5d1ZxWHRFZmVmUVl2K2s4VUE3b042U3J6V1BLRGI0VENpa20x?=
 =?utf-8?B?WnhOUEdsUHNMdlN6RE5lVXFHcUI4RUdBZGdvZGFYcUtpUldhQWtlVkdIR3NS?=
 =?utf-8?B?bDJlRU93U3ZGakxhejBINStuN3dVYllCYUJxVUtlT0t6U3BvbEl4YU4vVU9S?=
 =?utf-8?B?NFZ6YlNmWThiTjdIMDhjT1JoMGRDNzNEd1Arck1xZkUrNWJ5UCtibXNRMEZy?=
 =?utf-8?B?R1MzMndVNlBmaDg0dmlvSk5JdFJzM1BIUVFMdzlsaTFiVUx5WmJKbHFnajNi?=
 =?utf-8?B?UVd2QXdiSmd5bGtIWjAyS2t2djVXbCtRckl3OVo0RHRMTU1VYWVQVXRKd01K?=
 =?utf-8?B?WkkzVUhOdmxOZldDWXhSSDBnTjdaRDBrN0F0L0hSbnptM2FkbGpXcXJqazJB?=
 =?utf-8?B?cEFXUGgrS3dPVkRTbzFtejVjaU5Zckltak45SVVlUDZCRmZiNWdIZ3dEV3Zm?=
 =?utf-8?B?U1grUXByTWMwNHNvL3lpZ09CcXp4bGpha1pUMnVYRGgxUGxVREh5cHVrallo?=
 =?utf-8?B?eTRrcGxvMEV0eFAxcUpZbjhSekJFbDdKcVVzMHR2ZTMrcEFpMElXM09FK2Ev?=
 =?utf-8?B?VkQyamdOTnVtZnU0MllyWE9EOUlMclB3T2lpUk9hOWxjdFFUK3VvY2ttdWdp?=
 =?utf-8?B?aUxGWUpBUWE0bmFZbnhSYjZBcjBuaWRNY3IvSmswNnYyRGNqZWQxSUVYSEc2?=
 =?utf-8?B?M3dHM1A5aGVsbk80WWxkQlZLTGpYRHM4QTBNR2h6WWg4YUdNUVNmWVRFL2Jx?=
 =?utf-8?B?d1pjYkYyaEFwY2NpMHVsOTRzZjdwcXpsRWxRYko1TFlYT1c3TXl4QmllR0w0?=
 =?utf-8?B?L2xrbkNFUytvWEkyYi92Kzg4TlJmTTlhYkQySUJhanp2WFByaVRyS0c1Wktm?=
 =?utf-8?B?eXpFMDRTT0ZMYjFlNndIdFArSk9teGxCM0gyUGZZelZGTnRJSC9zLzE0d3Z2?=
 =?utf-8?B?WGdENlJqOVZvc1N2bkVTRnlHRDFFV25hNVBqMWVVVkxwSkpiRTlWcnFtZHZy?=
 =?utf-8?B?Ylhkbm5GVjNnZE5HazVTbjFuQXkvVXJGOUhCQldlSXcrUzVEUVNWVkFuL2RX?=
 =?utf-8?Q?qhVeCGYZoaTGm1fIdO1qCSwAJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4909.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fe9fe02-c05c-4e85-3b61-08ddcf47647b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2025 08:59:29.1564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fVX5HJAepQMxR/QK7EMAzT5AijO3Jx9KGjEbZyeLZRWydujaa0XH2IJJ1ZIRUOSvagvxzOhJHHYbmK378dTo1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7713

SGkgS3J6eXN6dG9mLA0KDQpPbiAzMC8wNy8yMDI1IDE0OjIxLCBLcnp5c3p0b2YgS296bG93c2tp
IHdyb3RlOg0KPiBZb3VyIGNvbW1pdCBtc2cgZXhwbGFpbnMgbm90aGluZywgc28gYmFzaWNhbGx5
OiBuby4gV3JpdGUgcHJvcGVyIGNvbW1pdCBtc2dzDQo+IGRvY3VtZW50aW5nIGhhcmR3YXJlLCBu
b3Qgc29mdHdhcmUuDQo+IA0KPiBQbGVhc2UgcnVuIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBvbiB0
aGUgcGF0Y2hlcyBhbmQgZml4IHJlcG9ydGVkIHdhcm5pbmdzLg0KPiBBZnRlciB0aGF0LCBydW4g
YWxzbyAnc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tc3RyaWN0JyBvbiB0aGUgcGF0Y2hlcyBhbmQN
Cj4gKHByb2JhYmx5KSBmaXggbW9yZSB3YXJuaW5ncy4gU29tZSB3YXJuaW5ncyBjYW4gYmUgaWdu
b3JlZCwgZXNwZWNpYWxseSBmcm9tIC0NCj4gLXN0cmljdCBydW4sIGJ1dCB0aGUgY29kZSBoZXJl
IGxvb2tzIGxpa2UgaXQgbmVlZHMgYSBmaXguIEZlZWwgZnJlZSB0byBnZXQgaW4gdG91Y2ggaWYN
Cj4gdGhlIHdhcm5pbmcgaXMgbm90IGNsZWFyLg0KPiANCj4gPGZvcm0gbGV0dGVyPg0KPiBQbGVh
c2UgdXNlIHNjcmlwdHMvZ2V0X21haW50YWluZXJzLnBsIHRvIGdldCBhIGxpc3Qgb2YgbmVjZXNz
YXJ5IHBlb3BsZSBhbmQgbGlzdHMNCj4gdG8gQ0MuIEl0IG1pZ2h0IGhhcHBlbiwgdGhhdCBjb21t
YW5kIHdoZW4gcnVuIG9uIGFuIG9sZGVyIGtlcm5lbCwgZ2l2ZXMgeW91DQo+IG91dGRhdGVkIGVu
dHJpZXMuIFRoZXJlZm9yZSBwbGVhc2UgYmUgc3VyZSB5b3UgYmFzZSB5b3VyIHBhdGNoZXMgb24g
cmVjZW50DQo+IExpbnV4IGtlcm5lbC4NCj4gDQo+IFRvb2xzIGxpa2UgYjQgb3Igc2NyaXB0cy9n
ZXRfbWFpbnRhaW5lci5wbCBwcm92aWRlIHlvdSBwcm9wZXIgbGlzdCBvZiBwZW9wbGUsIHNvDQo+
IGZpeCB5b3VyIHdvcmtmbG93LiBUb29scyBtaWdodCBhbHNvIGZhaWwgaWYgeW91IHdvcmsgb24g
c29tZSBhbmNpZW50IHRyZWUNCj4gKGRvbid0LCBpbnN0ZWFkIHVzZSBtYWlubGluZSkgb3Igd29y
ayBvbiBmb3JrIG9mIGtlcm5lbCAoZG9uJ3QsIGluc3RlYWQgdXNlDQo+IG1haW5saW5lKS4gSnVz
dCB1c2UgYjQgYW5kIGV2ZXJ5dGhpbmcgc2hvdWxkIGJlIGZpbmUsIGFsdGhvdWdoIHJlbWVtYmVy
DQo+IGFib3V0IGBiNCBwcmVwIC0tYXV0by10by1jY2AgaWYgeW91IGFkZGVkIG5ldyBwYXRjaGVz
IHRvIHRoZSBwYXRjaHNldC4NCj4gDQo+IFlvdSBtaXNzZWQgYXQgbGVhc3QgZGV2aWNldHJlZSBs
aXN0IChtYXliZSBtb3JlKSwgc28gdGhpcyB3b24ndCBiZSB0ZXN0ZWQgYnkNCj4gYXV0b21hdGVk
IHRvb2xpbmcuIFBlcmZvcm1pbmcgcmV2aWV3IG9uIHVudGVzdGVkIGNvZGUgbWlnaHQgYmUgYSB3
YXN0ZSBvZg0KPiB0aW1lLg0KPiANCj4gUGxlYXNlIGtpbmRseSByZXNlbmQgYW5kIGluY2x1ZGUg
YWxsIG5lY2Vzc2FyeSBUby9DYyBlbnRyaWVzLg0KPiA8L2Zvcm0gbGV0dGVyPg0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KSSdsbCB1cGRhdGUgdGhlIGNvbW1pdCBtZXNzYWdl
IGFuZCB3cml0ZSBwcm9wZXIgZGVzY3JpcHRpb25zIHRvIGV4cGxhaW4gdGhlIHBhdGNoIGZ1bmN0
aW9ucy4NCg0KQmVzdCByZWdhcmRzLA0KWWl4aW4NCg0K

