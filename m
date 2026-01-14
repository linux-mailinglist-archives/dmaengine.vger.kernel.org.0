Return-Path: <dmaengine+bounces-8267-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2E6D219AE
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 23:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD662301DEA3
	for <lists+dmaengine@lfdr.de>; Wed, 14 Jan 2026 22:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF103AEF47;
	Wed, 14 Jan 2026 22:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LVRwtga6"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011030.outbound.protection.outlook.com [40.107.130.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977513B530F;
	Wed, 14 Jan 2026 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430107; cv=fail; b=XxLbqqJoqRQDiulpzwRnv8XkJVCEyR1atgvOVMeRCQg7fsSJPceLh4qgpMX5wQcYG2XCrsSrp6e8oAlb0ZzO8VDAEVDbQHlUWXKTDaheYfsKNFZx80X+bzjXjwWh0dga5fIPk/OHWY6uJgqjuZaUyanf+e0M2hBe8Bw3gIlgs6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430107; c=relaxed/simple;
	bh=r+IbCiI25ZoU6GRJDU7U1RA50qUD/Z8BZWI6/kAZFcA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WXZjqsEoqOW6ZS0vaZZrdJYO0enNWiQvufmyLQOeq3sWDZ7MftfXcK8PwXq8JyVVGArz9eZw4/m40dhMtC81xY4tV+Of2VY51uxsNjhmE7sOPlVxxKCtvujTI/X4CYFp7SDf/K5ZF/6LbyK1PVRZ30RtPrZTLqhJpIf8Xks2eOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LVRwtga6; arc=fail smtp.client-ip=40.107.130.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3p+pfPLJ+axE0LRYS6WyKfXv5Dx6khGNTitcDxIQnD1a1NYI2Q3h4pqdua4rgM+4GoE+0OOAH/KSOTZoeRkYYWsDeWejgPzbI1XbTfr7FFj5HOv9xqA+iUOEylaGWMHRqIgYbZ1yzkLTjonE585zlOcxCDtLklCegrK7nGIC/wy+kiuChgLa7bdWiwmBRpktxwksBsowg6sVFwwMFBrUZc8eJ4K822yWrN9lny8gZuPhUPj7HFVB4N3Wl3boLAMEf3ul1TBFhzYqTSYv2pifL3wVXb5Mfc/rpvW80JZ3Sf1mEe2E6C09HE2h/3pwGZ3OE826R3DfTXV1Kqu/W6Nyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gaBMwLFkSlCHfw3N6fsoNN2r/JfR+CHTYdcr6cQb2j0=;
 b=GBnsMsFoqiobl+9XxJs1HNwp4ZeIS3b7w6QjVKq4vdMZDIE2CbOXpfeY0HRqlVucJdmEWe1uhGeX8WZz7JO9VRSUV9JFcnoYd55/poc3KjrGqDKu6G1Pd08Kh2W0Hf214TuXcEvdSFjGuguj0bbhUcShvHCjrJ+PwehO7MRDe4THE/mHWHVmlJ/g1+cIGXnznAXw8xNKpg36H9PGds0shH60ltCh3PiAsEeeeMEHve7iIBGNwhznY1vVC9D2rgOa8zrFHq6k5isFhssGJTJGwb3TVEaRFWlxg3Jzbqjdd1hvlSaN+d6UxquTkUfjegnMXL/Er57aQOIVcxFQIeKuNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gaBMwLFkSlCHfw3N6fsoNN2r/JfR+CHTYdcr6cQb2j0=;
 b=LVRwtga6Z858fwgMcYJMIrZBPJQgcSoBJbORsNLElunNdwK83cP2o6mdP0G+e8LzbpjUcH1pvxIjBIUle+cZPyT1q713vDmNxJ7llRQI/c+WljqA9eFSYq2z0vrUovnE8oZ9RXrHWQFxi1EymDxlXnb4PhczvC/5XK1k32TeIrCYCCAGNnfwWgwNhRf7kA81NDDshfvvXTSXyOAISteqWVHmeEBSY2hXo8hPUuQfbJMS+P9JhgauN4temkOQDTvWrWE3ZxvO9tG7JVyv4mpyNfHLuH2wXtvExRm7ndlSPZTa7zpsWrR1hlGYUALG+q2bUJGM2pPRZ4+pUceRH7aZkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB9PR04MB9554.eurprd04.prod.outlook.com (2603:10a6:10:302::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 22:34:26 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9478.004; Wed, 14 Jan 2026
 22:34:26 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 14 Jan 2026 17:33:24 -0500
Subject: [PATCH 12/13] dmaengine: imx-sdma: Use dev_err_probe() to simplify
 code
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-mxsdma-module-v1-12-9b2a9eaa4226@nxp.com>
References: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
In-Reply-To: <20260114-mxsdma-module-v1-0-9b2a9eaa4226@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@freescale.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768430015; l=1223;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=r+IbCiI25ZoU6GRJDU7U1RA50qUD/Z8BZWI6/kAZFcA=;
 b=HpgNlhVSuXBT8rGvOtNEXrEyINx2ZBRahoCp6cM6GQ78JDrPGJ5A2q9SmzTqdnhmDRpFH2egZ
 sqj6J5elvySBVfA5RVYeZN0T6mcdk3CKq3Nn8gywoKc+vWD7h+ioeK8
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::19) To AS8PR04MB8948.eurprd04.prod.outlook.com
 (2603:10a6:20b:42f::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB9PR04MB9554:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a4f77f-524c-4ad6-1be5-08de53bd12af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHM5dlNpOUhuNW8wQ2twVnBkb2MrUUR6OHBVeGNabmY3bnFIR093anFDKyth?=
 =?utf-8?B?YzZmQzNEbmJ3N09QOXdhZEdwODRUcnBsakhLQ2VTSnEzUVlYVkRocllIMlZN?=
 =?utf-8?B?SkhPQVBVL2JrbDFUL1BMTGNpYWhDQzU4TzROMmt4ai9FMzRsQTI3bXFycjdH?=
 =?utf-8?B?Tk8xTXMwKzM3L1dNUFV0dTRNSjZDZGZXR21tVUdXU3hzRHRvZU16YkxVamwz?=
 =?utf-8?B?N1owK2V6T0x1NGhwcmpZT1JLc0lTdzErTEVsaHdIcXlJQWJrOXJQdkpRZlJK?=
 =?utf-8?B?WWlpeHRiMVE0TGpkV1RVRVdrbTNHZDJ3R2hsL0ZsSzVTQi9NVXV3RzRDRG5h?=
 =?utf-8?B?VDZBRERkYi9qazdSMFg3YlcwbGV3SmdKSzVoY1NoU1dwYXByRmdKMGtLODR4?=
 =?utf-8?B?cUZZWHN1RVNDanhTK242eWJyek9ndzRLNHJHSURncFZwREhrN2pjOEhSbmZn?=
 =?utf-8?B?VThKaDN2NlVCL2k5TUF2Smd1V21ySlBNcXBBcVQ1UnZhTEFwOWNvMXFHeFVa?=
 =?utf-8?B?VjZRU2kxR0YwRUNtTHJPT3hZVUo5OXdiVGZrYkZSNWllNVluc1owam9rMkxR?=
 =?utf-8?B?dENCM1ZzNmYzQ2ZBcFJYSHBMOEVUSVB5RWI5V3c3VFAwNmhUbTV0NE9tdGpq?=
 =?utf-8?B?WkdneUVrU05BcG8yNldvSkJjZWpQMW85cDZnb3d6Tk5zMlM1UDJHQ3VJZVpv?=
 =?utf-8?B?K1p0MnAzZXZ2WU1IY25OWTd5c3ZTT3E0dnkwdjlBUksybzVOeGJrQ2FYZEx5?=
 =?utf-8?B?TldSblZQbzZyZWlNOGptTDhMTit4UmpGdGt3UmJ0OCtJb3ZacERyZFpGN0I3?=
 =?utf-8?B?R0R6TTBEMEtWQW1lN0lSUS9WSDU5YzZMRlJnT08xeHVMN2JMUmlVSDBUSjJv?=
 =?utf-8?B?U055enZ6bXVLaW00L3ZGVEw3OE9IbXNjeDVhYkN3VXJ4U2tkb2lCYmEwMUlj?=
 =?utf-8?B?eC9kRTRkSFJabElGQzQ3bzBkNkd5YTFXbWVMdUljNlZQelN1azdxMUErWVFI?=
 =?utf-8?B?U1JvQnJhZ045bTliN1hrWU00WlJHNTlqQmxvRnFEMHhDZkNaeFlOK1BmRGRa?=
 =?utf-8?B?ODloYXV1QVl3aDdqTXJ5VDNpb0laTGlZMFJzbnVGdGNvcnFKR3d5cG1hN2g4?=
 =?utf-8?B?aEluZzVORFcyKzNHM21CZ2xoMDNKa2JhTGw2SmFzdWdMaHoraE5tdThZeU0z?=
 =?utf-8?B?YUJLcXFpWWZ4aTZ3dHdaWGlPbzdhNkFPZ0xXL0ZocnpENTA2VzYzbloyaVQv?=
 =?utf-8?B?NWR4bEhlMXhFODNGaWR1QTUzWEM4ZkRlWndOOC9XN0FuU1ZybVlXQUY3cVhu?=
 =?utf-8?B?MnRxZDl5eVFmY0Rtb1lrS0Y0VFFVWmxob2JTWWRqZG85L3N4V2RtSG9ndlk3?=
 =?utf-8?B?MWZsMU9yZTZQWDN0cVpIa0R3NXZwNDZDOWd3VjBsdWFHK0dwZlU1aGxXQWR2?=
 =?utf-8?B?cHpLeDYxZjZTY3FiNlVvV0E4YU9ySGpKdlBMdXd0NXVJOG13ckU3cE93UzNj?=
 =?utf-8?B?UlRDQ0JWb3JQMTRGNll0ZXd1QWtQNjA3MVE5UEg5V0hNTlcxZnowWUxtUFVr?=
 =?utf-8?B?T1IzTlkvVnBNbFRSaUp0Q1ROdWRId3BoVERuUXFyRXpvYks5K0RJekZCTGRn?=
 =?utf-8?B?bllmTmp2ZjhKc3pDWnR5bEN1Rmk3dWUrOVhGdWQ3SmxnNzRqbTZpNm1oa2Fm?=
 =?utf-8?B?THY3VWtHT2dSSC9LcU9ldGxxNGxHaVcwcFFYc1NFdnd4aElSZjU1c3VDUXBL?=
 =?utf-8?B?bUVCL2locXFBZHQ4THlPa3c2Tjc1MGN2bG9oZzBSTERHbDgwV3RCaExhOFlp?=
 =?utf-8?B?YjNoY3Yvcmx6WHZDR1lWL0RLWmFCaElvWmpnWUVEbUVWN0Vsbk52WEhITUEv?=
 =?utf-8?B?a2wwZnJKNllqWjh1VFoyanZaVmRLOGU1RWlRTUkxV3pHWUFpNG1IT1RyM3N4?=
 =?utf-8?B?QjcxMW1udVBibHEwMzBEU1ZWOEhxNHRUNGVIUW9wSXBnMXF0NWI1WGttNmYv?=
 =?utf-8?B?U3hlVDRRWjRvTytVdDMwWmI5MWF1U0E1Z0ljQlFtT3RCNzRRcFpxcmMxSTJv?=
 =?utf-8?B?V3hGMi9Ydk1Wb1hQTTVKOWI4Z0RiWURPckJOZU9ocWFCcWlnU1VZdCtuYjM2?=
 =?utf-8?B?ZzBxZFlIMUJsN09IaDVPWnc4YlpYei9qZ1NYT1NiRWVLNXRqWXhIcGdpcHZo?=
 =?utf-8?Q?3UFXVw6fLYfrLGNvQeYtrSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1NpbEdqMWhGTW52VTJ0aHdoRDI3UFhhRjNXNGJwWXprczRuZnNUZnBzY3pv?=
 =?utf-8?B?eFBhdGUrQnRnSmprdVNCZHpGaXlTZWdBT3R5VjB6YlIvNEwrRE5qRWFmbHVs?=
 =?utf-8?B?bjFLYURkUnJ0TjF6eHF1b0lNVzJ1UldhRDAyejBmcTBOellVTUthTWtDdUFm?=
 =?utf-8?B?Q2d1eXp2VVF1N0kwS0VaL3dGU0IzcDFwWnZLYi9nMklreTJGL3VpYXlZU3ZL?=
 =?utf-8?B?T1orNXZaeVVSQ1l3QmJyYThpK09mUXJVV0FBb0VwSlFSblVzU044ZFBBY1Zy?=
 =?utf-8?B?UzdCQmpsZ0JFakcwQXJkQ1p0VkI5YzFwRGJ5bzA2TGZGSE1ITmZDaFpsK0pT?=
 =?utf-8?B?ZFdGOS9mWFJNM21IUlJGbk9FRjQrUjY2emhhM2RQNlZubVROQWd1cXVNaVBX?=
 =?utf-8?B?eDVZRWNMNU1YajA4ZFRzSDdnck14ZlJhRWpvTlFGMlFlZ1lnV1ZZTEk1d3Nk?=
 =?utf-8?B?NXBPVW5nRFZzdDk5aG1ybDhiU1VsWVFvb1FtTS92T0krYmZNSWs3bDhyaXl1?=
 =?utf-8?B?ajF6azJ6ajVWUzBzM2YxNXF0bzRHN05wUnhiYWtJdG5RVkNGSG1MekVvYnJY?=
 =?utf-8?B?Ny9qMWpoY0xUVTlSQWdzMjBEUTBqdmRwY0pqNGlWcmZWUXZoVG82b1pzRnAv?=
 =?utf-8?B?TzdmT3E2SDd4NG0rcTkxYzFiY3dIMmMrM1Z0WWRneDJXaDd5WFV2L0xhZmV0?=
 =?utf-8?B?dFNIcFNGNTRtSGx1cHdOTXpFNEpyMmdwbXZnUTc2czJzZzJobCt5Q2hXejBG?=
 =?utf-8?B?bC9Ma2pkU1ZLeC9zcE11aVJ2TW5vZ3JrNE9wdWR0MTQyWFZkTC9lSENPbW1P?=
 =?utf-8?B?VXJWR2pKQ1FTMnNoblBuTWQ1ejU1Rld5L3FQRnZzbzI1cnVPVTVDNG9mTXRY?=
 =?utf-8?B?ako0RVBaaVdhNlZ3Y3Jaa1NFVTgrRUc3Wk51WFRFRDZ4YnJNZ21Cd1BYMjdI?=
 =?utf-8?B?YkJnT3JVWm1pdlBDWGQ0Sjc5WXFiVHB0TTA1U0xocjBpaWltaXovTVlCeFJF?=
 =?utf-8?B?Z3k5U3M1Q1p0bGNIdTliMmE2WmFpdHV2MTlvRzhxWEhEWDYybm1mUXNyMmRi?=
 =?utf-8?B?UUlrTkk2d1VHZDkrTExvQ0ZabWpWT3J3M05nMHZBMzVrV1FwNXpaTEJ0Nk14?=
 =?utf-8?B?eEdhT1NrQVRTMUtYQThyeW5JQ2tWMU44NG1CanJtbGc0NkttOUVndFFIaGU5?=
 =?utf-8?B?SkVwWkkwaFhpYkhRWCtvQVY5ait5Tm5HQ29iTWZjNFkyZ2F1NXR4VW81ZFBk?=
 =?utf-8?B?cFlaTit6Qzd2bmZPU3dlM3lUcjU3VHcwa1FCbXM3RDZJM0VpRWt4bjg0M2F3?=
 =?utf-8?B?Y0ZwUHFqa0tzc1NyOVA0QmQ0WGpTOVU5eE1uQTd6K2h6MlhDNkU2bFFhU3FL?=
 =?utf-8?B?VnU0RjREZmF2eEhHK1BBZTg2ZUFsUlJyUmNNUk1oNUNvMXFyMDVMd1BrTENj?=
 =?utf-8?B?dHhVZEpIRFN2dG1GSDd0d1g1SDN1WTFpQldGckFJZUF1S1JsZlhuS1Frdmxw?=
 =?utf-8?B?OERDMmI1ZlBXRWpVcTRUVDJycExmWTVpYW5rMURuMGdPSjFzWHZ0cytBL2NQ?=
 =?utf-8?B?NmUrWXp0aHJNMk0wdUpjdWgwMVJxQUdUckxVSUZDT01ETkpOMVk1SXRDbjZ2?=
 =?utf-8?B?Q2Y5NXMzdmJZQS9ReXlYZ0FuakZTQkFuMlpWV000emlnUDJqa0NqaWlIbGkv?=
 =?utf-8?B?VC9CcXRmcytJeTFRd2gxV2NIdjVGWEFycmlZNndjSE1rNFd2d1lpVU8xVTFa?=
 =?utf-8?B?dWpBSUNoemtZVmM4NkRvazR1R1RqblZHRWsyOXZNK3FlT2E3SGdzQnFlVW10?=
 =?utf-8?B?RGFqd08wVHhDY0dYc3NlUFlKZmxHSTQyK3M3RkpFNGJ6Ym5JWDdCZlA4Mit6?=
 =?utf-8?B?L3NoempzdFJtTVZEU2QyaHJ0bUg3MFluaEV4a1JJYXhENUhEWHoxYlgrcyta?=
 =?utf-8?B?K2RLTFE4cU1wR0xDOE5aZGs4cjhMSnM4U3dEUWsvYWo2RWNMa25sdGd5N24y?=
 =?utf-8?B?Q1Y3bncxSDZXaCtIR3VDb3J5RGEwZlBESkdPUTZYL3RhMk1hN0dIeUoxSnBM?=
 =?utf-8?B?NnhkbzNpMXdsVS9nRmF5TUo2TEp1MlRFZ1F3Sk90M3ZsSDZRUFFGUFZQck1E?=
 =?utf-8?B?RlhWS25PSmtoTUkydEw0d0o2clk0d0gxUVM1MlJIMTQyeXc4RHpndVVObGsr?=
 =?utf-8?B?NEVuKzBFWTZpanZ3aFF4M2lLVHlsdVFLdDY2SHZiYW02ekRaMklvL0ZtdUZi?=
 =?utf-8?B?d2VXOHlFNlVXZ0kxTE13MU5pT0VHMzZQek9NeGdKMU9KTTRHTGRwR0JvZkJn?=
 =?utf-8?B?d2tvSkdMUFpxVjExYjFhL3lSY1BmMlgvMHIrbXZGWEFxVy9HQU1Pdz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a4f77f-524c-4ad6-1be5-08de53bd12af
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8948.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 22:34:26.3477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: POenQVJOsFLOqCyTDosvy9oKqj+kaVogpE2WNsw0cXSxdTtJNtLFcwFogxvC8mPme/Iv3BMD8ms1fOxxB8fxVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9554

Use dev_err_probe() to simplify code. No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/imx-sdma.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 95458ea188e3b0fc4e4f861df567c1c7524a3029..543ac44873696a2091e5aab0f47bd1af2af9d1ad 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2356,18 +2356,15 @@ static int sdma_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, sdma);
 
 	ret = dmaenginem_async_device_register(&sdma->dma_device);
-	if (ret) {
-		dev_err(&pdev->dev, "unable to register\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "unable to register\n");
 
 	if (np) {
 		ret = devm_of_dma_controller_register(&pdev->dev, np,
 						      sdma_xlate, sdma);
-		if (ret) {
-			dev_err(&pdev->dev, "failed to register controller\n");
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to register controller\n");
 
 		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
 		ret = of_address_to_resource(spba_bus, 0, &spba_res);

-- 
2.34.1


