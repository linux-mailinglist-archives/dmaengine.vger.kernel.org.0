Return-Path: <dmaengine+bounces-4057-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF349FBB5A
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 10:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63634163D5F
	for <lists+dmaengine@lfdr.de>; Tue, 24 Dec 2024 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320261AF0A4;
	Tue, 24 Dec 2024 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UjQqP3M2"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2083.outbound.protection.outlook.com [40.107.105.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713C8192D6A;
	Tue, 24 Dec 2024 09:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033192; cv=fail; b=a+C2O2Iq+xdZSjc2KAz2/hOvvFTqjB81SAd3Ih9j9kCLoOIja6hq6J8mwmOpOtQRR4Mi4zeflWr2HYB1c0MjT5a6NUOUYVYz/Af5uQnnVdSD9y6J2atbakrBlLnEtfDCSZLTyhVqQyGItZlF0PkTy352kHVV8500pRHgBBK3MxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033192; c=relaxed/simple;
	bh=k2eE1u8zrnJ495jWTNINyYlyh5nV6NzDvkyGsmPc/4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WlADT12RI/msbDJsCucWDELfJ1LxOa9AjvrdPIFU9iPqBK67E4vHdPKlnMZValghN6V9RuRKXXZ/i1E4dE+YeAYwo2y6e4dPEj6usozxJh1Zbjn8Y7Ha/GmN/Trq1/mfozuLWiOtuoZDWgjkceWU7ooq4ckcvPSqQGWlLj6rV98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UjQqP3M2; arc=fail smtp.client-ip=40.107.105.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8Izom5hYWipybS6PX5WVHcQ0IT70aoJ8J+3aQ4m1HQ9BrKPfv5aIRWdi0z39o3YLf9m1ZENiYXYocjRXtXsjEBoF4d0vkLKO8mvW6EHLsujW8ZQODwEtaYJXGFAjTVxtm0bSv497JqaUd/KCJG7FJ+O/ESqrDpJVZ7IBSIIXAzx6prHi9pTsoAyKWmsqPXqqs5ForhVSJxWtxNq9paNm0mhr26Fgs/QR+/huYZDC7xzrctw4b3+Inm6IxBVBrmGLRGitneD3eLp6Xko0wYBTL0S7oh8SFG/aHJDGscXW66wmF3qtgDznIV21kqtB2Bva3aehuvlytDQxsWCTpy89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2eE1u8zrnJ495jWTNINyYlyh5nV6NzDvkyGsmPc/4U=;
 b=M5DfIub/JqVZ3hQZKKuvkqeyuKy9p/4d0pxq6ik/6QcPEerGfj3VkTaGGAjklJ3gsAvBk3Lin50dew2uuCjGxOoLUewqy9ZdujP23C03wBYyKHkuH2WE9DRchSQAGAiHUlNMHExsi/njWnU2umfvyhruhQWl+ClSoUM+0DR3c+RdbD1KO295g/lV1nl5qsD0cmwOLDQmjaYQojTXvyqo2yHzn5/aB7Dt7GL6yloGjJALwYAIwhp74awa1wEkq8X44QZan7YGO7mtvkSLgn14a/fqmm0UxwKEzciGyjCq7MsHhSmyy9NyBeAP+CWLgjJzezTCH+/OuzV4nDkV1g0v9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2eE1u8zrnJ495jWTNINyYlyh5nV6NzDvkyGsmPc/4U=;
 b=UjQqP3M2A8Zpor+BzG1KmKmyO5iGEbh1lr24JwG2xZEkD947o3u6s4cLnUEwhfbBedqXlLHdDW82WV++Bp48nWt+jcySQjcQtwnCj+ouZHe8G3ltADFG06sS7IborhxJp8urmR5MsohSXnfJwnh0lyZZ1URD8KiT6fhC3ckxq45dy2mXznPZ5leTABKFHPIH7x3ddhYTZhA00lk07Ah3AvXnlAWgAW7yNnoOwi5056c20Be+3+p5ONFa7mqIfkzV1DxgwOrIaDsl9y2n2vMM652nfVns7ijXZgKvvte0BKpq/UAn6FGlyqgzUUesajS1YIebJhEQ9EZEVECih1DoIg==
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by DB9PR04MB9353.eurprd04.prod.outlook.com (2603:10a6:10:36d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 09:39:42 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%6]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 09:39:42 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "S.J. Wang" <shengjiu.wang@nxp.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "dmaengine@vger.kernel.org"
	<dmaengine@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] dmaengine: fsl-edma: add runtime suspend/resume
 support
Thread-Topic: [PATCH v1] dmaengine: fsl-edma: add runtime suspend/resume
 support
Thread-Index: AQHbVefCoUFFFsc2NkOUTcFpKGIXYA==
Date: Tue, 24 Dec 2024 09:39:42 +0000
Message-ID:
 <AS4PR04MB93860BD6D4C5E84363F5D8A5E1032@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20241220021109.2102294-1-joy.zou@nxp.com>
 <Z2p/CLHFqdamp4Bq@vaman>
In-Reply-To: <Z2p/CLHFqdamp4Bq@vaman>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|DB9PR04MB9353:EE_
x-ms-office365-filtering-correlation-id: 788fea7d-b195-41c4-2ec3-08dd23fee4d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?cXZSZ3FzTlowMnJVc0RGYkNPM2dhK3NQL1ROa2lMYlAvZWxJOEhGdnFZL0Ey?=
 =?gb2312?B?YzZXZjF0bGZ1d1ZyQlFWcVhLeDlQbGZqaFZ2UmhrQm9OWDZMTld4SUkrb3BC?=
 =?gb2312?B?ZDQ1Ymp5RERlb2Q3UGI4Zm5xQmVTdXhvb0FpZjhhdTJLUGxuZ3EyWGxrbUhw?=
 =?gb2312?B?dGZqcGEyUm5jTEc3bmRiTEtGZlI4dmhlRjZGWk0wU0dDREphVEIyWTZCM3JF?=
 =?gb2312?B?UXdhWU9pVytaajJtMUVKN0NYWmdEM1VZa3VKdHdHb3ZQdjZCQ0UzMkZRVE10?=
 =?gb2312?B?THNsQlFPWC96ZGxYUmpjOWR3MFhRbk10OFk5UGc5aDl2czFxUi80THZNM3A1?=
 =?gb2312?B?WWpXZnhIL2g1VG8wZ1h5T2ZNc3N1Nklza045cXoveWl0NTMzWU9FL09NQmp3?=
 =?gb2312?B?V3Y4cXc0Q29TRHppSm5hMEg2OHp5RU5UZGp5WnA3bzdpaW9TTDFxcUtwT0xO?=
 =?gb2312?B?OTY3RHBLUGRlekFyQTNMREZad281UnZyaE9VZDZOdDVDeDZWSXo0Q29pcytm?=
 =?gb2312?B?TEQvVFRIZUZnM2FSL3lWWHFtTDVoaTJiMEtDMWVuZXN0QzB6THV0N0NYbmxY?=
 =?gb2312?B?S1kxNGRRbzJkdDk3cUt6RzZRYlJMSjFSRzVoeGQzVUVySlkrZGFJUzMzRGU5?=
 =?gb2312?B?dnJ1N1ZkdzZNcjVLam51UnlYZG1SRVZ3aE0yVEN1YjQ0OEc5VHlmMkxpeVNN?=
 =?gb2312?B?bzV1NHdieGF1OVQrNFNGTUZNa2tuS0IrZE0wS2VTYkJ0S1psSXZjUWhQR1A3?=
 =?gb2312?B?QU9ZdTJyRW82TEUreE5FMDNnN3dDUEkyejd2ZmVISEJGMFltKzBoZGM5Nks1?=
 =?gb2312?B?M1JoZ28xZGluZ0RiQTFzMzE5WGFZZEFwRFVDTnVsZWlKZTlCa0g5b2lnK3VJ?=
 =?gb2312?B?SHlUVUxTMCtzMzNJTklZNEtVV2FLMFZrU0lwQnVNblVvaDJ0VXVxcjNON2lP?=
 =?gb2312?B?MDROWjA5WnBuQmZFajhFUWp4MUh0VFZ5TGRYZWR2bXpoWFU3eEdNSytTRTBn?=
 =?gb2312?B?MEN5OTBlaXlvUk04eXcxT0NjdVdITGNDTXFOaUN1d01rVWc5cVB1VmFKUEdo?=
 =?gb2312?B?T2RZbk9QdzhDaERWOWxVYXVKalBuQ3JPcWRaQTVoaFBLZ1VNQzg0MHJaMGxY?=
 =?gb2312?B?a2tkYXhpUkFQSkNxZ3B1OHVIc1BDRnJrakZiK3FIdGhPMHV6OHhTZlExWmlQ?=
 =?gb2312?B?algySTFrSWY2UkUzRC9Bc2duazRYT1YydmlocG1RWmVBQkxqb205dU5hMmtW?=
 =?gb2312?B?Y1hITEdISitLbGlQdVZSa1o2WEM5dXkyR2sxbmUyR3hhaGhiS0M4dmVydXYy?=
 =?gb2312?B?Z3FxT3hEK3BXb2RzanlUWTFGWlpiTUtBd29tL1RGUHpjRUw5OXZtQy9aVXNO?=
 =?gb2312?B?RFc4d2V6MDlscUxORUNCQ3ZNeUNOZU1Gc0wvdm5qZWtHSGs5a3MzaW04L1FN?=
 =?gb2312?B?aXN4TjZRcVdneG1KbTZWK3d0cUI2TUl4dU1hSXM3dVhiazhvdm1IRURocHFX?=
 =?gb2312?B?K2hhWjNoU0JNbWlHQ09EUjB0VTlET3UvR2Y1cnRpQWFJRVJFZWlNdlVFOWw2?=
 =?gb2312?B?U2ZvcFM5M1lkbFBFYi9ya21tWWdEdlV2TVlTcEVuTVRlNEVBUVY1TzVyT1RX?=
 =?gb2312?B?cU00UGZqWklMa3U1Wjh5M0llZmJOelBOVWcxVm5HeUdiV3dIeFc4VGRKTnV4?=
 =?gb2312?B?SUE5cnc0Rmc1UlBSWThZeksvTVorZW95V2pJMDE5amIrRFUzZDNwZ2hUS0Vo?=
 =?gb2312?B?MHlCZ3ZPYTZ2cHVFTU96ekJFNis2M2d6Ykc2K1YybzFlRlljMzdWSkVKNVNm?=
 =?gb2312?B?aVRETUZBOVRLdG54SDNsSmkxQ1RCODFjK05vMUtZVkpCeVE4OVl1SVpvMzU4?=
 =?gb2312?B?RE5yQTRuVlc4b3E5dHlOS2tHM1dmUFJ2cmU5UENHRGdPR1RKYzZsbGp6Yytx?=
 =?gb2312?Q?uKzNnqmrk779lSy2p9XN1mT9q5t8haJ0?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?cnBOSlJPRDMydWg3c3o2NzQ1REYzYThFSjE2NlNJTlAwMmxCQ2NWbUpxZUl6?=
 =?gb2312?B?NjY3aFp1S1RoU2tvbldJMXMzaW5heG4yd2ZuWjV4OEt0T1hGUTlHUG5adU9o?=
 =?gb2312?B?UGUwUmo1Vnh2RXY5M0J0cHlMTHR2V3JaWFFiUC9DUnhxME40TnBBZTBReGtl?=
 =?gb2312?B?NTYrU1BBZzFmNzE2TGlhYmM0WklxWFJPb0ZpQll0aXp0bGVNT0tSZThpMXhr?=
 =?gb2312?B?YmlCQi9iTkl4bktPeTlyRGRnRDZmS3dxT2xUUmZPbWFCYldUNTNlWDNjVGNM?=
 =?gb2312?B?b2FSRGhGYlVmeXZVdjA3SWRGWTVQSzNNOUk3bU5nalUwdnVDNXpXSC9QUTd1?=
 =?gb2312?B?TDc5aWhXd0NYdDhaSTUwbTl0eVg3SmpoREZpN21SYVBaai9BVm5QbDZxU3h4?=
 =?gb2312?B?dkIzdFpaMkhGY000QURZc2FJOVFlT0pSWDZ5eG95L25FdlNNSGhaVDA2ZDZJ?=
 =?gb2312?B?UXhIK01WMTJadzNMNVZDYkEzeDVFZXdaanRLK0MwRXpxVkkxQmZvaDhnSWVM?=
 =?gb2312?B?NjdNenozK1ZEdVl0RUlqVWQvOGFqS3hIODlZZTc0WUI4RXVqaktYNmRkODdN?=
 =?gb2312?B?SkJCL2puK2VmSDVhVCtSYzVxRWRnSGFuNXhIakJ4RmVRbGI3NWVrL0hZdW1w?=
 =?gb2312?B?bTRVMGpFK2h4S2hVa0d2MkFvUm1pUGJuMDdNaHpleFpCOHIvZFY4MVBxa00r?=
 =?gb2312?B?czhQZ05FU0lISEQrL3EyZXdNNzcvM3dobmFvV0VtUUNCOWtxR2hyV1J5QXR4?=
 =?gb2312?B?VU93dHIybHIxMmk3cXhmRUNUOW5hSW40Nk5KTTFCMW1QdERzRnByY0pGN3VX?=
 =?gb2312?B?NUpjMnBRUzByVkxhQjU5WWpTemlScm04aFFGaGF4UlpwRTJpVU9XL3dUbXNy?=
 =?gb2312?B?Y21Fb25YbENwZUl2NUlSa0o0eUwzejVBelgyOHkrdW1Wb0VDNkQyUE1xVTJJ?=
 =?gb2312?B?ejJld2FHR2V1K3NKaVpmbDlPUWhnSUdsQ1VzVURkdGE4YTFBSjBhbHZjTTN1?=
 =?gb2312?B?ekUybHVEMmF1V1ZwTGRKVjJMcVZIeHJzbXZTOXZzMG1OYmtacEZGeE1GQzcz?=
 =?gb2312?B?QkpWazg3V2F2dWtRKzU4SnNvZTFURWowZEFPK1JEaGdNSWNNcmhoUjRCdldH?=
 =?gb2312?B?V012VUZDUDIzSWdPWUpMdDZBcTJNWGxMK3JQaEVUK0MvT2hWa3lOUGtKNTlm?=
 =?gb2312?B?dmd1UkJUbno1MTNIOUFaSE0zUExZU0d0NnhCczhQZnltcnBBejVxVWpJOWVu?=
 =?gb2312?B?WklzWFRmTjhNN1BDSzc5V1RQTk5DUG43MFQrbG1pU0EyR1RRdE40UDZHTlNz?=
 =?gb2312?B?MTJvL04yVkd3b0tqWmxpVTY3NVdYejhHaVRPWlBySzdzNzRac1R5eEo2cVV6?=
 =?gb2312?B?ZVRSWDAzREc4aUxpYjVET2RyVWpRZGVZVXc4N3hFSUVmUk9pWHRHTTF5QUM3?=
 =?gb2312?B?NG5iaXRSSHVrd3liSXdPYWhEZ0l6ZFcyTkZGbUE2QTJqa2JXYytFTmZkMkJm?=
 =?gb2312?B?OFcrengydG41Zm5QVmxMWTNYR0FUTzZYM3U2NER3YUtobFY1YnJiU2Z3Q1NZ?=
 =?gb2312?B?ZnBtdVFhVVcyN2Fnc3dXVTZWSmlJdjZDYWhqS3p5ckI3aXd1dG5Yd2ZxSXNM?=
 =?gb2312?B?VjkzM3AzOGxDaVZWWmcvS1Q5MDIxbjI5U01XQ2lUNTBtVjF6dnhSMWV3aDJD?=
 =?gb2312?B?cUlvdG4xa0J0QWVqbE5LN2p1TkhuY0Z6ZmwvN0E4MGxid2lmU2hZalo1aVkx?=
 =?gb2312?B?cXZ4TGlESGhOUEJVcE9VTWpkR3hVQkVOOWpnbHFFci9OemEzMjNpeDUxZWxL?=
 =?gb2312?B?czJQN0FwVDd4Q3dtblBHT29COG8vRXhJcnpXU0x3bmpPU3hEVncwOFprU2ln?=
 =?gb2312?B?Z2t3NkN3RGF4VHdsaU5MNVZlamYzbWZ5WDlFMVR6a3FRZWQ1Nnd6dEF5MW1a?=
 =?gb2312?B?WlZIb2k3WklLd3JXeTc4a29udXlHVHd0OCt3Tk03MWxqRTBxZVNUN1JCL28z?=
 =?gb2312?B?emFPNHZiQ1pWL211VzRpVk1HUmdtRjJ1eFlkbGRqZkdGTWRkM2o0ODV2Y2c4?=
 =?gb2312?B?WmsyTTlmRnMzME9WdEFkWmtFTExoQkg3dnhKV1NCNHBRM3V4UERzazRhS1BJ?=
 =?gb2312?Q?IV4M=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788fea7d-b195-41c4-2ec3-08dd23fee4d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 09:39:42.3496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTzgQYhRkgFiZa9aHIIiKSGUcrZnYWHvz/U0xNhNcAxN5yAQDUBb83g+oXH0tJx2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9353

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlub2QgS291bCA8dmtv
dWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqMTLUwjI0yNUgMTc6MzANCj4gVG86IEpveSBa
b3UgPGpveS56b3VAbnhwLmNvbT4NCj4gQ2M6IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsg
Uy5KLiBXYW5nIDxzaGVuZ2ppdS53YW5nQG54cC5jb20+Ow0KPiBpbXhAbGlzdHMubGludXguZGV2
OyBkbWFlbmdpbmVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIGRtYWVuZ2luZTogZnNsLWVkbWE6IGFkZCBydW50
aW1lDQo+IHN1c3BlbmQvcmVzdW1lIHN1cHBvcnQNCj4gDQo+IA0KPiANCj4gT24gMjAtMTItMjQs
IDEwOjExLCBKb3kgWm91IHdyb3RlOg0KPiA+IEludHJvZHVjZSBydW50aW1lIHN1c3BlbmQgYW5k
IHJlc3VtZSBzdXBwb3J0IGZvciBGU0wgZURNQS4gRW5hYmxlDQo+ID4gcGVyLWNoYW5uZWwgcG93
ZXIgZG9tYWluIG1hbmFnZW1lbnQgdG8gZmFjaWxpdGF0ZSBydW50aW1lIHN1c3BlbmQgYW5kDQo+
ID4gcmVzdW1lIG9wZXJhdGlvbnMuDQo+ID4NCj4gPiBJbXBsZW1lbnQgcnVudGltZSBzdXNwZW5k
IGFuZCByZXN1bWUgZnVuY3Rpb25zIGZvciB0aGUgZURNQSBlbmdpbmUgYW5kDQo+ID4gaW5kaXZp
ZHVhbCBjaGFubmVscy4NCj4gPg0KPiA+IExpbmsgcGVyLWNoYW5uZWwgcG93ZXIgZG9tYWluIGRl
dmljZSB0byBlRE1BIHBlci1jaGFubmVsIGRldmljZQ0KPiA+IGluc3RlYWQgb2YgZURNQSBlbmdp
bmUgZGV2aWNlLiBTbyBQb3dlciBNYW5hZ2UgZnJhbWV3b3JrIG1hbmFnZSBwb3dlcg0KPiA+IHN0
YXRlIG9mIGxpbmtlZCBkb21haW4gZGV2aWNlIHdoZW4gcGVyLWNoYW5uZWwgZGV2aWNlIHJlcXVl
c3QgcnVudGltZQ0KPiByZXN1bWUvc3VzcGVuZC4NCj4gPg0KPiA+IFRyaWdnZXIgdGhlIGVETUEg
ZW5naW5lJ3MgcnVudGltZSBzdXNwZW5kIHdoZW4gYWxsIGNoYW5uZWxzIGFyZQ0KPiA+IHN1c3Bl
bmRlZCwgZGlzYWJsaW5nIGFsbCBjb21tb24gY2xvY2tzIHRocm91Z2ggdGhlIHJ1bnRpbWUgUE0g
ZnJhbWV3b3JrLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSm95IFpvdSA8am95LnpvdUBueHAu
Y29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEZyYW5rIExpIDxGcmFuay5MaUBueHAuY29tPg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYyB8ICAxNSArKy0tLQ0KPiA+
ICBkcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMgICB8IDExNQ0KPiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTEwIGluc2VydGlvbnMo
KyksIDIwIGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hL2Zz
bC1lZG1hLWNvbW1vbi5jDQo+ID4gYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1jb21tb24uYyBpbmRl
eCBiN2YxNWFiOTY4NTUuLmZjZGI1M2IyMWYzOA0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZl
cnMvZG1hL2ZzbC1lZG1hLWNvbW1vbi5jDQo+ID4gKysrIGIvZHJpdmVycy9kbWEvZnNsLWVkbWEt
Y29tbW9uLmMNCj4gPiBAQCAtMjQzLDkgKzI0Myw2IEBAIGludCBmc2xfZWRtYV90ZXJtaW5hdGVf
YWxsKHN0cnVjdCBkbWFfY2hhbiAqY2hhbikNCj4gPiAgICAgICBzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZmc2xfY2hhbi0+dmNoYW4ubG9jaywgZmxhZ3MpOw0KPiA+ICAgICAgIHZjaGFuX2RtYV9k
ZXNjX2ZyZWVfbGlzdCgmZnNsX2NoYW4tPnZjaGFuLCAmaGVhZCk7DQo+ID4NCj4gPiAtICAgICBp
ZiAoZnNsX2VkbWFfZHJ2ZmxhZ3MoZnNsX2NoYW4pICYgRlNMX0VETUFfRFJWX0hBU19QRCkNCj4g
PiAtICAgICAgICAgICAgIHBtX3J1bnRpbWVfYWxsb3coZnNsX2NoYW4tPnBkX2Rldik7DQo+ID4g
LQ0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBAQCAtODA1LDggKzgwMiwx
MiBAQCBpbnQgZnNsX2VkbWFfYWxsb2NfY2hhbl9yZXNvdXJjZXMoc3RydWN0DQo+IGRtYV9jaGFu
ICpjaGFuKQ0KPiA+ICAgICAgIHN0cnVjdCBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbiA9IHRvX2Zz
bF9lZG1hX2NoYW4oY2hhbik7DQo+ID4gICAgICAgaW50IHJldDsNCj4gPg0KPiA+IC0gICAgIGlm
IChmc2xfZWRtYV9kcnZmbGFncyhmc2xfY2hhbikgJiBGU0xfRURNQV9EUlZfSEFTX0NIQ0xLKQ0K
PiA+IC0gICAgICAgICAgICAgY2xrX3ByZXBhcmVfZW5hYmxlKGZzbF9jaGFuLT5jbGspOw0KPiA+
ICsgICAgIHJldCA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoJmZzbF9jaGFuLT52Y2hhbi5jaGFuLmRl
di0+ZGV2aWNlKTsNCj4gPiArICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgICAgICAg
ZGV2X2VycigmZnNsX2NoYW4tPnZjaGFuLmNoYW4uZGV2LT5kZXZpY2UsDQo+ICJwbV9ydW50aW1l
X2dldF9zeW5jKCkgZmFpbGVkXG4iKTsNCj4gPiArICAgICAgICAgICAgIHBtX3J1bnRpbWVfZGlz
YWJsZSgmZnNsX2NoYW4tPnZjaGFuLmNoYW4uZGV2LT5kZXZpY2UpOw0KPiA+ICsgICAgICAgICAg
ICAgcmV0dXJuIHJldDsNCj4gPiArICAgICB9DQo+ID4NCj4gPiAgICAgICBmc2xfY2hhbi0+dGNk
X3Bvb2wgPSBkbWFfcG9vbF9jcmVhdGUoInRjZF9wb29sIiwNCj4gY2hhbi0+ZGV2aWNlLT5kZXYs
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZnNsX2VkbWFfZHJ2ZmxhZ3MoZnNs
X2NoYW4pICYNCj4gRlNMX0VETUFfRFJWX1RDRDY0ID8NCj4gPiBAQCAtODE5LDYgKzgyMCw3IEBA
IGludCBmc2xfZWRtYV9hbGxvY19jaGFuX3Jlc291cmNlcyhzdHJ1Y3QgZG1hX2NoYW4NCj4gPiAq
Y2hhbikNCj4gPg0KPiA+ICAgICAgICAgICAgICAgaWYgKHJldCkgew0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICBkbWFfcG9vbF9kZXN0cm95KGZzbF9jaGFuLT50Y2RfcG9vbCk7DQo+ID4gKw0K
PiA+ICsgcG1fcnVudGltZV9wdXRfc3luY19zdXNwZW5kKCZmc2xfY2hhbi0+dmNoYW4uY2hhbi5k
ZXYtPmRldmljZSk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4g
ICAgICAgICAgICAgICB9DQo+ID4gICAgICAgfQ0KPiA+IEBAIC04NTEsOCArODUzLDcgQEAgdm9p
ZCBmc2xfZWRtYV9mcmVlX2NoYW5fcmVzb3VyY2VzKHN0cnVjdA0KPiBkbWFfY2hhbiAqY2hhbikN
Cj4gPiAgICAgICBmc2xfY2hhbi0+aXNfc3cgPSBmYWxzZTsNCj4gPiAgICAgICBmc2xfY2hhbi0+
c3JjaWQgPSAwOw0KPiA+ICAgICAgIGZzbF9jaGFuLT5pc19yZW1vdGUgPSBmYWxzZTsNCj4gPiAt
ICAgICBpZiAoZnNsX2VkbWFfZHJ2ZmxhZ3MoZnNsX2NoYW4pICYgRlNMX0VETUFfRFJWX0hBU19D
SENMSykNCj4gPiAtICAgICAgICAgICAgIGNsa19kaXNhYmxlX3VucHJlcGFyZShmc2xfY2hhbi0+
Y2xrKTsNCj4gPiArICAgICBwbV9ydW50aW1lX3B1dF9zeW5jX3N1c3BlbmQoJmZzbF9jaGFuLT52
Y2hhbi5jaGFuLmRldi0+ZGV2aWNlKTsNCj4gPiAgfQ0KPiA+DQo+ID4gIHZvaWQgZnNsX2VkbWFf
Y2xlYW51cF92Y2hhbihzdHJ1Y3QgZG1hX2RldmljZSAqZG1hZGV2KSBkaWZmIC0tZ2l0DQo+ID4g
YS9kcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMgYi9kcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWlu
LmMgaW5kZXgNCj4gPiA2MGRlMTAwMzE5M2EuLjc1ZDZjODk4NGM4ZSAxMDA2NDQNCj4gPiAtLS0g
YS9kcml2ZXJzL2RtYS9mc2wtZWRtYS1tYWluLmMNCj4gPiArKysgYi9kcml2ZXJzL2RtYS9mc2wt
ZWRtYS1tYWluLmMNCj4gPiBAQCAtNDIwLDcgKzQyMCw2IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUo
b2YsIGZzbF9lZG1hX2R0X2lkcyk7DQo+IHN0YXRpYw0KPiA+IGludCBmc2xfZWRtYTNfYXR0YWNo
X3BkKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHN0cnVjdA0KPiA+IGZzbF9lZG1hX2Vu
Z2luZSAqZnNsX2VkbWEpICB7DQo+ID4gICAgICAgc3RydWN0IGZzbF9lZG1hX2NoYW4gKmZzbF9j
aGFuOw0KPiA+IC0gICAgIHN0cnVjdCBkZXZpY2VfbGluayAqbGluazsNCj4gPiAgICAgICBzdHJ1
Y3QgZGV2aWNlICpwZF9jaGFuOw0KPiA+ICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiAg
ICAgICBpbnQgaTsNCj4gPiBAQCAtNDM5LDI0ICs0MzgsMzkgQEAgc3RhdGljIGludCBmc2xfZWRt
YTNfYXR0YWNoX3BkKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsIHN0cnVjdCBmc2xf
ZWRtYV9lbmcNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4g
ICAgICAgICAgICAgICB9DQo+ID4NCj4gPiAtICAgICAgICAgICAgIGxpbmsgPSBkZXZpY2VfbGlu
a19hZGQoZGV2LCBwZF9jaGFuLCBETF9GTEFHX1NUQVRFTEVTUyB8DQo+ID4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERMX0ZMQUdfUE1fUlVOVElNRSB8DQo+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERMX0ZMQUdfUlBNX0FD
VElWRSk7DQo+ID4gLSAgICAgICAgICAgICBpZiAoIWxpbmspIHsNCj4gPiAtICAgICAgICAgICAg
ICAgICAgICAgZGV2X2VycihkZXYsICJGYWlsZWQgdG8gYWRkIGRldmljZV9saW5rIHRvICVkXG4i
LCBpKTsNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4gLSAg
ICAgICAgICAgICB9DQo+ID4gLQ0KPiA+ICAgICAgICAgICAgICAgZnNsX2NoYW4tPnBkX2RldiA9
IHBkX2NoYW47DQo+ID4gLQ0KPiA+IC0gICAgICAgICAgICAgcG1fcnVudGltZV91c2VfYXV0b3N1
c3BlbmQoZnNsX2NoYW4tPnBkX2Rldik7DQo+ID4gLSAgICAgICAgICAgICBwbV9ydW50aW1lX3Nl
dF9hdXRvc3VzcGVuZF9kZWxheShmc2xfY2hhbi0+cGRfZGV2LA0KPiAyMDApOw0KPiA+IC0gICAg
ICAgICAgICAgcG1fcnVudGltZV9zZXRfYWN0aXZlKGZzbF9jaGFuLT5wZF9kZXYpOw0KPiA+ICAg
ICAgIH0NCj4gPg0KPiA+ICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiArLyogUGVy
IGNoYW5uZWwgZG1hIHBvd2VyIGRvbWFpbiAqLw0KPiA+ICtzdGF0aWMgaW50IGZzbF9lZG1hX2No
YW5fcnVudGltZV9zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikgew0KPiA+ICsgICAgIHN0cnVj
dCBmc2xfZWRtYV9jaGFuICpmc2xfY2hhbiA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ICsg
ICAgIGludCByZXQgPSAwOw0KPiA+ICsNCj4gPiArICAgICBjbGtfZGlzYWJsZV91bnByZXBhcmUo
ZnNsX2NoYW4tPmNsayk7DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiByZXQ7DQo+IA0KPiBVbnVz
ZWQgcmV0ISBkcm9wIGl0DQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMhDQpXaWxsIGRyb3AgaXQh
DQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGZzbF9lZG1hX2NoYW5fcnVudGlt
ZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KSB7DQo+ID4gKyAgICAgc3RydWN0IGZzbF9lZG1h
X2NoYW4gKmZzbF9jaGFuID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4gKyAgICAgaW50IHJl
dDsNCj4gPiArDQo+ID4gKyAgICAgcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKGZzbF9jaGFuLT5j
bGspOw0KPiA+ICsNCj4gPiArICAgICByZXR1cm4gcmV0Ow0KPiANCj4gaG93IGFib3V0IHJldHVy
biBjbGtfcHJlcGFyZV9lbmFibGUoKQ0KWWVhaCEgSXQncyBiZXR0ZXIhIFdpbGwgY2hhbmdlIGl0
Lg0KVGhhbmsgeW91IHZlcnkgbXVjaCENCk1lcnJ5IENocmlzdG1hcyENCkJSDQpKb3kgWm91DQo+
IA0KPiAtLQ0KPiB+Vmlub2QNCg==

