Return-Path: <dmaengine+bounces-8560-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6M/SAUBSemnk5AEAu9opvQ
	(envelope-from <dmaengine+bounces-8560-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:15:28 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73397A79CC
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 19:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CD1E30D9FD3
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B613A376460;
	Wed, 28 Jan 2026 18:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RYO0Dxvy"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013040.outbound.protection.outlook.com [52.101.83.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C0C374724;
	Wed, 28 Jan 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769623560; cv=fail; b=n7JvrHppdTKMTLzKzmENGcPgvk4i8S7tvpxtmXgZpG7An+aWM9NeDLD/w657Wj05dAxH7Qff2IFjn66+n3DY+4QzY5nj9VEPUlvbjLp0HHBqz2t11lfUzBDEvmkxGoP+bPqO/QcA2RAgdaxxjE9exWV6GEBz/zx3bGHwD6UMA4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769623560; c=relaxed/simple;
	bh=WhdTJgFQHj+jxVuEtyVaRjoQ6J3j6gGSO7KwHyxGxQs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=B1/hFGK4hc6ljhfXBKnbxaWuWmwSAVgCA9kw+Xw4V9b2ci5Gz4HGQdSCGRLLH6nEOyYw76Lfjr1T27otx92v0mTkh38DWHsTD+DvYq0zeLnueGL/wzT/nssbCROWvFPpRh8uYgUKTnLwHiwzTIL4Tc5TM12Yoanm+2wZMtD+P+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RYO0Dxvy; arc=fail smtp.client-ip=52.101.83.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gQOz/yLyI4CzDdThu5zGudS3JqO2o5vnMCPdlzTvEg0WRRPjTzRgY6RX9x/rI8UolfYeipPP/pkv6Q7FR1LXsu9DaRKT14ahGH0AC4T09l0MqfsYFG7XM1hailzFzW6OjYPTS+6FnsnyAsh2fMmdq1OW36ff18KthXYCRi0CzvKlz3mXZg0DH970jrJ32aWCcEmXii5D5tpZNUJ/ACJpfs6/O/8MsKwh32P2bphuog07cLSkNL3EKn76ILZhrCWzYmndTMuOj5NBeHsMeyE7+9hnvgFwFDmh3HJlJddxjZgvNYpPhWdwDiku9GzIB3HY6G8/zzdPVHpluUslsgzgrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fXerTDKLPRQLn0aiW+DfHVPXOWdBhmmpcl5Xq4LiSg=;
 b=mzI2+jLW8vaDuj5g43wzwOBJN65lHSPR5rK2RGeheHbSf0zsvUVK9ymkfEsWjH+cESmh1phKkSwVDAHGubGuFNTnwEozJDkkV5qkXkig7KuStcMjFhjBivjevLW0rnIFNKlF2B89WErnFk+jC15PYvoxxNlxKItytxJthRVAq34VpQrZ76YgKcSjfzKkoR33fkGkTA029cpoqHBjOwFSoww4/99Yc+DnxKfxlwucWVwArBk4m/K6PrRC3AuRZakwuQtoQ6YZ1wRXwQRUXhbrI4oXRRy0Yfiw0+unshjN/ANOd8KVQ824cjV54SH9T7PoHOUdmatqm7bv1cKiyMBR9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fXerTDKLPRQLn0aiW+DfHVPXOWdBhmmpcl5Xq4LiSg=;
 b=RYO0Dxvy0IBFrNAUyEN55YNuOjd86ffP7WBVUl4Ep3ZPY6NRKgNvqJkTdEoHDxmwk7eu5Sa+uNGuv9JV1b01c+v5DcsQDfPuVuu5tijWRnGTUJy7UbTXCxd4fa82Lt6Sgg1QXJW72NgLsHecHK+6dUOBf4dAR5f1Euithf4pA4ADZ9z5DDbeoW0p23x8a11x/Iu7HC65cr3zIP7gU6zepG4TpGxD31QX7dsOF1RCTnCQM1iyRg9pRiN2mUWMemcyjc6NMedkQPLHrV/qJL+3PXdpJL6rnvHdCJUYjoKabmQSfttFeQEtcD3dVxoa6erwqoUg7Hg5PxdyNAIWV0YEow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8145.eurprd04.prod.outlook.com (2603:10a6:20b:3e1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 18:05:52 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9520.005; Wed, 28 Jan 2026
 18:05:52 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 28 Jan 2026 13:05:22 -0500
Subject: [PATCH RFC 03/12] dmaengine: fsl-edma: Remove redundant echan from
 struct fsl_edma_desc
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-dma_ll_comlib-v1-3-1b1fa2c671f9@nxp.com>
References: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
In-Reply-To: <20260128-dma_ll_comlib-v1-0-1b1fa2c671f9@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 imx@lists.linux.dev, joy.zou@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769623545; l=1738;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WhdTJgFQHj+jxVuEtyVaRjoQ6J3j6gGSO7KwHyxGxQs=;
 b=LBRGxaifzfOxg8t/Zzu0qe02J/8T3f4q+eENTQ6TFaOtpFYwuw8kIY80b+Eo0kwen9K0lWex9
 VJSdUbBgVWmA5Rp4QcO+Ny1m6Y+dkOwV+ohdEZxZ53uoKvahHF+UHyA
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:806:20::14) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f862c5-cdbe-48a1-d595-08de5e97dfbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGd2VUdVZWtuRXZic0Y4QnU5R1padkFsSkhuWkdpVkFwekVYQXBFV3JxNHEy?=
 =?utf-8?B?anVwdXFCVTZlK3lWcUtlYnlDZlZBNUJkdk5VbTBadHBlR0RtK0MvbXkwTlo0?=
 =?utf-8?B?RytlOTFmQzUrN1dJS0VyazhWWTVmbmJJZXlXMjY4bWNSN1NFbHNiM0Q4a1ow?=
 =?utf-8?B?dUt0clJ2cEQrb2V3aHZ0V21hVkpBYmFDWlkrc21wUStWQlg0eGIyZ3o1aC9L?=
 =?utf-8?B?OUZod0Z1OHgxK3UySUE0QkZDMjZFUXFJVXZwT2F5d1lyR2RBUG5va0FrMU9p?=
 =?utf-8?B?VnFDemNrMFhybVQwWnNqNElEUnF6UGo0U1hEZk5kMGNzdVFQNDhrL2orUFRD?=
 =?utf-8?B?VDZpRWt0VTJDeG45NVhXTjE4dURONWVBbzNRbnIzM1RJbUFORi9iWVJuMFV4?=
 =?utf-8?B?TG1td1FpbFJQdE1OTStEWmFVL3RLV2xhZkdNOVFORzJwbzZteUtaSzZuWjNC?=
 =?utf-8?B?SEltRTBxTkc1TEl2SnpxbGpjTURqTTlIVytLa1Vha0llTXJXTW9ZWTE0Yzd3?=
 =?utf-8?B?RGVUZ1hLTUUxbWZnR0pyeUo0cWtQQnFITlRlNFE0Sy8zTGp0ZWgvaktPOGRZ?=
 =?utf-8?B?K3JaV2twcUVRZExDWksyZlAxLzVyOWQ0ZFN4T3hOMzRIL3ZiQ1Q0SHV2NkNa?=
 =?utf-8?B?aCtyWlFyNzRzVnV6VDI4OFRvamtDUkNzcktRTFRHOHQrTjY0TEt4aExYa3ZT?=
 =?utf-8?B?dXRWalBFKy83VlJFclFDc1Vwbi9xazFCNGtUUDBVUExFeGd2Yk8ybmhWUkdC?=
 =?utf-8?B?OTRwdE1Uc3FBR3F4eU1JSjRtRlhUajBvdlViNjMrNE5vWVQvOEdSNGppY05Q?=
 =?utf-8?B?eW1FOTFNT2N1MDM1WUp6bzBuSVZqRUpNTEVhL0ZydlRnWkpDdzQyTDdjZHNH?=
 =?utf-8?B?RFAwMnVGY0swcktxNXFVaTVIeDBLNjlLc3h1UFJNaENuUXE2RXNoVzB5UTVm?=
 =?utf-8?B?Vzdwb0tBYnlXV3ExU3NqSlRjVjhFM0FnNkdpeUYrNXJTNTlacHY4NkNyR3l3?=
 =?utf-8?B?eTB6cWllVXdYdG54RGIxYWNQeEdseW5NRTBGZkFFMDd5ZjIydjU4SlJObVFF?=
 =?utf-8?B?UkVHSWpDamJoeG9vNmpHbkZVL2NBajlrQnBpVkk5Q3lTb3ZmQ21OclZ6YmNZ?=
 =?utf-8?B?UzhjV0hBSFdqUWRqQUtuNFNWVEpVTld4Wi9DRVdQOFQ3TWJmRUhjSzBXVmR4?=
 =?utf-8?B?Vm9DaGcyQ3hTUllsM1d3N2NydUFIZ1lIbFFEbDBnMjM5dFE3aHZXZC9tS0ZE?=
 =?utf-8?B?ZWR0cjc2eFVHRWROaW9kV3RvVWptTWY4VFRwdFRSM2syTUo5ZG1VZFdFZEp6?=
 =?utf-8?B?REZ3eGxQRzh2Znd5QWxPUEU3UVRIVHF6RGROVkFCSnZQN2diZU1pZnBWNW9Y?=
 =?utf-8?B?U04vQ0VCNUpUZEhSZ1VDL3BGcTJCazQ2TjhSWU9Ta1J4NlhXc2lTSnVGRmtL?=
 =?utf-8?B?ZkU4ZEtKY3F5Q3Z5TVYyVnIySnFoZ1BRRWtzZDNkMzVSemd4NDBlaEQydkVI?=
 =?utf-8?B?V0JPMVUyUHIza3QxNWI4NVJzdXJHclVscmF2Q0tneHplbC9ub3pOaStYNWNp?=
 =?utf-8?B?SkFNZTYwYmVKWHZlWWI2TWlDT2pBbmppR2ZNVytwS3JBazAveUwrbEpzdnJY?=
 =?utf-8?B?VHZ1RUdFc09ucHZGM1dqMTdveGtpMU9aRkFtbXNIblBJL1VsQXZrZVZqclRF?=
 =?utf-8?B?alAzUmpCUHdpNGFldGFyd3l5b0pDK20wVFlFeE81ajRaMldDYzBrbFFPMTJO?=
 =?utf-8?B?R2dEcnhCOVdtWWREdFN1MkdyS3I2ei93SEVtVnRaZEVvQ0k0Q0NxLytnY3lp?=
 =?utf-8?B?aFBwaEl3U2o5dEFZS1pzVHBySXh6UVA5QUZFeE9FRnFBdHVJcXJiNDYvMFhQ?=
 =?utf-8?B?VThvd3NyL0xvTFVId1pjbGZpZlRpS0xQazhaN2xVNDRUdDhheUFkWnNjR3dV?=
 =?utf-8?B?Z25QY1ZKalJnZjgvTXZPTUUzRklDb2ZlcGJwUzhJck9IWkt6dVAvcHdkRi9y?=
 =?utf-8?B?NjNwZXZZS1AvcFd4STBYaWhGcnJpUFVvS2NEbzVpN1p4cHdqQ3lHazNBcUdT?=
 =?utf-8?B?OXhVd3FhMEJ0bE51elQwQWg1ejl5bXQwZitrbkp4eVV6V3RmbFg3Z3VkTDc3?=
 =?utf-8?B?MERlNkEzZlBaZmxkT0ZmOUY4TGJaTzNkajhBbVNvYVRGKytNdnRZTElTUU5M?=
 =?utf-8?Q?O3Ynlz37QbrR7U0cJ5q+6YE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHo3TkMwVHVFT0FETXd6UVh5d2xkaE8vak5uRDFSaG51UHFYZXB1R2VUaHVw?=
 =?utf-8?B?WFNzSEI4WWhsTFdYTXhNcFJsaUdCVUlZMWx0UElSRnNla1Q1Zm10blRYOEl1?=
 =?utf-8?B?UmFqODV3NnhTcTJaQWlzTTIxUnN5SDVHODZLZzd5QkZxV1Frd0RvK0RWbmtI?=
 =?utf-8?B?R0o4QWdlZ0NnUURSUkdlZ3JLamVHQ3V5QnpCMjZVYzFLNHdnVER6Umw2V2RY?=
 =?utf-8?B?TGJqaUtUcXdMOXd4czZkL1dxMHJtY2lQUXBDVDlUY0hXR2g5ZkhLZTZaVmUr?=
 =?utf-8?B?ZjVwR2svUlFvUU1pYVd5cGU3aTk0NWI1UmYxWnhZMDFwWDN4VmZhV0F5eU1l?=
 =?utf-8?B?NVU3TkZCVDRnWnFPVk1TbjlsWGg3OWdrQzh0UDk2aXRnS3VKdWk2eEFEY2lT?=
 =?utf-8?B?ME5GSXEyYUFnMW9hSTBFMDE4M0pJeVRCZ1YvUUZzb1VaL3JNbHlHRFpFMzBG?=
 =?utf-8?B?N2ZGUHBsQUdnSlZrcmR2a1R6OVh3MFlpZXVVbEpnN3E1alRvRWxSK2VSckJH?=
 =?utf-8?B?bUptZDBabGhCMml5bWFoTkd0eFQyYjRQM1dJWm5KQ05XN2lSM0NpVi95Zk9v?=
 =?utf-8?B?eW8vVEVpUmNOcnBoeTdmV0ZKWjVuQWgwbVBFSFhndHAzZkt6WUhYMVR0TFpa?=
 =?utf-8?B?KzJhVlEyTGwvMG82SGQyWnY4MWxuTlFTWGlTd1ZqbmpvTENRSCswM1B4dXla?=
 =?utf-8?B?NzJpMTNVaDJlZFZCOXFENHZkb3YvZVo5OGFtQzQ4NDBpbWgyWGd1TEl6bzBw?=
 =?utf-8?B?Nnl3VkNmQS9hM3dHcjN6WlZHL3FNMG04aVJmNjRLU0VZMlcrdjNYeHVKWFV0?=
 =?utf-8?B?S2RES2k4WlpnSFRWbVFXZnk5aHhibHZONVNmaStyd0NmM09qUUdBaDdqNlIy?=
 =?utf-8?B?OWUxNmNZV3FtMy9KZlZ3WE9oNW9iRDRRTVhCQkRHakVZVGl6a2lDRzBUeFVs?=
 =?utf-8?B?dWQ4MlVRSjY3WnlyeE4wdEJsaC9KZmlzcXdMb2pmR3ZyWDd1ZENvTndWVWVP?=
 =?utf-8?B?Q2liOWVpbFFTaGpRYTRCY2RnS3Z0b3BlejRSMkR4MGNlMVo0WlduSW9DMkUx?=
 =?utf-8?B?aVQ0U21vUFRHQkhreE5zYVBaQTQzS3BlZWRtUTBrL3dtdFhjRjd2RlJYazV1?=
 =?utf-8?B?RkErYU5Cd1VkU2VISGFKbnorL0dDVlVpTTd0WDFJVTM0a2pBaDZDKzRqcmU1?=
 =?utf-8?B?QlFvdEpSRGRzRjBqQlpQVXI2ZUI1ZUIxemc4c3NSWTlpUk1zR2RqaUk4M0ph?=
 =?utf-8?B?b3VDOXpqR2kxRHArSGRlTG1Lck95VGdNbXpNTFA3L09WR0IraHRJaDZhUk9B?=
 =?utf-8?B?cjB3MDNodERnOGlBRk1TWkJSYisvUlpNQjVOc2NESlJiTEFEVE9PbEcwWjJ5?=
 =?utf-8?B?MHFzNE5LSzFwY1FPNWZpcHFkWi9nckloREpwaEg4eXRsQldZTmNSa3FzMWVP?=
 =?utf-8?B?bjROTnpwZW9jT0RtOWpabEdqMGNXYk9hc1ZITytDSmMvODVHY0xvNjFDaTJ0?=
 =?utf-8?B?UFlhTEpTWi9EVENIWXNOd29FYzkwYUUyWURqWVFlOFRpVzZFQlJteElKSmdY?=
 =?utf-8?B?NERmOFE4aVVyYUtVWCtCbVhvdzZaOVVEU2s0RTVzcjNKeW5QVWdvVTVXS244?=
 =?utf-8?B?TnNmSjZZQ05HVmk1aG9WZ1dEc0dMRURvai9nak5SNWNvSC8vR2ZkZktWanZ5?=
 =?utf-8?B?TWlYUnpEUDlRWWFVOFM3b0VtZ2N4U3ZXRDl5ZVVxQzV0QVhuZlFVZU5kUG5G?=
 =?utf-8?B?RFMyTlI1eE9JNTVRVHplbzFmZjBaN1BrcXRPaDZpQVBkVkxaWXVIMDdDbVND?=
 =?utf-8?B?aGZYRVJGcEpvWU82aUVSTThzL3h1ODVYQjYyZUZ6N084WktaT1hTNVdLVzlS?=
 =?utf-8?B?a2hMVFdWZzNXZ01WQXNpSWZMbGVNUGZKcmtpaEFEdHBlaHVMa1kzRDZoRDRq?=
 =?utf-8?B?M1NWZk1xaHc4MG5OWnlpOHFQOHBqMm5BbkdLMDI1bktxcDU3ejN6bGpZUExK?=
 =?utf-8?B?T200M0ttbTg3R0dGVUQ0M2tOeDhFcEJuRUZHcU42R0dEN2l6WGZ1ZmVLdVFC?=
 =?utf-8?B?TnkralZQN0daTEpYcVJUVEhHb3JISVVwWDU0aGJXR2E5L0tPRlhBWkx4ZG43?=
 =?utf-8?B?akROekxqZy8vNHlGbVhtZVRIVjl0d0ZuSnRhOU9CV2ZEVTZycjJHQXVMb1pO?=
 =?utf-8?B?eXJjLzdPOWJzOEZiaFo3clJ4b2FOMG5kM2gvN3BsUWhhbi9yYW80QW1GV2R1?=
 =?utf-8?B?aU1RU1pFSklNOTlLTE85Vmc3eWJwVWZWbjdsTElOdFRjWk1CU1pmY1hhYzUx?=
 =?utf-8?B?aURIWmdsakhLZkRwcGpNV09TVUE3RXZYeWo0K0ZaNUhFa09pSXFJZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f862c5-cdbe-48a1-d595-08de5e97dfbb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 18:05:52.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilZysiEdGYf864uQ6hyrxN2WKWzKBhbAq/PfALK+p1q9u3r5+EzHGBO+Ya5N5uaCvo0rOL9klzsXVA++FfFGDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8145
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_FROM(0.00)[bounces-8560-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[nxp.com:+]
X-Rspamd-Queue-Id: 73397A79CC
X-Rspamd-Action: no action

The echan pointer can be obtained from the dma_async_tx_descriptor embedded
in struct virt_dma_desc. So remove echan from struct fsl_edma_desc.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/fsl-edma-common.c | 4 ++--
 drivers/dma/fsl-edma-common.h | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 396ff6dfa99a150f9ce34effd64534e3d8e8576b..61387c4edc910c8a806cc2c6f0fee2e690424bac 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -228,7 +228,8 @@ void fsl_edma_free_desc(struct virt_dma_desc *vdesc)
 
 	fsl_desc = to_fsl_edma_desc(vdesc);
 	for (i = 0; i < fsl_desc->n_tcds; i++)
-		dma_pool_free(fsl_desc->echan->tcd_pool, fsl_desc->tcd[i].vtcd,
+		dma_pool_free(to_fsl_edma_chan(vdesc->tx.chan)->tcd_pool,
+			      fsl_desc->tcd[i].vtcd,
 			      fsl_desc->tcd[i].ptcd);
 	kfree(fsl_desc);
 }
@@ -555,7 +556,6 @@ static struct fsl_edma_desc *fsl_edma_alloc_desc(struct fsl_edma_chan *fsl_chan,
 	if (!fsl_desc)
 		return NULL;
 
-	fsl_desc->echan = fsl_chan;
 	fsl_desc->n_tcds = sg_len;
 	for (i = 0; i < sg_len; i++) {
 		fsl_desc->tcd[i].vtcd = dma_pool_alloc(fsl_chan->tcd_pool,
diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 8e45770a0d3960ee34361fe5884a169de64e14a7..a0d83ad783f7a53caab93d280c6e40f63b8e9e5c 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -196,7 +196,6 @@ struct fsl_edma_chan {
 
 struct fsl_edma_desc {
 	struct virt_dma_desc		vdesc;
-	struct fsl_edma_chan		*echan;
 	bool				iscyclic;
 	enum dma_transfer_direction	dirn;
 	unsigned int			n_tcds;

-- 
2.34.1


