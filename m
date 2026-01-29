Return-Path: <dmaengine+bounces-8583-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFrPCdGfe2nOGAIAu9opvQ
	(envelope-from <dmaengine+bounces-8583-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 18:58:41 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95745B3504
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 18:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAB01301494C
	for <lists+dmaengine@lfdr.de>; Thu, 29 Jan 2026 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A073559FB;
	Thu, 29 Jan 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XjGUp1lG"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011057.outbound.protection.outlook.com [52.101.70.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00C61ADFE4;
	Thu, 29 Jan 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769709307; cv=fail; b=bC3Gh+oZ7r/axPym8qSpD0NuI8ZYc9L1sbKIe/sdgCzsoiJFu45rV+LUk5M4aA/OEh5fJK6OmeVr21AMA+3WStl762ENFFKCJ2dc1fyXV+UweOQaPJZtpSLxYhjQtAaKsAbhaAzMQdAC3NtrWiQY9rSdl23sj9AQT4a+kTmsr+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769709307; c=relaxed/simple;
	bh=yvHOSL3RBRU08UhTyLCotLKiIj8Hl6fPALprgHVzJyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fzbquh7XxFRXTERU+FPdO8v68NjIPuIgFJF2d0WJY8Q8f9YCykh3k5g7ZmWtXcUvJdi+8EC/hQqzt4ACdkwOnJbKhjvErbuCIv51uDe+vptss6SIWOb0HuTD5+05tcwGOOwBEOhTLVbfl2sfp9HJ1IfURbQLxhd+cbS40dY4bp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XjGUp1lG; arc=fail smtp.client-ip=52.101.70.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUFLWc4qsCgEFz+SkUnl6DvXFGBICst8oEYxI/26j2hPuHEgTQGTdqi2fpqO/+gJTobdCe+kmTNZDLEs9eZLZVwvtXfbmRjMjwLiTRyUhh8GLyoAUOROmjSBxCoKrlLMgcYArNteQCnNPhtBZX8yTVXUjbHro6dbZNZGdUyTUqKzCcK7eBlllwNXzPOOIjx+x5XKZJtsFYa3OhsLGwsS7rHLE0DFWim3KnSNzukFHN+nz+NkDXt9Wt18A/HwFtwxWkUpJy3yHFLDNefWhw/sbH1Fmjxa1Lf8CG+7M87OUKNfCcZUZASZRj4Heqa0uqblE7YV4qWCCnO2oQHJzBFFeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G942cNwWVMVrESCSeBm/yZuk+L//AdMEFTpkJKbjdsk=;
 b=jQg6kXPwuKZnOROdv+cmx5JhN+YGGsW6mz3gD5GwOYwdGZojveYn9kV+ICT0o4JthT5Qk1JoLBDek9dw4YIjYtFGw+Pqv/09gyuMoWULfynrCykax5Nykt/gF2ZkJ11lT/WYfX+Gs0bkCiKyq1eHdlq261Ju/kEy36a+zvzO2FBUGliFGDJcszEVkUhLX02COxhLIP1DulidI7NlgWA/HO2VZsQxK0DHqFtw5XvOtuPgEsmAyjIDTWXz8M5Bu+YSQtl3Yte/ILE+3uuG5Xtyj5CdSBnMaCfuHYpAX6dqy3XOFfQoFJ3b937WBndUvh7xCrQGBaTYMhDf2WUZYtyIoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G942cNwWVMVrESCSeBm/yZuk+L//AdMEFTpkJKbjdsk=;
 b=XjGUp1lGxei+/43LqWlOhR8DApBzStM54+IKTRI6o8morFEhUB1pdh4Jsa0YH0bpJXAgnBuebj40rK2Yp3MrJs6LlBMHjUJ5bjwXYGZQEEA1C573RuKfxgRRxaDAZjTPE8HGpji74zqUbfdToiJ72bMq+vOGHd8mfxzAuxcFm9e6WTVrSMuuTYYI61ANw4ydADCSzyhwF/QpuLOuTZRgEHp94SawEHYRFIsPLolDgsnnzo5NZ/Fr30nUVP+qPlYMwU8n1zdtv4dD9WN5vq1EM5Nzl1QNMVMj+F7xNLKJbOfXdOj+tCcea6uALkoXDArLUBSAFODo3TG/VjZKjRFM/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GVXPR04MB10777.eurprd04.prod.outlook.com (2603:10a6:150:227::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 17:55:00 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Thu, 29 Jan 2026
 17:55:00 +0000
Date: Thu, 29 Jan 2026 12:54:52 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: Add Amlogic A9 SoC DMA
Message-ID: <aXue7DTy7mgwxeks@lizhi-Precision-Tower-5810>
References: <20260127-amlogic-dma-v2-0-4525d327d74d@amlogic.com>
 <20260127-amlogic-dma-v2-1-4525d327d74d@amlogic.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260127-amlogic-dma-v2-1-4525d327d74d@amlogic.com>
X-ClientProxiedBy: PH8PR07CA0045.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GVXPR04MB10777:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bf7d42-1c0c-435e-155f-08de5f5f8575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|52116014|376014|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VzRaajc1OHRoTmZ3dmJZZXpQRkNGbU5JR1JNQW5HdEtNSUFIRG93WUdBck1G?=
 =?utf-8?B?MEY2WDhhWWFycm9QbVgwemtsTjlQVjgxV3B1ZlE5MzM4QjR1ZW81dEVRdThE?=
 =?utf-8?B?ZUw0N2swNHZaTzlaN0FqSk04RlNuYTk0b3Y3TXlQM3hFVGVMRXpxOUFabW4r?=
 =?utf-8?B?QU9pbXU0QWlqaTI4TkxZS1kzU0F4QUdsOVBILy9tZmhIbWlQTmNGUitPMUx3?=
 =?utf-8?B?VnBCbk01c2dqWHlNVnVmNldzYkwrbENoaTNGMHJ5aVhZZXMybEJZYmZ5YUNx?=
 =?utf-8?B?MDJLblFsOUJVNHQ3eWNqdmxORmU4ZWZmTHlrQ2I2bDV1ejc5bGkwVE9yRGNV?=
 =?utf-8?B?T0R0NkIwT1hKdFZkTHE0UHhjVjJ1elJmVDZxRVlVRWVweFQ2UDFtQnVNb3Jt?=
 =?utf-8?B?cytOeDZlTWpYcHZxRmJQamYxc295V0kyQTVTSU0zYnRuRkxGd3dpSmFjOVZt?=
 =?utf-8?B?Y1dSOVJhMEt2b1Vmd1dsOUhQcVdtOS9XQjBaeHFzbzVqTmhHZS9oejMwVEln?=
 =?utf-8?B?R0MwR09FZEx0Mmwzd0JqVXNobk5uQlYxM1pESng3aVJRTG15dWdobTNZOExM?=
 =?utf-8?B?NHh6dzB0OERCbnRFa1pvMGl6T2VCcWtRRFFLU250QnhybGZDKzVDNHl0Q3dY?=
 =?utf-8?B?U0FUa05EZDI1V2cyZTFCMmszSjhUZmVhUzFoOGtDTEMxT0JxTXdWNWx3Y1lh?=
 =?utf-8?B?RExDR3dGMnk2MFFMMlpFdldkT1R6TUNwZVE0TVFaYkQ0TTl3akVSbWYyd1E1?=
 =?utf-8?B?OUR2cEVFRlJSQ3pWNzJWcE9IRGhVYk1JZ2VDamZkalVFQWRMTzdEa1VBV2dB?=
 =?utf-8?B?ZEUrclJPOFIvMEd4S0FYWG5PV2cxR3NpU05LcTFFMUwvTC9DM0xJTEFPOWhE?=
 =?utf-8?B?bStpdmpEd2RpNWxVVllJREVHM1FFY1lzalY2N0tNZFFGOHVLS1BQbzJNUjFV?=
 =?utf-8?B?bkVjWWJ1dlFYbWtrYXY5T3ZyeXgraTI0ZVQvZEx2UllubXVMci9VaEd3Mkxx?=
 =?utf-8?B?NGtPS0ErNSswcWEvS1lpQ0J0NWpUMy95S3V2VDE1OXY3ZTQ0NExkeFlHNHZv?=
 =?utf-8?B?akJWUDVjRUtleHIzN3V5Wktqa2pleHRGTloyRjlyRjhnQWdic2FockVCUC9M?=
 =?utf-8?B?Y1JzVlhNaFJSajFyZS9GMkI0eWRMcnVKdGtlNzdIN2RCWjBSb0ZKUGxOc1N0?=
 =?utf-8?B?TkkrZ01nNzE5NU05aXZZNU1qWXUwMWlZRytscmc4a2VUY2preXh2SE9ud2xE?=
 =?utf-8?B?T1FFQWI3aGdOR2xqQVQ1Qks3U2JLWFptczdqL1JOdHFrRjNGd2llTlVKOVBv?=
 =?utf-8?B?WVQ3Z2o3WTg5MFllOXBzRFYxakdEUDJmemlITGhtbnEvbmk2VnlOQkxWejJu?=
 =?utf-8?B?Ui9CWS9ZTHpDeWMzaUFsVmdnR2VGR1RTQlZjSVdXblUrSW10c09wWVIvb0Ew?=
 =?utf-8?B?NXhPOHZmbGRtL3c1RitUZS9xQU9kUThnS09sV2c0ZmtQRWRocUlqU21hSFlr?=
 =?utf-8?B?L3Fla1AzQWVXOWt6Z3RQL3NsUS8wTWovYkJraHk0WnRaSGYyZzgvb1VDN0tp?=
 =?utf-8?B?d1gvTThXL0VMekZZak9yWjlLbUJJdTFmd3dtbVByVDEzK203V1JONGpESkJa?=
 =?utf-8?B?TlpoWU1SOS96YmYxOXV0M2VUdWNXV1RWU09ReTBmMUJ0c2F5YnVXMEZCWHNt?=
 =?utf-8?B?Q296d0ttanRtYVcrZStjS2pLb0M1aS9hUE5kaGpVQ09nQXVLbHpTZHNicThu?=
 =?utf-8?B?NkE0SDh5MFVTa3dVWUZLTll4VDBYdGtOclJhQUVqa3hVS1UwSjI1VzgxMExq?=
 =?utf-8?B?NC95aDM4OHEwQ0twOFIxelVQVmNiaUZYamIxcmFWV0xtTEJtWnFxZDNONW1v?=
 =?utf-8?B?ckdRd2tETDJRY3c4YVFhSElkWnBCU0x0RDl4NzNrRGpaTi9vR0FuTlk2aElS?=
 =?utf-8?B?OWRxMWNJT1FmVmdneVpRdFZRSFJTN2lDMU0vNGxCVDRheW56WmxJZGRjNm8r?=
 =?utf-8?B?dWJ6dTNxQVowVE4xM1FmeTRUc0xmeXFvYlVLVytJTmpiYmMvZDBTZExBTWY5?=
 =?utf-8?B?S09yWklXQXpmdTNCNE1IaUhxM3Nya3BOOTdoM2VhNklJUi9Md3hLMHJpK0ZS?=
 =?utf-8?Q?mJiAVN2NNI59y65cr0Z7Wz2p6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(52116014)(376014)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZS9yMURDYTZTeEV3aFZYRlZLSkVjL1FBbGhFdlJic0hSWG9hb3hML3ZabU5w?=
 =?utf-8?B?d1YrYTdBYWtPbkVSQTcxcmh4VzhBZU9MbC9mNUgvQ2FjNjNsWXdmREd0dEJH?=
 =?utf-8?B?dWwrdjdEOGY5c1JUTkRzTXJTY2hsTkt0UFlaYlJiOFZ1Nm9XTkN0RllGUGJY?=
 =?utf-8?B?dStBTTBTNlF4ZnlaVWQxS1d5SUZMNm1sRnFhWFQ1UDlxN2dZY1djYk5NMnho?=
 =?utf-8?B?WHdnbFZ6N0U0aU83SVZGSFloRk5sV3NldFdCRFZ2U3VZckQzcWplM29lMi9F?=
 =?utf-8?B?MTZyTklvU2Q0bC9BMFh2dzVvZVlVVkpKOVBtWGxCL0FuUnZJc0R3TFRiQ0NZ?=
 =?utf-8?B?a3d1K09rTXFQS0lMUDBJcmttQkc3blgvSDdXRkYvKzY1TWZnQy9rSDB5T0VD?=
 =?utf-8?B?UVUyOW1UQm9OQUlOZkZwS3dDVVdnaS9nN0xWbUdXRGYrbWZFUGhKU1BaYWhB?=
 =?utf-8?B?VzRlVWw2SU1MR1QyRW8xclJlVVFBQm1nOFBjQnhiZXJvZ1VVbnoxYkJxUjkw?=
 =?utf-8?B?V20vRmlBTUN6K0xtMTkzcHZrNW96c2cremI2clV6STlSV1RGcU9OV3lJSmVV?=
 =?utf-8?B?WkVtb0p3dXZ6R1I5cGtub3NrQkdLTUQzRm90TTV0YTJiaUNEbjZkZ1pBeVlQ?=
 =?utf-8?B?SXg4ZjlHY2dtcW9xRjFDMTBsSGMveVd5NTZWTEZBUE5FUHZ0cWluYUVmY1or?=
 =?utf-8?B?bWQvZ1pHSjNveGNrYmFqOHE0YkYycGNLNkwraXNVcUFZWEFweTBFdVFxMXJo?=
 =?utf-8?B?SitjenEyT2FlTmdXVjlpa016M21GbnJsYkJsVFRXMTJJNkRJa3F2TFlnMUcx?=
 =?utf-8?B?VGVPRXplZis4MkkxQ1pEVEZIMU1kcm5XUmRWcE82R2MxR0N3NHU5MmkyekxS?=
 =?utf-8?B?Y2hSbDJBR2VhbWhwVEI2M0xka1hZYnhiM0NpWnpJaE5ndXdhb0tIdVMxajFL?=
 =?utf-8?B?WnlSOENFOE0veFFVaHI4T2hVNzRQYVZMeWQ3dWxGNnZiUHhJNWZBSGNZdmFr?=
 =?utf-8?B?MlVVM1FNL1Btd2ZOVmpXM0FsNkxjaWNBNE1Jb3N2WG10bDZPTUtERlkwWjRk?=
 =?utf-8?B?NXhMbFZRSmg3N2pEV1ozTzRZTVFPTHVhVkdVcFk4eXlIUHRoeHEzQmgwbHBM?=
 =?utf-8?B?eEpHUGc5Nm15MWFEcGprVVRVSzFseXFpdndFM2N4R0k1dmdFWXhkdGhBRUFO?=
 =?utf-8?B?TnRheXFDRE5sOEhDY2FRTFBWNzdLMEQvTCt6cy9za1BhbUIrNWRFLzVsQjFU?=
 =?utf-8?B?Z2JJZU9jdDNGY3gwWkdxWDBndVh5ZTRCbWxhakowQ0h6N3N2emoyVXpMWFJz?=
 =?utf-8?B?QytJMnJ6V3FKVlhpbWpFeWU4T1p3bnNNU1hqeXJyWHJlckhZOWpCd2w4elph?=
 =?utf-8?B?N3VQZkh5V0lhWVpaMTJwenNWQ2RrLzUydUVVb0xKVFdwQkUwbU5yZXYvT0hi?=
 =?utf-8?B?eHZHNm16QzlLSUQxVHFOSDNHQjlOZi8zdXNIenl6anpwZithNDdhelNFejRs?=
 =?utf-8?B?ME16OWJkYU9kdytMc2VCMzlYV1BPeXNta1pvdEVQYkVwMEhOdVc4aHBiTDFz?=
 =?utf-8?B?cEhXRk4zV1h2WlY2WUx5RW8yMDhXZWVGNkQ4R0xJbGZlcU9KYmxFd1JseXFS?=
 =?utf-8?B?NlNPNmdRMlE0WUVsWThQOGFuSEJsTDNJMTRzQ0pKZllLS1V3aENKZW5PbHpK?=
 =?utf-8?B?RnNYdlRuMmRpWDBBTUhOZ3pmY3FpQTNwaDBydXFaRS9SZk9sbk5Ea3ZUb1o1?=
 =?utf-8?B?UXZNSWNRNXRxN1ZPMkI3bU1iVkxpTk16QWVRYXI1SFZQVWZkbGdGaTh4cG5s?=
 =?utf-8?B?cXFvWTlEaVkvM09oQVRkaEhSWER3MkhmZUtqeU1DU1B0VFZFdHZDWXhVYzNh?=
 =?utf-8?B?NmZ0V1pJMURFenhxY1lycWg0U0twM0dwS1RMR3RqdTJTREZQL0VoUzBZa1NU?=
 =?utf-8?B?a1FVbHc3ckk1dmpYZTFTU1A0YVlqTTFJTW1lU1JPQnpUbFArandib0o5L2hG?=
 =?utf-8?B?TnpDSTBMUXhGandkc2lCVnFGb2F3QjlXQXpJZnVsQmR6NmxKeUZtY2lDc2k3?=
 =?utf-8?B?VVhDb1NpaGJKbGZEQWRQOFB2cWc4blN4Z1RKR3B1dnFXbW5PRjZMOHdJc2lu?=
 =?utf-8?B?ekZhVDFhRnJaTXFRNkZobHM2dGxRdHVuMmRRTVdFTUp1dkRBSVZZZkpwcGtl?=
 =?utf-8?B?ZlBkY0VzTWtXdmRVdkhyR0M2RWVMZjZqNnE1alJlckpKK0REOC9NVHk5MWlv?=
 =?utf-8?B?YzFjRmhVZ0czaVR0NFZYd2N0L0RYdGxOZnEwYzA4YnN1L0hLM0t0cU1KdFRu?=
 =?utf-8?Q?Da8Q9FjTxOcKkiiAJu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bf7d42-1c0c-435e-155f-08de5f5f8575
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 17:55:00.2059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gx3ULtcvyvcTaDnB4g6GT88PBT8b4evJaWSL+XklLCqfUIV5ObSXIus016cBdDuJ35KIUb2nW9WVsipH1+VCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10777
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8583-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devicetree.org:url,nxp.com:dkim,fe400000:email,amlogic.com:email]
X-Rspamd-Queue-Id: 95745B3504
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 03:27:52AM +0000, Xianwei Zhao wrote:
> Add documentation describing the Amlogic A9 SoC DMA.
>
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../devicetree/bindings/dma/amlogic,a9-dma.yaml    | 70 ++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> new file mode 100644
> index 000000000000..7d044152fd76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dma/amlogic,a9-dma.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dma/amlogic,a9-dma.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Amlogic general DMA controller
> +
> +description: |

Needn't  |

> +  This is a general-purpose peripheral DMA controller. It currently supports
> +  major peripherals including I2C, I3C, PIO, and CAN-BUS. Transmit and receive
> +  for the same peripheral use two separate channels, controlled by different
> +  register sets. I2C and I3C transfer data in 1-byte units, while PIO and
> +  CAN-BUS transfer data in 4-byte units. From the controller’s perspective,
> +  there is no significant difference.
> +
> +maintainers:
> +  - Xianwei Zhao <xianwei.zhao@amlogic.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a9-dma
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: sys
> +
> +  '#dma-cells':
> +    const: 2
> +
> +  dma-channels:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 64
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - '#dma-cells'
> +  - dma-channels
> +
> +allOf:
> +  - $ref: dma-controller.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    apb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;

If use 32 address space, needn't apb node

Frank
> +        dma-controller@fe400000{
> +            compatible = "amlogic,a9-dma";
> +            reg = <0x0 0xfe400000 0x0 0x4000>;
> +            interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +            clocks = <&clkc 45>;
> +            #dma-cells = <2>;
> +            dma-channels = <28>;
> +        };
> +    };
>
> --
> 2.52.0
>

