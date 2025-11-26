Return-Path: <dmaengine+bounces-7349-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 281C5C888E0
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2473ACC6A
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F5D31771B;
	Wed, 26 Nov 2025 08:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="U3bYBoY5"
X-Original-To: dmaengine@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010065.outbound.protection.outlook.com [52.101.46.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6913168F7;
	Wed, 26 Nov 2025 08:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144403; cv=fail; b=foBcwGi84yCkDQVfmhB6FYOPMwDVC4qso2rnjN3SGI+YKY7Vzf/AvOgxjBaUmywyXY/VGUqmuWU5Q1dNYhrFuV7pme57WlObyxIO8C2YXl8nslnPl9kDNHmBzWOj3FZ5/AP2IdgCT88paReNnHM042l9iMin731FedUB2usdBa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144403; c=relaxed/simple;
	bh=p8Aj1zNTjWQi+gdnyuHZktBuuEtex6KdSY/3FZWSrhg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YCVdoGyRqU9Xy+pny85idT46X9LzSk97o4/sIqNy6vbI2/l4iPgF3jlZS7Oe2IEmzFYrAzG7fr1WGHryofCuLreMdceMhSGYHvoqwoItbTWN0VPzMG8pi7fL/r2gczqe0i093eLkJs4Aqx1DdGDEDdBSBtG+2wjqyzLQr5TFR4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=U3bYBoY5; arc=fail smtp.client-ip=52.101.46.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/tWAi7wsw+EG+xMYTJE6DVgFbaYRl2LPNtdy9wBXyiTunjb926C4tNn4E+JLQ7wgWeSZOxSMRf/EENbC4jPOUJpZe5xv5jp7yn5OwdPijZm3VTGDysQjvt1iFQW55RnkP+g1GZQBBE2axba7j6p/qTbz+SEutOQ3/7LZJ98/JDzBVrX/zRaJ9YcupUALRsoM0W6gkZ4VOt6xBZOHbQ8qDKQWc3Nzt8h+N7FTl9o34/urp8X+lH86f7WP9rrZ8i8tVHGOhp89l9pjWcTSdBLUMlW7Uv1QYdCPs1kiGUOtqf7RScpW+50rRaRtcqC9mnakkZzbGQFRFD20o5gqqBp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VMyCaqpn2MpaQ9eIZRS0DFyyYlPsGPct2M3233v9jU=;
 b=LHehSxPQ7++tmGL/jx+ywKJ45sbD7C+KX4lVkC5KRm8goWLo/tayLcPoeAaemumKJlPl+TVWPPhhEZhVAbnzKByaHVDW26RjtPSCLrKV18/BYdVZRruKzn8Wfk5NiVrcJ4rK1MItoPEvNA1dcc6f6tyZqv5XMNYBpD1s1cjDp3GSCTpWGuVG5OFTIxSjnDPqLW6r9/tJoBhcplrpoBTWbZ6TBZbWUp5n07PlgdLWZnemtURzb9pp1UZyzJJWCB2RulrANgd8YDHZ5uCIeXN/M2qsljmbMk9TbmpwFraLVGVr4sMs/kiZt6rWd9KpgxED5AcUL2kk0FDdb9aqvwCpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VMyCaqpn2MpaQ9eIZRS0DFyyYlPsGPct2M3233v9jU=;
 b=U3bYBoY5oVafLLOfZDeShFP6D78woG3xzrpTVkDOtB9vFZX8nlc/+48GgaAKe8ZD5P6aMeryRO1m4YG9RlPm0l3trICYCdxyKCqOA0cljuf+4Do0HEP5CwKVvR1uISJzA8DlTkQIE4R39unq6K+UIXcERZ7a2rZOe3N94lys3aOrCDRsw+7qa+cxPzlTxwlGAc/WYRDuPc6zSF0S6n+x6+rHcsKSZGAZFP0hxz3YekjcbwIGg9ntrRfs34er7DWayegW+bkkVlENXcpf07ljzjPlHcly9lEOPYQkgQFnrfX7A7PJFzP6NcJkmunPRSveub4l8okxPwGhEa+ZiFpgDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 08:06:39 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:06:39 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 1/3] dt-bindings: mtd: cdns,hp-nfc: Add dma-coherent property
Date: Wed, 26 Nov 2025 16:06:22 +0800
Message-ID: <af528a83b4749fb3e6062bbc75bcb4fd5a6fec23.1764143105.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764143105.git.khairul.anuar.romli@altera.com>
References: <cover.1764143105.git.khairul.anuar.romli@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ0PR03MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3d3a02-6928-4539-64e0-08de2cc2ba10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THlBNmw3ZGRLdjZ5azV6WDBQV3RhaUxTRStVUVpTNCsrTk9uNkh2bkF1ZVlQ?=
 =?utf-8?B?VUZVZHpwUWFTaU92MytxaFZtaEh6VE5NM2R5K1I5NUZoTGhJVVYyc1JrVlIy?=
 =?utf-8?B?ck5YbkV4VTRRTUZCcEFzWjRmdTVuLzc5WGt6dm1ENktlanJPS1pLVm9mdyto?=
 =?utf-8?B?aVJOSTFFRmVmcVBRKzhUWGczQXZtR2txcCtPVDRoL2IxWmMzMTA5bUoyWGI3?=
 =?utf-8?B?YmVaUUw0dThwczIrWVRIL0xWMzBmL0xLVEFFR0p1dFlNWnpKR2NKQWlWSVY4?=
 =?utf-8?B?WTV1MnArQ3lhckg1a1FodjF4a1R0UER6Y204UkJtNFdyOUtjLzR3QmhVdU10?=
 =?utf-8?B?VWM0TG1JVHduSnJEaEhPZTJxWWdjWll1d3AzTmpUZmtUekpwRjBHNTBWRDNW?=
 =?utf-8?B?SUI5bVFJdTQ5ZWhNSUV3RTBuY3d0aGlzVTRVdnRCMWJ1SmUxTGlqaGUvZkl1?=
 =?utf-8?B?OENIeWx0aXJRU2pPSDFOaWoxaWhxd1FpajFieVNWaytPM0wzSlZnbTRBRExu?=
 =?utf-8?B?aElOem9tbVJINFZPN1QwY0M0WWFzNFg2TzVlWXVoU1BhcU9ubGJMUDMvWE1D?=
 =?utf-8?B?QTRVRzVkdVB6NEtwME8wYjBvYVZiMkFld0gycmcvT2I1NndvSUlxOW9JeWNO?=
 =?utf-8?B?MzRDUmtWMnFWNjR1KzJ4cEU5WWpCNWZvTFIvc1NqZFcxUFRpUHNOOTJpQXQz?=
 =?utf-8?B?bXo5VTNmdEtCOHpBOEFKbmtWSE84YWZvSmhEWmNhOElydThtczlhUmtGamx2?=
 =?utf-8?B?cGk5bTI4NXQvSGRsZnVSZWtjdXgwR3p6enlYWUsra0dSQytJOStUSnMvZFpK?=
 =?utf-8?B?NEw2K0lUcUtnMlpGaW5md25HL2haZm1mQ0ZkakNRSVAvQmk1OTFUZEpqbVlC?=
 =?utf-8?B?RzMzdzdDYUJxbngvMW9CdndVVG1qd3Z0R0tFaVQ1Qk1TWCtGRE1kVkFMcDhZ?=
 =?utf-8?B?QVJRQmltQjhvZWFFTXROR1FlTHpsTmttY21UNlhHQ1JyZ3dqS3owSG5JenN1?=
 =?utf-8?B?bkhyYU5iTFcrWFlMRngzL2lXKzBHUUNGaHBaa212dUowUGE3bjJPK3RTS3FO?=
 =?utf-8?B?c25TTVZXQUF0NysyaEphL2xvNWZxaTh4ODVLQVBpVm1ENkE3RUY2aDU3ajlO?=
 =?utf-8?B?dDIrWWhYcUwyUzhkQ2FtL0VLcXFIUE1Qc2d1R0pmVDJwTUhtUFlBTFlCcTd4?=
 =?utf-8?B?aWRMWEhxTk9JeXgyc2RhdnZ6RWZjcitieFNPTE0rTTFoTk1oTFQvSldFbVZ5?=
 =?utf-8?B?TFBsUUZZekt5QjZwM3NiblJnSHRTYnVIRTRXQ0dYTnVMc0wwdjhobHhEZ3J5?=
 =?utf-8?B?cnc1bmFhN0NrU0RFQnRlTmhJQ2t5d2JGNVJvQjR6N09GUXhRMHZaV2t0TVcy?=
 =?utf-8?B?dGQ1L1lTVy9YVW5BeVVOUTZQbUpUUWozOE1ZeWdxWGY4cllIakcrR3YyZ3ZI?=
 =?utf-8?B?SVA4YzZhdklUWDA3bW4vMWVnanZRaTdvSjJReFBuZjFQUjhzUndmWUZRTXRS?=
 =?utf-8?B?ZTJMNG9EVHY0ZDVGY1N2S2ZCUDdqTElWU29HbUdPSEJrVTkzcFhndklIS1Nx?=
 =?utf-8?B?U0ljVE8vbmpETDlxZUYxMnFHRUs1QXMvWC9vaEtxNm4wc0dYdHVjc3lOdm9B?=
 =?utf-8?B?UGtmRGR5T0oxQmFlYkYxT3hQK2ZTeHFqOS9rM0JSb09QdS9XY3YwTHhjb043?=
 =?utf-8?B?TWc3a0VMbzErMkU1bXFZWFlZT1VBNVR4Q21jRUdKYmNSSnpyb3JYRllHVnZN?=
 =?utf-8?B?Z2kwR00zUy9ZUUZnVXZtZ2pKMFo4L2dJN0loRFRJV1JKZTl5cjlZOVhHNDln?=
 =?utf-8?B?bFduV3YyeW9lVDFCL3JUVUlMZ0xCMU9tMFh3WDdNRzNqSEpuVjNjM1JzaWhq?=
 =?utf-8?B?eWFDd0hWL2psa2p4T3JWSmcvRytBNlI5bEdFMEcvM0gyUGp2SUtxWE5lLzlO?=
 =?utf-8?B?Zmd2WS9KZWRsWE1qaEZVZ0FlblBFcVdROGJsQnJreW9ZSGxlK1hhNCtKS2dv?=
 =?utf-8?Q?SkKK8sAtFNjU1Hu+xcNHB1a16JMYMo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnU2ZUVnWUsrMnFBYm5EVG9DQ2xLMFRWUVV2T1I3Q2hDakdpQldxMnZENkQx?=
 =?utf-8?B?c1BMeExyZ3I4SDBWcE05MmgweExkU254elhaaVJCUjRuaXU1SExtRjYwaWtQ?=
 =?utf-8?B?Q01NRnB4MWl3OG5YekZBTVBKSDVhTjZPRnppRmc5czNQd1JqOURBbFFpZ25O?=
 =?utf-8?B?dWk0TlRmSGtkSjhRRmNxZDBFVWk3dkhHeUxrNUtPSFBCM1FvYjJvc1ZUUmd1?=
 =?utf-8?B?UXI0M00zSnBtTWkvREVXU21uUjEzd3RSbXZyS000Zzc0amxEWDRodHU1NS9J?=
 =?utf-8?B?cGRxUWszL0tRSUJXRktubldaL0wzZXRyZnlkK1JXYVl3NEJLZTFITWE3blRo?=
 =?utf-8?B?QXJGV0VRUkh1T2d4TjFZczZmd0lOVURzckJ4U0ZPQW1QZDcrRHQxdEhLelI5?=
 =?utf-8?B?NWptUEVPdFAyMHF3dmI0WGdQZmsxNFpwdFNCQ3IrSWFpakQyaXZUOEtHMVkx?=
 =?utf-8?B?YXdzREZ2ZEI1eXFUWDR4a2RLdFdCZm1zU2hXZXFBZUZYdHpuRmV3SjdPMFJm?=
 =?utf-8?B?dUpKQjd4RVhuei9QOTdBU29nMG44S2xhSndCeDlkdE9qckhnaDloZ3FpVzZS?=
 =?utf-8?B?dDNCVURLRjJMSk1XdkxrcHRNWjhOT3pYVktqcFZWb3luU2haL3RLM3c2ZWRY?=
 =?utf-8?B?aStvVzd2VnpDNlpOOWdpdVFoQ0JxYXk3VC9QRStkYWJkck1oYWlsa3lqa0Jp?=
 =?utf-8?B?VFlCamltQzRESzhmZ0RrM3dwellwWmJoN0RHdmVxOXByZThpOGhTRTNZZFg1?=
 =?utf-8?B?VnN2ejJ5STEzbUg2d05oYzNhTXZYbmdDZlRXTW5vTVh3VFVoUy9QK3dyMFBL?=
 =?utf-8?B?NnFzbzFsa3FKQVROcWZJN1RtSTExTXl5OWhHcmZZZGRlSUtNQ3NTYjU4UGRD?=
 =?utf-8?B?emY0U1FCMWZXZ3BVN25RRy9id293VCtWTlJ0NEhWWWRxK2dHdEhDRCtVRG45?=
 =?utf-8?B?dG5ySktjaEtwUnVXS25xTFR0Qlh3SzJqZnVUNzByNkpCZkJCYVZQSlh1TGY5?=
 =?utf-8?B?ZWc3YWN4U0R4NGJ3aHc0WU15cFVqRlJnV2hOczRtZkpNR0VGeDd3dTlqanJJ?=
 =?utf-8?B?UjRvOHgvUHpYeHgvVG1UVm5hQ3RMaTE5N1hCcC91a2swNXhKRnFrdkJWZm43?=
 =?utf-8?B?TFI0UmdXVVo4WlNjT21INTVIWE1jTFpkWGVCVERWVkl6YStmdmFMRk5XbWpU?=
 =?utf-8?B?T3FFUC95ZzFwUENYNnFVR1hCMy83U3B6YmgyMnJhN0ZMSWhMNWd5T3M3SzM3?=
 =?utf-8?B?dkY2N1FHRFQ4NFFmL0hRSXBDTDdRV0hwNGR3aTIyeWRMSFpBclE4cWRLL0Fw?=
 =?utf-8?B?UldXa3dENTRYSEJlYk9DUStOL2ZTd2kvKzgvU0xsYko5dUFBcldmU0FPTElB?=
 =?utf-8?B?eCtEbjdUc1hOQTdJbTBDWVNldmlqbnFDbXVyQ29tZC9vc2tncUdFWElhNVhl?=
 =?utf-8?B?clRCSG5SWTRobzkzUkhuNUZNTjJqNmZsamtsb0N4MWIvdVVPbTBFbTVzSmR5?=
 =?utf-8?B?YTR5aGtpN0NpU09RbzcrN0tUR0g3bWxUN0JobzgrU21pelN6QWxadncvSjRP?=
 =?utf-8?B?NXhhZVkrOE9NdFRhdHBGZ2QyeW44Nyt1bWpCS3A0Mm1pMVpIN0xsQkduTUtU?=
 =?utf-8?B?L1pPMUgrczVOYytpdHFJUDBsbm0wdDI4VUliSTlpRUovaTRtLzRrMUwxaU0v?=
 =?utf-8?B?SEZwNENabVZXT2xzNzNSVGZJa0NvNGxaQVlTNG5QQjJqVno4em9oRjYwM3pS?=
 =?utf-8?B?TXNpVHluMGtUNGRucnJ5Z3VpQjdUM1Z6czVjeGE1R1Zra25tTkcrTU5zN1Z4?=
 =?utf-8?B?dkNURWJFR0RjOEhEdjRSeEF2YkxyNmtocU1SM2JaWitHR1M3MEtnL0x3L2s5?=
 =?utf-8?B?RjN6MkhKZmxxOHFyTHVrYU5oVjNLbzBZMittcDhNTGhwRW0wa2lPeXhXT1dM?=
 =?utf-8?B?Rk0vYUQ3b0pocXQrVE5rVnRVbUx5d25tekhBcTMyOSt0OGRPMUswc2FkNXhn?=
 =?utf-8?B?SjBodklMSTZQS2lqdVZocEYwYTVCM0dLN25BNnp6OHB1cVI5Z2t5aG53QTN2?=
 =?utf-8?B?ZzdYNTBzdzFoSGVqY3BwQjBUa1BPRHoySVY3TW5iV3RLUzEyWFVUOGN6bEwy?=
 =?utf-8?B?Vmd5eldpcm9wRGl5OE1PbTVyMG0wYmxWdEN4UHdGekhqYWpWd0RIVzFSWnNE?=
 =?utf-8?B?Y0E9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3d3a02-6928-4539-64e0-08de2cc2ba10
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:06:39.2614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zF+zMxn71V5bVlc4zYHNcJLmEvd03CZiMWlabkStruQM5dbq1C8oLABO8pe/y3fRb3r5vbVe1D0+q1U2/Z2v/mjVIhLGrByftxhScj7yZ1U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6581

The Cadence HP NAND Flash Controller on Agilex5 device performs DMA
transactions through a coherent interconnect. dma-coherent property
presents in device tree will allow the kernel’s DMA subsystem
controller’s to performs DMA transaction in dma coherent mode.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index 73dc69cee4d8..367257a227b1 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,8 @@ properties:
   dmas:
     maxItems: 1
 
+  dma-coherent: true
+
   iommus:
     maxItems: 1
 
-- 
2.43.7


