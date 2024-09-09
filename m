Return-Path: <dmaengine+bounces-3128-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7721A97212F
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 19:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9309F1C23E61
	for <lists+dmaengine@lfdr.de>; Mon,  9 Sep 2024 17:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D8418A6C2;
	Mon,  9 Sep 2024 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bT75Xy6P"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7C18A6B1
	for <dmaengine@vger.kernel.org>; Mon,  9 Sep 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725903448; cv=fail; b=tKAE95VOcMFahvFaFImvUFau99Du3ca0kBjsReRspkJQ7CvVc/xvceuCFxbjfA8hNoPeu0OqnA8Fzmwre1+gtPc00/JsSEWkfRXUg5JM9QDxo0t86ce7Tvuzy0mhIKukaxNeo8/+YKrjdyXifFAHwO1rGsvU5xjX2AYBELrnBV8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725903448; c=relaxed/simple;
	bh=vPBZvqmzoVU0J+bTEWw99U9XBsLUUp1S3vCbOL1+MNc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=avj7QMnQb7Po6eWjmEz/j+sJXDOMumJIeL3qqYjNzDgTyPwFffb5gGkbGOzTiEYpHlvZUEUGxgRA5Z+H6dDJlDSv3850Glmnvf/R0MifRrv67vio2xeLD2ia54dz3UlpbTYHtsoacfYq4u42caTI0YJdjTk3jxnzVYKiULqGqTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bT75Xy6P; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJLlwtd3P23LDg/g/UepJB+CgQD6tbk1BUPUvr3sGqUcSYeh393uk2SGF0rpf7KX4L27AqozchP/eDszo/YYN15giDozyzQyskV4MhbplZAGVEGsTYt1FYHkTzD87f5/ZB6MT7r3b9PJIGPleunEhOF1Qk5V9Yxi9uyxSgjE/3YVzhA3TahDSPdWrY0vClwPX0SUiV83hnuQuU4Chk3fTnvoXidXVsSpWnXR1HwuBnRuiY8t1TtiFGWA9IWy13Ous+AWjyyDDhJNbQV6VJC/PcgmrYLnDSqvNG64LPh4njJDiPCtOMx5yhumnEoZ9UvAXugswaSP2X9W1Hw9ri7Irg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXSFxUvavW63J4utJhng37uo3pd8QePYRLXizuM4bdk=;
 b=t3ZqZRY+O/LYE9JxlQk8OfdM/zU9kPbjNXBfZwRPt7Q+WTgjv1v8UA4M5BTcbUNRJ86jMvk8Ed+LsNSe04dMO52JgpIufAfXlAi7hwC5JvQ4FYKCRdxj4PRIpBvsr777jjWy0vXF74R64vf3Prphkp55FIMAI+Fhv+R+BqgH7d4EKxAQicUZUR1nfvjNwNAP2LEBLUuF0ybx0kf0fmHbHBOzktshbh3RzAZhSCKpEGYg7mCVU9j396SSLXXm5iwuCVoHwBjLApRD7flbOSCleK5Mx7bEs83akIlz0wPgEXRjcdvwY2PY3/pTnaPvB3jMqSOM/b+ZdfQa5EQ5cdO8Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXSFxUvavW63J4utJhng37uo3pd8QePYRLXizuM4bdk=;
 b=bT75Xy6PYpEkVheITgHhZMPwG8VVJl+VvjrKzP/IhOb5F0TdBPJNPEsyLRrv7tVQEo46heXMErAQK1iD3kgfaQET7L0ap6facp65zcmxPDuCH2VlZkWCzI+QWdpzVoVOWOYdpJTBicUdC13Ntkm1DEQ/kEtECaftMlSKdCYgHDs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB5760.namprd12.prod.outlook.com (2603:10b6:510:1d3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 17:37:24 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%7]) with mapi id 15.20.7918.024; Mon, 9 Sep 2024
 17:37:24 +0000
Message-ID: <971154e7-2022-40d2-a274-a7ca4b616b70@amd.com>
Date: Mon, 9 Sep 2024 23:07:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] dmaengine: ae4dma: Add AMD ae4dma controller
 driver
To: Bjorn Helgaas <helgaas@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Raju.Rangoju@amd.com,
 Frank.li@nxp.com, pstanner@redhat.com
References: <20240909160726.GA531636@bhelgaas>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20240909160726.GA531636@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB5760:EE_
X-MS-Office365-Filtering-Correlation-Id: 09eb9d74-16d0-4e0b-7b57-08dcd0f6108a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wnh5bGd2V3VkOHRGa2tMbDdiaFVZckxRQTRoM3Fxa0pTQkRuNmJFYnpKOERV?=
 =?utf-8?B?K2NvTCtYMFJjWjdXRCs2N1pkdlRwSFZjQVBESUhwTUFvaTB5ZHhLZlg0N3ZG?=
 =?utf-8?B?QkhUZ1hEUTJyTFlsc09SbEIxTDA5RTFxeHBTazZzbldDUlI2ODhNVjhmWVE3?=
 =?utf-8?B?eDZvQ0plZldRQWs0Tkl0YjJacDRJbXQ5dWpUVSsxVjhvM2sxWWk5VlBLbk4y?=
 =?utf-8?B?VGl3MW93bGJja0dMWjdaWXNlbk55bEdTTktFbnpxT2k5ejhRQmt1bmlTaE80?=
 =?utf-8?B?WTJMTlo3emNCQk00RFB2ZnoyU3dhRFF2OUc2VE9CUnFNS3VjdDlrNWdyN1Yw?=
 =?utf-8?B?UGpab0xuY3hFbXJ2Y01jU1YxdDkxaGZxSVAyb2ppU0g1RDhINnkvOURPMnVO?=
 =?utf-8?B?bWhFRk1nTDFDZUlBRVBQbWZqaTlLdW96enI2eXROeDZPTnEyTWRpMU5oSmJP?=
 =?utf-8?B?TVNpUXBSNUdDL0orT2VMSzVjWDBUVlR1STNBUjVzK2QxUzFOdWwwZXorTXhy?=
 =?utf-8?B?Y1piTFBYQ1RzdzAzelVqNURoU3M1V3NKQlB0SXFzZUlaRjdndzloZW1raUpI?=
 =?utf-8?B?VEoxRGxTYjIvZWxmVEYrbi9kS2ZVWlZqWEV5S1pTUFc0MFcrZmE2QW1mcXox?=
 =?utf-8?B?b3IyNzhOcUcxVjlNdXRCazNKZVFvSTU4Z09KZ0ZBOTZaa1RKb3BQYnZHRHh4?=
 =?utf-8?B?Nm85NnE2dHVEMUhOUE41SXJxOVJWL0lOenlpS1UvVGtTZGF0YVRzd2FxL3hZ?=
 =?utf-8?B?d3NNSnYya3hUdFFQS1Q2M2Q3YkZhTnpQSm9YMVpZR25PNzV6WkZMcU1MVmtz?=
 =?utf-8?B?UnZtYTJJc2hzOW84NHpKbXhPMWpmY3A2cWt5NTlvQXhjTWpPWENDbjE2MUpR?=
 =?utf-8?B?VzRFdk9KRHRUTyswcjA2SE9va3l6ZHRWR1ZrallkQk5EeUo3M2llOVc4SVpW?=
 =?utf-8?B?WVdOUkpzTlNqRlZIdFhJSHVpdHRKRHBGWFo3SlZ3bXZBeXNQMVdFVGxZTnRY?=
 =?utf-8?B?ZDVwYXpOS2tTa1BtU3FsaVVGR21UUnRoMHFNak9sNGduckdjUTM3YTJaY2Fi?=
 =?utf-8?B?TXdhOWNvTTNSYTdQb3A2VXZKTGRKY0M4QWRMYllaOVl3L3NWeDNuaUprcUNM?=
 =?utf-8?B?bm45VkVtQ1JoOTdNQ2xmZkJsK1kwdlFyU0JIL1N6Z3l0NEpkTnhwLzl4YzN2?=
 =?utf-8?B?OEdpYlIxU1lvaWp0Z21tVFpielp3cFA2UnFnejBnVy93NVNEZzBDbFhMSFBF?=
 =?utf-8?B?NXA3UVhpdllyYUVQcVB0UFltQ3dmOUF3SVJuL3pYZFN0U3gxRGlBSjZ4L1JZ?=
 =?utf-8?B?UW0vRTkweitPMjdQUXBieUdOTFMvSitEWU5lZXpoNzNoSG1vNFFHaThSMld3?=
 =?utf-8?B?VXY0YjUreWpOYWNWOXJJaFVjZ2FUMElOUGoxdFZ1U0FEZzk5Y0FPSFFUZnZM?=
 =?utf-8?B?V0FWeGNQRzJJaElycElZdjNUOHlobmlTakZKMHVubk9tN3pYTU5qZzBtZC9l?=
 =?utf-8?B?WHNKWk1KLysyVlh2UDZjUEk5QkJxOU9nR2lZMnk4ZGpRSW81RVdrQml3dEhl?=
 =?utf-8?B?ekFqa1lGYjdFWURjNE95TmwwS3htd2lBa0RUeFhzbDlhaUEyeVppQTNHZVY3?=
 =?utf-8?B?RWk2VUMvTkZ1dkhrUDRob0Rsb29QN2l4ZjJPS2lzTGV1NDdEMFlnWTRnWmJw?=
 =?utf-8?B?WVdkcDhRWkdENFVFWGdhUW1MMXpqci9sUExQWW9sVkVkLytqd0I1bS96TWth?=
 =?utf-8?B?WTJ1eEY5Nko0QXZwaVlWdERucVY2K0hhdWpYc1JpcU1iYnluRFpuQ3QyWng3?=
 =?utf-8?Q?jbqAT4aoPfsCeRJJ5LYFyOAWzoiFTGSU4Eb44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2F2blgxaDVIMGxFaUNVdFk4M2pHV1JoN1ZZT2xBZlhxNGpFbFpzUXpEV29L?=
 =?utf-8?B?ZGVjNmg5WHVyZGREUXZkaC90Rnk3ZXhZcWdrMUdlTkhrWTk3cFZ5SVRVT2Vj?=
 =?utf-8?B?WTAzaVRXZS9PNFEyRE4zQXZ5a2p6LzdSalR3U3lxOUtDLzZQMEM1ajBxd25J?=
 =?utf-8?B?bkprSTN3OGRZVXRBQk01VkYrbk9xV25NSjFmNG8raVZGTGNoV3JnVVovRlJv?=
 =?utf-8?B?SmlIOHlIY3hmRDFmSk5MVHZ0WkpiK3dhemVzUjZQdXd3czh2ckRzbXcrNFRt?=
 =?utf-8?B?Yy93ck50Q1pwUStIRklGZnQybjRqSFNBUmJiWTBrK2FKRGRWSXZxMWlWSVB3?=
 =?utf-8?B?VWtoYXY3ejFVYU1Ba3AvZE4rZUdTRW03Mld2ZGd4TFdtb29nNXRKbndOczBL?=
 =?utf-8?B?TVBEWG42Ym5CWG9GUms3N2RrVUh2M2luTnU1UGt4TUhLZXNuN0FXNytkWmZW?=
 =?utf-8?B?MnRBNmpwc3hKL0FUSzFmTlhUd3pKanB2OVFUQU8vczdaMEN3d0UxUy9EU2dB?=
 =?utf-8?B?a1JyZThoaStWU3VCZTlHWFpvdG5XbGdrV2tlb2syalBoWGY3MVoyV3h0c0pH?=
 =?utf-8?B?endiWW50VlFJSFVyNG9wRlVHaXhOTDhyNXVBT25MNXpIYllMNG9OTklKalBY?=
 =?utf-8?B?RFhCWTA1TUhwK3A1SU94cHlBeEJVOCs0eGJ0TDFtSVFLOWJ2d21VYUZZNStR?=
 =?utf-8?B?UEIvd3hKeWR2VjMwSlZNMDVKa2MwdXZqT2hvcXBmSmRxb2h4OCsrWXE3RzN2?=
 =?utf-8?B?akQ5aHJaZVJKTVljdU5VVXh2aGZ3Lzd0c1IwRnkxUGlwRzdDaG5nZ0lYUUFS?=
 =?utf-8?B?ZnE2V2VxUHV1bTZjSUljWFZqeDMrNEJIMXUxeDBCRURlMFNiZTZDYlFVMHps?=
 =?utf-8?B?NjF0V1BIbU9qSVA1ZDJoMlZXWGxsZXpXcis2ZWgwL3FIaHI0ZmloTkEzb2xx?=
 =?utf-8?B?ZFdEbFc2ZkgwWVUrV0kzRWs0ejZucDQ2OGZYQzhYU0F2L1ZaU0Zmb3JXTlBT?=
 =?utf-8?B?OGZvNmxlOFp2bnBMd3RtanhqMVJYWmM4anhjdWtRNy90K3BQSmppbjRsL3NK?=
 =?utf-8?B?YkFYaktPK25iYSs1ZlJwOVZvYldpQU1pS01CaTBaSENuYmVTbmhHL3Q5djlC?=
 =?utf-8?B?Q00xaE1pTTVKcXk2cm1LVFl1WGwzb2Q1VGgzUU9FblEvbTdmRHhmWFozZFNV?=
 =?utf-8?B?RXFJVWhRaFVHUjBJa0ZOODVPeWtxd3FybG00enhxODFiS1ZtK1R2Q2xRK244?=
 =?utf-8?B?U0p5eTBGUFBFTzU2K0FYZU0vY1I5SHJvYWV2ZFd5ZVR3cXpaQU4xTVV0MVNa?=
 =?utf-8?B?c0NwUXNqOGJjM0h5ZFVONXlPVHpHUnNhcUtLcWZkU3Q3bi85WktGcE05WTQ1?=
 =?utf-8?B?ZkRJY1V4TlRvd3RQVFlYK0JtN0dJQThMdWdoUlJyY3EvMC8vYXl0MmJ5YU9D?=
 =?utf-8?B?U21KUkt1bnovMUVNUkxzUU5iWmpnd0dIYWtGR2ZkYlNPdUUzbzlFZnRtWFd5?=
 =?utf-8?B?Ujk3QnkyN0FlZ01ZZWxxTmtIV0JoL0toUmdDZ3I4REFwV3dtOEZPOVJRK2ZC?=
 =?utf-8?B?NFZjZHM2c2xwazhHOEdoR3JlUkJaVVNIVndLcG8yMVlUdWEyWDlRbEF1bHZ2?=
 =?utf-8?B?YTFtY0lqaU1sSC9UdUJoSiszSVJ6anM3ZTFUMEdobC9HcW5WdEVLV1lCcGIr?=
 =?utf-8?B?NnJQT3NjdkZ6RUlncmZIdkp5RE5odW1zbTBZR0thSTBQeFdQc1ZPUFRISjJY?=
 =?utf-8?B?V3Z5NkZaZWZCSzEzd3pNVUhJWks5bUcyOWlEUWlYQXRhSUxGVU41MnBHN3Bv?=
 =?utf-8?B?U1pnbGo2bjBSdGNSeVRMRis4UkR3SVB0MVF5YU8wL2dpYUZlWk1pakJyZ0Yx?=
 =?utf-8?B?dDJSQ29EQmIzMzZoZHpLQ1gzOFFORFd0WWFCajV0VndLcks4V0NuVWFHNWNt?=
 =?utf-8?B?Q3hjblJiMnEvNEdJL0hrc201NW11ZUZOTXJXMjhNSllFODhNTHcwMU5TdTQx?=
 =?utf-8?B?V1pqdHh1dE5ac2pTc0NqQ3lpUzE5U3lSdktvVnBrbjQ0K3o1MlQzWTUvd2hD?=
 =?utf-8?B?a1ZGbmJSYU93NHlpYm5CZkFEUVVCQmRVa1R5RHJRby94UE5CdXp3OTIvYXVq?=
 =?utf-8?Q?XMhFg3XB6GQyTZWV/bl8xq0gu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09eb9d74-16d0-4e0b-7b57-08dcd0f6108a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 17:37:24.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARRIJYMsPcfL/e9/5EBufVAKESWpn26zCLVtgiuu5I88LabmKorCEcW2RuIhRggdVSB5mXzQtqkXPBEQWqNYww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5760


On 9/9/2024 9:37 PM, Bjorn Helgaas wrote:
> On Mon, Sep 09, 2024 at 06:09:37PM +0530, Basavaraj Natikar wrote:
>> Add support for AMD AE4DMA controller. It performs high-bandwidth
>> memory to memory and IO copy operation. Device commands are managed
>> via a circular queue of 'descriptors', each of which specifies source
>> and destination addresses for copying a single buffer of data.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Reviewed-by: Philipp Stanner <pstanner@redhat.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  MAINTAINERS                         |   6 +
>>  drivers/dma/amd/Kconfig             |   1 +
>>  drivers/dma/amd/Makefile            |   1 +
>>  drivers/dma/amd/ae4dma/Kconfig      |  14 ++
>>  drivers/dma/amd/ae4dma/Makefile     |  10 ++
>>  drivers/dma/amd/ae4dma/ae4dma-dev.c | 198 ++++++++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma-pci.c | 157 ++++++++++++++++++++++
>>  drivers/dma/amd/ae4dma/ae4dma.h     |  95 +++++++++++++
> Just kibbitzing here since I don't maintain anything in this area, but
> IMO there's no benefit to splitting this into three tiny files.  It
> would be easier to read the driver if everything were in a single
> ae4dma.c file.

Yes Bjorn, the files above were created based on the files below
to ensure consistency.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/ptdma/ptdma-dev.c?h=v6.11-rc7
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/dma/ptdma/ptdma-pci.c?h=v6.11-rc7

Thanks,
--
Basavaraj

>
> Bjorn


