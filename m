Return-Path: <dmaengine+bounces-3058-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CCA967FE5
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 09:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C9D4282865
	for <lists+dmaengine@lfdr.de>; Mon,  2 Sep 2024 07:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3374642AB9;
	Mon,  2 Sep 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kr7aT+Gq"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CCF32C85
	for <dmaengine@vger.kernel.org>; Mon,  2 Sep 2024 07:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725260531; cv=fail; b=KJtHQnSiWLaLT23FJubAO2182r1kO/X1Rktx1UNpfdC1ijdxGGlWpsFtOWENt+uL8cX98+nQBLlwhiat5D9Aa98g84eQ+z+uck1+nRO4rE0wMHjtESTmZwQK7vb/qrhbh7nVXAR3J6Rfmnm1PmlPyBx6Smqz8QdVvVVXScMHdYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725260531; c=relaxed/simple;
	bh=WetxYwula1Paa2y0mpD+iW5/K52H70WZJgpS06n3CjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HKwrbROlG2rz1pPaIh2tIow2N4MlBGSAgwfw5KMfhm1Zj4RQ7jeX7UDa98oYkadCe3OU5Vf11BArnD4+EGVdwon9GHeKif8hRTzDPHYO1zX6nIOsfqy8criDeRh755Jmd5X5SMulFTJTzZg6XsONdQDOG/ckr6ro0RBId66MagY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kr7aT+Gq; arc=fail smtp.client-ip=40.107.220.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzU1sfD7qFzEah7ga22dppI60hQwop1m+/gQSx+QPHl294NUaTPycS0/UkJy8UuwJcIvMvjPPypnhuaiYxin3BrWyXUhI7jCuDPJEE6546JJjoC7eRYj1x8RCHOWw6MC8LUEPEw1J8YLSg9KuWG3a8Atkr4ps1ZPiT7svVFKM0ANlSrqE8yEFGDXIC091XBzTvubIOByUrFkZqh8LOPJDWrDJiH53oJPqPXZDJ8//iYgnQM8f4JA/6QE9TtsydOshsPtb7mcc3TDEOX67RxWBfDYulYr3cTNy6cmXurXG9E/Xmf6FzmSKFYnQJjen/gDUVcxhTdBfm6lWKzfoEvl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vt9BwSiX4/D59ctK1SwN2wRozE4bswEv+qeeUgLW5zM=;
 b=UNUsBjCmZlHiFt1Fr/WMsxhU/ZKbKnwU7y2hxaC6qEA9vJ3UyOZeISlxmvXjSTpPd2HQrG35GCdcGILa531uRtcKwBesTTgqkiG4t+W6tqdvdcTSWcDGsZcJFVVkNh3N0KpLTdOEBnoAH97B3I2FB6L5kVcTspQ/4jgzO6TQIfzBHRIjVJ6+JyMhnONydnLS91eYpfb06BKYIgBHHWoE2qwLoeusnXUbz3wbkt0nCl7qJl3bCGgQFwT1lD+ar3SJGz4Inqy9Pjds61LgoHZai/IMOLvPxTK3xHlxHD8WanK19vipmOFSty4lPUiCqjxYSoxsYKbpdzE9HMC3d3vhTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vt9BwSiX4/D59ctK1SwN2wRozE4bswEv+qeeUgLW5zM=;
 b=kr7aT+Gq4zvCNd8i9r9VqKA+ufC2PUBDIwHD2Dqz9XmyVsW2ie6Pt0GukyyasaeYhNrdscliaNtej74sC1OMZVxgq64Dx+1zLe7zEvTqoxDBQl5/Px65ZYB/0+bee8vYXJ69b/eUuzOkAmBTnPOuPWhZfle16C/3w86Ygn9O1R8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY5PR12MB6453.namprd12.prod.outlook.com (2603:10b6:930:37::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 07:02:07 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%7]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 07:02:07 +0000
Message-ID: <a2398000-f142-4f38-a005-271bbdf6bba6@amd.com>
Date: Mon, 2 Sep 2024 12:31:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/7] dmaengine: ptdma: Extend ptdma to support
 multi-channel and version
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
 helgaas@kernel.org, pstanner@redhat.com
References: <20240708144500.1523651-1-Basavaraj.Natikar@amd.com>
 <20240708144500.1523651-5-Basavaraj.Natikar@amd.com> <Zs9ikhDFPn1LNb5I@vaman>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <Zs9ikhDFPn1LNb5I@vaman>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0069.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY5PR12MB6453:EE_
X-MS-Office365-Filtering-Correlation-Id: c6b4a683-5668-43ee-c901-08dccb1d2840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MllESHBML2ZKTDlRbFd6VGF5eSsxU3h3VXM2NnhnNGthLzlJaXVjdncxYXpS?=
 =?utf-8?B?bUFHY2tRb09KMWIzOUpnL0NBNC9hS050NDJ0TXFkN05WQXNKTHQ3eU5PMmF5?=
 =?utf-8?B?bVdsZkNZRURlbk9MejdKWVdsYTJFUTVzNTRJU3Z6WW53R3JIam9peFJIcVRh?=
 =?utf-8?B?UHAzbnhibDRQblZBVCtGaE1HaENJUFladmVGKytFYWduVHRYYmlxbXJYSmxv?=
 =?utf-8?B?WjNueWczYTRJVGpibzFrVmw5VlVPbFBUUVl2TXF5NDNVSWoyYjR5N2R1YktF?=
 =?utf-8?B?QWFNRnZDVVFwN1d2LzZQUDFnbSt1UE4wVEtIM050QVpBSVNvVmlyaUVqR2dC?=
 =?utf-8?B?bUErQ2cydGxYMWdnK2E0cUFHZVlYUDBtK2NrN3c3bmlqaTFpRXVhaGg5YUF6?=
 =?utf-8?B?OFc1Qk1zekU2VnNFQ0dBVGF2OWZaZXJHTVBiM1YwMXhPZXAyTHJ4Q1VZdUpE?=
 =?utf-8?B?LzI1ZDVvR0M4WERxNGxQNUVuR2RKUm9hN2VXdHEyTkRKdStXMlU3MEFHc0Vo?=
 =?utf-8?B?czlweENlUXlUZ2pFcG05TEJBN0dHYlJ0TCs2Y09iNmtTLzMxUDAwcE1GTFI1?=
 =?utf-8?B?cVlDWGtWM2lNKzN3U08vZFZGTllNZEhiaU5GRWI0YXVCbkNyeFl1Rlp2Ykdu?=
 =?utf-8?B?bU1vTlhpVnNTMnhIcUoyMzl5UkI5RVd3b2drbmxsMFZZRUgvdSsvS0FWYUNY?=
 =?utf-8?B?RERZcUlMdGlqR1lValFIQ3NQKzRTRjRiRUErSEcrM1g5YzR6VnQycUxqbitz?=
 =?utf-8?B?NUZXZFp2NUNJamY2R2srOXFCbnNaM2w1MkRrNUdFZG9mT2MxNFdqVjZZL2dv?=
 =?utf-8?B?RWY4d05pT3dOcUowTmg0ZVVtTzdQUklzdlRvUkVzNVFXOXk1UHhxdnRLT0t1?=
 =?utf-8?B?d1dYRmZtL2lWWHFpTXA0MXk3RURGUDdwMVlYSGxDSWV0WmhGaGY0NEVwenll?=
 =?utf-8?B?NVZzb2EvSlFrRFAzeURaaTFtUTlSLzdBcWdHbmd6d21jWVBaZCsrS3NkRXI3?=
 =?utf-8?B?Z0JXdDVhbjBRazYvZ2RpMHZ1cDVkczJmcXlnTm5ic3UwcjJnMjk4am94eEE5?=
 =?utf-8?B?SmtpV0NFRjdmTU9Da1djaEpSeS9GT3BidjVkRjJwWkU5UTg0NFZQR1k2akI1?=
 =?utf-8?B?cjhNaXd4YkJwWVhtSFpSaEExRGVpR2h6VDlHTnRTOERuTnlxNEwyL3Y5OFBm?=
 =?utf-8?B?QVY1ckpMR0xNVnk2VWZmWnl3bE5ZaGtJVHJlaEl4aWljT1hpVGdsM1A4SjRB?=
 =?utf-8?B?alovNVRZcHBWRUEwYTB0MjFRbjQ0bmZqTjNrNEN5NENIZmdOM0g0R2pRQTAr?=
 =?utf-8?B?OXhFSXRDSExEOEh1OFJhNVRIek1CMG5VM2c1dlJVNC9PT0ZtMVA5VzZIeXRD?=
 =?utf-8?B?QTJnKzJndGRRazJ3YThnVmNzSktEdnlzWCtsL1RIR3NQdDhSd29zV2RMd2Zj?=
 =?utf-8?B?dytJcWRlR21GL1dhdXdrOVpYMG9WdjV4WW5zU3V6TTdUaHhPTXlYOGlWV3cw?=
 =?utf-8?B?V3RjNnM2TTFVSUZhRms1dFJCRUhxNXZCTmdza1A5YVdpUSs2T2ZLQVhhVGVo?=
 =?utf-8?B?aGczSkxCdEV3QVJ2RkphL1g3TlJBOG94WmRRczMwTGVwSWJkdDV0VXFnRUpP?=
 =?utf-8?B?NE40bjRlTkRiUW5KRDh1a2o0NUxpRnRFRTcrR3hUOHFmMGVpL3VVRzBpREFO?=
 =?utf-8?B?MGNqZXNVcCt4ZitPQy8rb1FGUUQ0Zm9JdHVEZzBocE0zazMzUDREWS9WUHhB?=
 =?utf-8?Q?sSlKINgLVpjkdwedBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUsrbkdGQjlkSHViUU1UNGV0a0lML3hldlpVZUx3K0E1b1VKd2hBZEtjeDJj?=
 =?utf-8?B?dTV6VGk4LzFqYmdkSEJMVDA0OEN4a3VXR05NcjMzYkRYcG9DNUhLYXpOYmda?=
 =?utf-8?B?U0txWnAxQTdhQ1crUTFBWHpyZWxKUmlKc0RxeHZxcUtjUkpTYnJqNSszS3Rx?=
 =?utf-8?B?OE5vSTgzd29Ud0NZNEI5aVNCeGFvaTk3MjBaMGU1MXR6S3N3emx5aU1BM1hR?=
 =?utf-8?B?ZmhWN1ZtcVo1T05GMkMzM053SnkyaFFLZ3Y5NlBBNjl6aERyeHZwdnJzcVBH?=
 =?utf-8?B?TjNoOHNjdUgxV1E3SlRIei9jcHdQdGpFSVA2T0s4QnJDYTZHei9QYlpPcG9S?=
 =?utf-8?B?WU1Vc2ErTGV1c0M1TEp4NytnZFpTcjhQb1pwRmtITmdOTVVkTkhHcTBCY3Ay?=
 =?utf-8?B?WFk5eFBPdHdnVk1VYkpJTlFHb000b3plRHlIWjF2TmNqYWw5OEpqODlUUmRM?=
 =?utf-8?B?a0tqZVdDOUcwdkFaajZjMlliZGNYYUt6OVQwbEloWktEZzNCMmJKZnk0WTIr?=
 =?utf-8?B?c3JnalFSVUVQV0cyYVNad1dtTkNydDBSMm16T1Z2bDBMTGVkTURWam8wT0ZO?=
 =?utf-8?B?VjdYQnpSQ1lqd3Rsd05vV1FLdnBjWUtnSWVmZ21OZFRBanpTU1BUaEIzWU8v?=
 =?utf-8?B?aHYzS2lWNGIzdGdTenBDdC90T2tWdUtUaE9BS0FudHpUY2JCaUs3cmorR0g0?=
 =?utf-8?B?MmRBb1ZEK29TQXIwOWFwWUxBN0czY0hZWDJCNHhvQ3lVL1ozbThpa2cyeGFx?=
 =?utf-8?B?Tm03b2lMbFBIZVQvYkhLeXRkbjFGcUl6M0ZSMmNHRFpaZGtYczloNHgvd3ho?=
 =?utf-8?B?NXRkcnNZVEJTc0Z2UjVROWZhR1ZrM2FZYlgyZGJ3c1FldThDMEJnbHEvZ0I0?=
 =?utf-8?B?MTMzWnNJODVobkRyYjZwRTdCVmJJdkFaWEVOME1ISkwzQnF1ZTVHVnpITWFV?=
 =?utf-8?B?RDVsZjg0YlhBbG5TdjQ3a2ZFZHdqTk1uL1phMFdNdXNyU014RnF0dVg3Rm1v?=
 =?utf-8?B?N3ZGQ3RiM2RIWURyZDRLRmdUWWJBazd4SEplU3haTXNHSlM4djhka0srZWZo?=
 =?utf-8?B?Qm9maHl0Y05Uc0FvT0VlRThyTUpMOGpnVUZDSUdheWw0ajJadTROdUZvSldj?=
 =?utf-8?B?NUU3YWljdU9pSHQyVVN4VXdYZzdHUy8vTVFwTXl6emxPckdMcVpBbEJ0MDBp?=
 =?utf-8?B?Tlhxdy9qWGNEa0lvY2ErQ2JUS2Y4UTEyVk9zeFNha0VCeXpqR3Y5Rkg3c2dF?=
 =?utf-8?B?ZXU2bmNyQlZZYThlTzRjcU16dEZQdTRwUUZ4Q1BVWDJQa0FKdFY3QVdDS3F5?=
 =?utf-8?B?R0ZqY2VuUmh0dDhkV3lhVmxhTzA4NFNKMW9tbmorOEs1K0JleEFhcXFnSGRk?=
 =?utf-8?B?NTNOTmNsSVB0bXhiQWRRc1BGOStOa0lJSHVrOXRzZmJ1MllGc1dIMERQcS9s?=
 =?utf-8?B?dGpWRUE2R3dLdHQwK0U4YXVkWkJ1K3NPZFNQU0ROZGtWTFFML3NNdGNSODJ3?=
 =?utf-8?B?QWM2T0FreWNyQzc2TWcxNVFtb3d5OUoxRXBlSmordmtxenR4K0w4Y2xvaWxC?=
 =?utf-8?B?K2FLeFNrYm9pVWhVbnZYUTFYSXpGK3FHd0NNUkQ3bGc2QW0yVDdXcktua2NB?=
 =?utf-8?B?RWp4dGRSMDZpZ014cGlIR2hnWEJZT1BtWVR4SXdCU3dQVUF4d0tIL29nV2Rs?=
 =?utf-8?B?emRUMysxWFg1bFBEbEttZEs4aDg2cU9ERHBiNWdzRS9tNDNxTWRCZUExbFk3?=
 =?utf-8?B?dUJYamZYOGoxM3hCaXV6elRadjRKbVZ2c1hJM2JhOVo1QWIwbWdOajhONEVv?=
 =?utf-8?B?RW56QUdmNkEyRUh3a3l0NWcwV2Zhd2Zrc2JQcUhtaTFHU0RvVG1oOVpKWks5?=
 =?utf-8?B?bkZmTDMrTEs3M0NEcU9xZkhqMXhkVHk2azhkY09KT2piYWxJSGpMSFJHVDdN?=
 =?utf-8?B?NUJGaFVucHhZbWpTL2tNa21WL3VuanFtRHZ1T2lKSnZtNUI3ek9YdzRsaE5I?=
 =?utf-8?B?STg3RUVnTkt0Y3BETlVseXE1eFRua0lJTW5DS0lLL2V4Tm1DYjFTWDZ5LzBS?=
 =?utf-8?B?YVNJcSs3RXIyOFA5Ym4xUXY4enVmaVVwQU1aZGVDSm1HOXhLT1pYVTlCU1hz?=
 =?utf-8?Q?SgnteJkAe/MShBcrQRebm6BiY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b4a683-5668-43ee-c901-08dccb1d2840
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 07:02:07.0506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3MwVyZyHXPriuBB1/S381yTYzenqMyKWljS3ao0xz6bf7ubvjFsY83I5+IXnKvgyuJLvnJA0vwR0BpbIGAW5Hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6453


On 8/28/2024 11:16 PM, Vinod Koul wrote:
> On 08-07-24, 20:14, Basavaraj Natikar wrote:
>> To support multi-channel functionality with AE4DMA engine, extend the
>> PTDMA code with reusable components.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>  drivers/dma/amd/ae4dma/ae4dma.h         |   2 +
>>  drivers/dma/amd/common/amd_dma.h        |   1 +
>>  drivers/dma/amd/ptdma/ptdma-dmaengine.c | 105 +++++++++++++++++++-----
>>  drivers/dma/amd/ptdma/ptdma.h           |   2 +
>>  4 files changed, 90 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
>> index a63525792080..5f9dab5f05f4 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma.h
>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>> @@ -24,6 +24,8 @@
>>  #define AE4_Q_BASE_H_OFF		0x1C
>>  #define AE4_Q_SZ			0x20
>>  
>> +#define AE4_DMA_VERSION			4
> Can it be driver data for the device?
> I am not seeing who sets this here?

This will be used in the functions below to
differentiate between PTDMA and AE4DMA functionality.
By default, without a version, it is PTDMA, and this
will be set in ae4_pci_probe in the next patch: 
https://lore.kernel.org/all/20240708144500.1523651-6-Basavaraj.Natikar@amd.com/#r.

>
>> +
>>  struct ae4_msix {
>>  	int msix_count;
>>  	struct msix_entry msix_entry[MAX_AE4_HW_QUEUES];
>> diff --git a/drivers/dma/amd/common/amd_dma.h b/drivers/dma/amd/common/amd_dma.h
>> index f9f396cd4371..396667e81e1a 100644
>> --- a/drivers/dma/amd/common/amd_dma.h
>> +++ b/drivers/dma/amd/common/amd_dma.h
>> @@ -21,6 +21,7 @@
>>  #include <linux/wait.h>
>>  
>>  #include "../ptdma/ptdma.h"
>> +#include "../ae4dma/ae4dma.h"
>>  #include "../../virt-dma.h"
>>  
>>  #endif
>> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> index 66ea10499643..90ca02fd5f8f 100644
>> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> @@ -43,7 +43,24 @@ static void pt_do_cleanup(struct virt_dma_desc *vd)
>>  	kmem_cache_free(pt->dma_desc_cache, desc);
>>  }
>>  
>> -static int pt_dma_start_desc(struct pt_dma_desc *desc)
>> +static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma_chan *chan)
>> +{
>> +	struct ae4_cmd_queue *ae4cmd_q;
>> +	struct pt_cmd_queue *cmd_q;
>> +	struct ae4_device *ae4;
>> +
>> +	if (pt->ver == AE4_DMA_VERSION) {
>> +		ae4 = container_of(pt, struct ae4_device, pt);
>> +		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
>> +		cmd_q = &ae4cmd_q->cmd_q;
>> +	} else {
>> +		cmd_q = &pt->cmd_q;
>> +	}
>> +
>> +	return cmd_q;
>> +}
>> +
>> +static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
>>  {
>>  	struct pt_passthru_engine *pt_engine;
>>  	struct pt_device *pt;
>> @@ -54,7 +71,9 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc)
>>  
>>  	pt_cmd = &desc->pt_cmd;
>>  	pt = pt_cmd->pt;
>> -	cmd_q = &pt->cmd_q;
>> +
>> +	cmd_q = pt_get_cmd_queue(pt, chan);
>> +
>>  	pt_engine = &pt_cmd->passthru;
>>  
>>  	pt->tdata.cmd = pt_cmd;
>> @@ -149,7 +168,7 @@ static void pt_cmd_callback(void *data, int err)
>>  		if (!desc)
>>  			break;
>>  
>> -		ret = pt_dma_start_desc(desc);
>> +		ret = pt_dma_start_desc(desc, chan);
>>  		if (!ret)
>>  			break;
>>  
>> @@ -184,7 +203,10 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>>  {
>>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>  	struct pt_passthru_engine *pt_engine;
>> +	struct pt_device *pt = chan->pt;
>> +	struct ae4_cmd_queue *ae4cmd_q;
>>  	struct pt_dma_desc *desc;
>> +	struct ae4_device *ae4;
>>  	struct pt_cmd *pt_cmd;
>>  
>>  	desc = pt_alloc_dma_desc(chan, flags);
>> @@ -192,7 +214,7 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>>  		return NULL;
>>  
>>  	pt_cmd = &desc->pt_cmd;
>> -	pt_cmd->pt = chan->pt;
>> +	pt_cmd->pt = pt;
>>  	pt_engine = &pt_cmd->passthru;
>>  	pt_cmd->engine = PT_ENGINE_PASSTHRU;
>>  	pt_engine->src_dma = src;
>> @@ -203,6 +225,14 @@ static struct pt_dma_desc *pt_create_desc(struct dma_chan *dma_chan,
>>  
>>  	desc->len = len;
>>  
>> +	if (pt->ver == AE4_DMA_VERSION) {
>> +		ae4 = container_of(pt, struct ae4_device, pt);
>> +		ae4cmd_q = &ae4->ae4cmd_q[chan->id];
>> +		mutex_lock(&ae4cmd_q->cmd_lock);
>> +		list_add_tail(&pt_cmd->entry, &ae4cmd_q->cmd);
>> +		mutex_unlock(&ae4cmd_q->cmd_lock);
>> +	}
>> +
>>  	return desc;
>>  }
>>  
>> @@ -260,8 +290,11 @@ static enum dma_status
>>  pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>>  		struct dma_tx_state *txstate)
>>  {
>> -	struct pt_device *pt = to_pt_chan(c)->pt;
>> -	struct pt_cmd_queue *cmd_q = &pt->cmd_q;
>> +	struct pt_dma_chan *chan = to_pt_chan(c);
>> +	struct pt_device *pt = chan->pt;
>> +	struct pt_cmd_queue *cmd_q;
>> +
>> +	cmd_q = pt_get_cmd_queue(pt, chan);
>>  
>>  	pt_check_status_trans(pt, cmd_q);
>>  	return dma_cookie_status(c, cookie, txstate);
>> @@ -270,10 +303,13 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>>  static int pt_pause(struct dma_chan *dma_chan)
>>  {
>>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>> +	struct pt_device *pt = chan->pt;
>> +	struct pt_cmd_queue *cmd_q;
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&chan->vc.lock, flags);
>> -	pt_stop_queue(&chan->pt->cmd_q);
>> +	cmd_q = pt_get_cmd_queue(pt, chan);
>> +	pt_stop_queue(cmd_q);
>>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>>  
>>  	return 0;
>> @@ -283,10 +319,13 @@ static int pt_resume(struct dma_chan *dma_chan)
>>  {
>>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>>  	struct pt_dma_desc *desc = NULL;
>> +	struct pt_device *pt = chan->pt;
>> +	struct pt_cmd_queue *cmd_q;
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&chan->vc.lock, flags);
>> -	pt_start_queue(&chan->pt->cmd_q);
>> +	cmd_q = pt_get_cmd_queue(pt, chan);
>> +	pt_start_queue(cmd_q);
>>  	desc = pt_next_dma_desc(chan);
>>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>>  
>> @@ -300,11 +339,17 @@ static int pt_resume(struct dma_chan *dma_chan)
>>  static int pt_terminate_all(struct dma_chan *dma_chan)
>>  {
>>  	struct pt_dma_chan *chan = to_pt_chan(dma_chan);
>> +	struct pt_device *pt = chan->pt;
>> +	struct pt_cmd_queue *cmd_q;
>>  	unsigned long flags;
>> -	struct pt_cmd_queue *cmd_q = &chan->pt->cmd_q;
>>  	LIST_HEAD(head);
>>  
>> -	iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
>> +	cmd_q = pt_get_cmd_queue(pt, chan);
>> +	if (pt->ver == AE4_DMA_VERSION)
>> +		pt_stop_queue(cmd_q);
>> +	else
>> +		iowrite32(SUPPORTED_INTERRUPTS, cmd_q->reg_control + 0x0010);
>> +
>>  	spin_lock_irqsave(&chan->vc.lock, flags);
>>  	vchan_get_all_descriptors(&chan->vc, &head);
>>  	spin_unlock_irqrestore(&chan->vc.lock, flags);
>> @@ -317,14 +362,24 @@ static int pt_terminate_all(struct dma_chan *dma_chan)
>>  
>>  int pt_dmaengine_register(struct pt_device *pt)
>>  {
>> -	struct pt_dma_chan *chan;
>>  	struct dma_device *dma_dev = &pt->dma_dev;
>> -	char *cmd_cache_name;
>> +	struct ae4_cmd_queue *ae4cmd_q = NULL;
>> +	struct ae4_device *ae4 = NULL;
>> +	struct pt_dma_chan *chan;
>>  	char *desc_cache_name;
>> -	int ret;
>> +	char *cmd_cache_name;
>> +	int ret, i;
>> +
>> +	if (pt->ver == AE4_DMA_VERSION)
>> +		ae4 = container_of(pt, struct ae4_device, pt);
>> +
>> +	if (ae4)
> in which case would ae4 be null but you are on version 4?

Yes correct, this will be used in the functions to differentiate
between PTDMA and AE4DMA functionality. By default, without a
version (i.e., null for PTDMA and 4 for AE4DMA).

Thanks,
--
Basavaraj

>
>> +		pt->pt_dma_chan = devm_kcalloc(pt->dev, ae4->cmd_q_count,
>> +					       sizeof(*pt->pt_dma_chan), GFP_KERNEL);
>> +	else
>> +		pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
>> +					       GFP_KERNEL);
>>  
>> -	pt->pt_dma_chan = devm_kzalloc(pt->dev, sizeof(*pt->pt_dma_chan),
>> -				       GFP_KERNEL);
>>  	if (!pt->pt_dma_chan)
>>  		return -ENOMEM;
>>  
>> @@ -366,9 +421,6 @@ int pt_dmaengine_register(struct pt_device *pt)
>>  
>>  	INIT_LIST_HEAD(&dma_dev->channels);
>>  
>> -	chan = pt->pt_dma_chan;
>> -	chan->pt = pt;
>> -
>>  	/* Set base and prep routines */
>>  	dma_dev->device_free_chan_resources = pt_free_chan_resources;
>>  	dma_dev->device_prep_dma_memcpy = pt_prep_dma_memcpy;
>> @@ -380,8 +432,21 @@ int pt_dmaengine_register(struct pt_device *pt)
>>  	dma_dev->device_terminate_all = pt_terminate_all;
>>  	dma_dev->device_synchronize = pt_synchronize;
>>  
>> -	chan->vc.desc_free = pt_do_cleanup;
>> -	vchan_init(&chan->vc, dma_dev);
>> +	if (ae4) {
>> +		for (i = 0; i < ae4->cmd_q_count; i++) {
>> +			chan = pt->pt_dma_chan + i;
>> +			ae4cmd_q = &ae4->ae4cmd_q[i];
>> +			chan->id = ae4cmd_q->id;
>> +			chan->pt = pt;
>> +			chan->vc.desc_free = pt_do_cleanup;
>> +			vchan_init(&chan->vc, dma_dev);
>> +		}
>> +	} else {
>> +		chan = pt->pt_dma_chan;
>> +		chan->pt = pt;
>> +		chan->vc.desc_free = pt_do_cleanup;
>> +		vchan_init(&chan->vc, dma_dev);
>> +	}
>>  
>>  	ret = dma_async_device_register(dma_dev);
>>  	if (ret)
>> diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
>> index 2690a32fc7cb..a6990021fe2b 100644
>> --- a/drivers/dma/amd/ptdma/ptdma.h
>> +++ b/drivers/dma/amd/ptdma/ptdma.h
>> @@ -184,6 +184,7 @@ struct pt_dma_desc {
>>  struct pt_dma_chan {
>>  	struct virt_dma_chan vc;
>>  	struct pt_device *pt;
>> +	u32 id;
>>  };
>>  
>>  struct pt_cmd_queue {
>> @@ -262,6 +263,7 @@ struct pt_device {
>>  	unsigned long total_interrupts;
>>  
>>  	struct pt_tasklet_data tdata;
>> +	int ver;
>>  };
>>  
>>  /*
>> -- 
>> 2.25.1


