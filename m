Return-Path: <dmaengine+bounces-3399-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 787AF9A9846
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 07:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34CFF283516
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2024 05:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4178584A52;
	Tue, 22 Oct 2024 05:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ah98Z8jh"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78E5A79B
	for <dmaengine@vger.kernel.org>; Tue, 22 Oct 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729574616; cv=fail; b=K9xM2x5/6Kp6Vm7eUoOlutAezEzTd61jBYP6+zbLY9FWzEqdRDWXLvc4a6Lvr/M72W0VMgMvevrS0yd0V+/bSa9wMmdESFkuY8n/5bNRGHtquAADjwwSkdMFXLWuFf3dgE8Gj/OtUT6ntADLyV47vxxtw3RbXx8bZoZfJZNeyxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729574616; c=relaxed/simple;
	bh=gtDfTByHhA44k/WJ8tfjapsQBVzTLgPrIMaXR/zcaak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=swecO5psUMTN7PiIHJoN8s2IwGafDQ4gZwi4zpZdXTtxM1z1lOnJHleG+HWr/cTk32ve7RyxwWjH3sLx9/ELF0k704w96EdXtm+ItYzadT+MU8sqiLZVb3SEs0cnotszYaZyy3KhXsTE8DHKzkvcvkfnvqbNwfxvFgWAMS+rwRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ah98Z8jh; arc=fail smtp.client-ip=40.107.96.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNvj+nI27UhV0p3PNr+GtferG3lyvO3WsPtwxRtYvtUPP4FSK01L/E7yDGNqFUnu6EWUSy6OEOTXJ5ScIQbGcO7aFCq74k7Ck7hfhOpkC2qnr5vMH2yKY7xyHvVrY7XYBDGqsSXQhCaYVV0bt6V1dRUntKlCbUiY71eIqZJiYMqRU0R5AKfXKhbeqfPk0WUEjiY9v22z9iGYgP1YZk/UNm3alksWT5IlfHMf8/9XbwRwemTgi+VGAQM4vVWKaG6STntCMtsdv8TO3Vau7mU9FIRpIIX/7C516cMoa3VEVm3Jff3lLLd5jnm4TwpwDZU0fsRdN3FyNk/itymk+e+jXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xe+10YToKOQR+/OIuZocQZDbLGyYdqjjUQd1ifz2noA=;
 b=Oyta/B/vo3UFaQMYL8yjEREkwKArIlfbr9tdc4ffLXkQMjwCjGRUWB2TeF3zHiXTRgxVlVpoaWTiM7HII71S5VuGLyntMqm4Q2D1Ph2nVnyigmaF5PIrfpMwD4DJZA1ABkInjT7oFLhaeJfKojkHPNsfMTwhvn2oGEwrnho/yQ3YO/YZ8cFMAHSITEEbtVbjfFWqOQq86YAVfBkQ+yPEsA4WPDeM49LaTKznFP39G1HmAQV+Ntai3pQQKCDcwrpb0JWl/AYCwI+qrH53jtN4lQtThofmGKADMxON1Xa59iqw8dz7RAtIfSFz4Vk6EAgyI+gHXCpUFMIZ+irxkmrtig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xe+10YToKOQR+/OIuZocQZDbLGyYdqjjUQd1ifz2noA=;
 b=ah98Z8jhG8nuReq8059ufNeE2l1V/uuE6yYxqmYBv5zIMK5CMJ3LFNWoI1Xcex/stnWtciVlffN1bHxtq9/ujzvOxGf2EdBzNcNSYdSwv7MtU9hdNoFmjKq2gEe4UB5GJBYpe9jb6Dr7RXwewYjgQf6iS1i1J+UYQZ4/odnr1Ao=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 05:23:31 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::a3dc:7ea1:9cc7:ce0f%6]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 05:23:31 +0000
Message-ID: <549a5919-117a-d96f-a00b-391ed142dc91@amd.com>
Date: Tue, 22 Oct 2024 10:53:23 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 4/6] dmaengine: ae4dma: Register AE4DMA using
 pt_dmaengine_register
To: Vinod Koul <vkoul@kernel.org>,
 Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc: dmaengine@vger.kernel.org, Raju.Rangoju@amd.com, Frank.li@nxp.com,
 helgaas@kernel.org, pstanner@redhat.com
References: <20240909123941.794563-1-Basavaraj.Natikar@amd.com>
 <20240909123941.794563-5-Basavaraj.Natikar@amd.com> <ZxaQMP8b0Dfk96aa@vaman>
Content-Language: en-US
From: Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <ZxaQMP8b0Dfk96aa@vaman>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: ae603a34-9e3d-42e9-9b1f-08dcf259aa9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEpSb2xLU1dzQXF2ODVMY2ZRenVON3Bud2lYN2REd2dwWFJIQ1R3ZXBLeWxM?=
 =?utf-8?B?eFNYVVBtMjNmbWRUdks4aDJqM3c5bUJoZDM1WklBNVAwQkMzNFRGdC80UHZq?=
 =?utf-8?B?MzRjdkhXeis5SjNiSGhhUVRLa1ZmQ2NNbjN1WVhISkR3Q1RkUFlISDN3LzFr?=
 =?utf-8?B?SWxTcWVBZmZmMVRRcm5hd3czdU1OMklKci9IU0w3Y3ZYU1hXaUdFbDgyMU9h?=
 =?utf-8?B?M2gvM2ZFajRBVEdRVmdZckJiQ0d3QU9FN0h0eWV0c1paUW9pQjQwWFhzN2Ex?=
 =?utf-8?B?WTlpR3ZZY0tjNGtxQVhBb09STGJRZmtlREw3T1hzVnpHNUM1a3BPYkRnQXgx?=
 =?utf-8?B?dU05aXVwSGlTaUJ6UW5XWUF6ZmhseC9YMjhweFVaSkdEOXlDMFA4M2VqNHA5?=
 =?utf-8?B?KzcvaG5XUE1ZQ0FqZHN0elFxZWQwZnlQR1g3UmhyazZMek8rNm5za3lKelM1?=
 =?utf-8?B?SU1zazdkTEtHT1pSaDA5U0paTUY4MXloQ0g4VG03cmovb2tXNnpzaGNjN20y?=
 =?utf-8?B?d1RVRTJnaU82K0dvZzdDNW5FeS9hektya0Jlc3MxdW10NFo2ang5K0YwT3hE?=
 =?utf-8?B?aGVHQWJrRDFnVDk4Qjl6czliWnBBZXZtc3QzVzgwaUhzUnRiai8wOFFhR2ZF?=
 =?utf-8?B?amJEUFZTL0wwZDFZTWIzVTJVck5pNlNUcXpldmxjMDl5S0JrQXpaUnV6WjVp?=
 =?utf-8?B?NWlOS2dUOTltUUlqdmxSMS9kOE5tR1I2NzdvNnF4M0dHemRsaFY0ZkpVU2dU?=
 =?utf-8?B?WUFNWWFuNHIrTEdZaWJNOXZ3SE1nbDhXNzc4NU40dFFkWDB4YWt2U1cxVzRB?=
 =?utf-8?B?M1JaSDVDeGxyL2U3ai8xV1hNblgxVGlVczdqRHpLSW1JSEF3c0pxSFdiRGxz?=
 =?utf-8?B?NnFWL1h6NlNQUisxcU5Pcm00b2gvTjhhNlNmNTJnSUdiU2pIN0pIeHVHZURW?=
 =?utf-8?B?UWN6ZHdNTktYNmdXT0p1SDVDNFpmRnRTd2srTFA0b1JTZklBVjRCZUg3NC9Z?=
 =?utf-8?B?MjRhRUZJWU9CMmZSQnN1bllrd0QxTU1MTEEzR1c2YTNlYzZmUzA3ZXozRFE4?=
 =?utf-8?B?bjNsb09kQ3dqcUJEWjRzcitQaDhDWDdEUmkvWlhUME5GR1R0NWc1bFRxZkdL?=
 =?utf-8?B?ME9GQkpubEpkQjA0OGpiWHBLMGYwUTQrcGxpWkI5RzJKNytRWmZQZUlmWVMy?=
 =?utf-8?B?VzluRzEySHdZQTlWdCtMcTBaY1hOdmFhNGJHVlZuL0QvWXhoczZGNU53enNk?=
 =?utf-8?B?eHRQWmYwVUlUY0tqcnlPNnloQXBGb1p5T2hrbnNOOWFlWnlqeVMzNjY4N1lo?=
 =?utf-8?B?MUdDdFUraWQrbk04TFYwc0ZlSzVySEJXMHJvWFNyZGRoU1hzak1JMHlOWGhY?=
 =?utf-8?B?RVVnQlRxbHRSdTlMUFpudHlTRUVudkhsZ0RLLzRVa0VtcGV3Z2Y1ZTZSMVo4?=
 =?utf-8?B?Vm4vVEtNd3NrTGloV1R4ZVplanBpWHJNa0kvN2huamtUU2Q5QjZiS3VGM3VL?=
 =?utf-8?B?dFBzZy85emc2REowSVdsaG4xanM4aUJaMjBUcXMzekdDU29WUmc1UnROSXcy?=
 =?utf-8?B?OXdneml2dDVFUVpoMHdJZC9wZ0NDUEJSN1JLaEZEODM1bGdOQkhNOEhlWG96?=
 =?utf-8?B?UDJKZHQ4OVNEeHo4QUdSeUVwcEpOZ0ZKaHZmU1dDeHZuaE9XUENKMFVObjBV?=
 =?utf-8?B?ZUF2N0tMdXNIUFB0dHNDOWs2d1NVNDM5a0FvOFB3Y1Q3YXJzaGlKMXNrMTZw?=
 =?utf-8?Q?CZXQXAWwlwP5HMpkCY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S09MTnBNblpwUE1GaEJjYVJVelZZaCs1M21sNVM5Z3FnUzBPRFRGUzJqUktO?=
 =?utf-8?B?S2cyajFUK3NUaGdGQ3ZzeW1OdjVkNzVDUGRtc0lqVFJ1bHFCaE9jYnErM1lK?=
 =?utf-8?B?bnVod3hndFVnVmhaZFFDWEtaRnpHbWJtaE50RFNFbmFZUG1QbkFrQ0xYVjk5?=
 =?utf-8?B?QzVCRFUxTXlyWlltWnA2VDZlWE9MTlI3N054blNUZWQvZWc0L2ZYblZPVS9m?=
 =?utf-8?B?eDh3UnlTZzJpaTc1ZXFmeCtpcmNoV1ZrWERuM0kvZEdUVmNDWEhCbzB4T0Er?=
 =?utf-8?B?dDVnSkNoRjE0ZEl5N2pZY0NHOXZTbnVwcDd3T0N5Y2llaFU1TUtZQ1lFYnp4?=
 =?utf-8?B?ek90TitJTW5WOENCK0pBMmM2MWlkYmtjbXBZWTZwQ1RCejkzaFdzOWFac2xq?=
 =?utf-8?B?TlN0YXZKdUpwQlZzckJDQzhvYWRPVi9BcisyQWJrd2x5WEE0TlFKK2did0p1?=
 =?utf-8?B?bGgxNU9oVmpuTm44OHplWjN4cVlScEFBZG9UQlM5dmFERlVSdytQTmt1YVZv?=
 =?utf-8?B?WUFjYVo3dG12R245bHhNcHBqK0pnM3NGRklka1RvM0huQ3k5UHI3QlBLQWh6?=
 =?utf-8?B?Q3lJOWw3ajFJLzNjTjJpR1VjOU5oNjZ3ZGxjUERKVlJSNUtacFBKZ0xrcmdJ?=
 =?utf-8?B?b1lQaTBodDVRUWNHV2dSdHVHUUtjdWlhSXZpQXlvQi9lR0hCS0NpL3RybS83?=
 =?utf-8?B?L0FQTzFFRXgxMGZuQlgrUGVSTUZ3cU84RE5yb3hHTTNnRkpMenNoazMzQ1VX?=
 =?utf-8?B?d1F4UjBXdWx0YzlUSzVTb2VwSk5iQlB3RmV6eWxyMWVISVJMOUFnK1JHb1Zx?=
 =?utf-8?B?TVNDSG1YTGx6MisrV2VMcXg0UzMya0VxcXNhd2tzQWptMzd1TzFra1cxQVZy?=
 =?utf-8?B?TVVkOXFMTk5nU1NtQys5U1pIMUNSbTc2QWY2QjA3TFpTeTZHNGYxWXlUdnJa?=
 =?utf-8?B?WjZVQWlFWFNnVlV3NkJxSTVHcUY1TkpXTHEvQ1RZbWV2a2VUOVdoZ2NtVHJz?=
 =?utf-8?B?MjJLU01LNktEaFBoZFBXK3dIYmdzN3hsUUgwZzdVZnpKSzhENXlhcnpxeDhh?=
 =?utf-8?B?c2QvQUNrZWg0enpDam1YMFFPWXNPTjF0emFzaFhkV0tzS3lLa3FYbWNwdDFW?=
 =?utf-8?B?TmtodGxtR3BVOTF6ckUvY2lqU3NYY3ViYmZVWTRBV0ZJaW04RTlPNC96TGI5?=
 =?utf-8?B?aUErdHNteGttSVQ0Y05JQy9iQWtLbVpOTUhlbmRlU1JFNkdjN09yUENjNDFF?=
 =?utf-8?B?WFVtVE05YkhPNGg0SFFFWENXNmlpZGhCSERCZllBQ2JsRXp3cmpBeE9wMkpY?=
 =?utf-8?B?THZVWDVvU3R0RTYzZzBaaHBNYW1wWUtVZk5wdFk0WUROZ1MxZ2RNN0drM3pL?=
 =?utf-8?B?bUIrQzY1SW9IQ3NEYnI1dlpCa2FYZDRySGRvd1I3NEZrTlVPWW5DSStkY0Ir?=
 =?utf-8?B?VVR4TmVZV21BYVg4TEVta3l4OWNGdTlrYTRuUUZ5UHU0UjExU0xjdWEzejlP?=
 =?utf-8?B?dkpZMkF4RThRVlRpQUliN3h3ZVhGamhNOG9nQVIwV1pFaTVXeVpRNlhUS2U1?=
 =?utf-8?B?YWNpVThtcHVHbjkvMitPTFVXT3hZZXJwc3Z5a0RtRFBrMy9tRDRGNXlWS0VG?=
 =?utf-8?B?d1MxcEVSd2dlYURlaHlHZm4xbUp5SWp0UUY0M3BQUTR4SlZjWHdCSVRyRDM0?=
 =?utf-8?B?bW1qeDBFaTBlYWUxNC9sYnZPRjN4clZxeG5sUjBKenhabjN1bmtQTUNiU2s4?=
 =?utf-8?B?OWVTTUErM1NSejhkeUYxTzE2WDNERExxTHVNZ1ZIZEdaSEhDSmhSWEdrOExV?=
 =?utf-8?B?VXJiWERyZVJLaUpDVUROQkN1djNzWDlkNHc3MUV1RUV3QkJ3dVZscXp3YkdN?=
 =?utf-8?B?SFdJRE1iL0ZXdGJKTWI3Qk9GdXR0b1R1OW92T1F6RWVIbFdPK1ZldFRjTFRt?=
 =?utf-8?B?KzROTWdrek9zZ2lBc3hHNmUvOWpta2JUV1NRYUVMY092dU1VMXh5UkxUcjdT?=
 =?utf-8?B?T2puREUvWVhlL3FORFhoTUJZOVdjbVhlOUVSdHlUS1hiSCtLUllud25ZV1Z5?=
 =?utf-8?B?VGVKWHUzbVNhZjhEN0t2a2VmKzFON0lzR1JrSEpRQVI3cTIxYXU2R0lzY00r?=
 =?utf-8?Q?8Mr0xN9DGNqD8z99rddznmZ3w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae603a34-9e3d-42e9-9b1f-08dcf259aa9e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 05:23:31.4632
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwazGlQ4Jk6GAb2urgLigg0/4FzW3zPs8eHxMN2Ap7qYVPlpLuOyXPB1ADQdjCVdBArz4Qf7eiVf6regI+KFvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419


On 10/21/2024 11:02 PM, Vinod Koul wrote:
> On 09-09-24, 18:09, Basavaraj Natikar wrote:
>> Use the pt_dmaengine_register function to register a AE4DMA DMA engine.
>>
>> Reviewed-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> Reviewed-by: Philipp Stanner <pstanner@redhat.com>
>> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
>> ---
>>   drivers/dma/amd/ae4dma/ae4dma-dev.c     |  51 +----------
>>   drivers/dma/amd/ae4dma/ae4dma-pci.c     |   1 +
>>   drivers/dma/amd/ae4dma/ae4dma.h         |   3 +
>>   drivers/dma/amd/ptdma/ptdma-dmaengine.c | 114 +++++++++++++++++++++++-
>>   drivers/dma/amd/ptdma/ptdma.h           |   3 +
>>   5 files changed, 123 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-dev.c b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> index f0b3a3763adc..cd84b502265e 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-dev.c
>> @@ -14,53 +14,6 @@ static unsigned int max_hw_q = 1;
>>   module_param(max_hw_q, uint, 0444);
>>   MODULE_PARM_DESC(max_hw_q, "max hw queues supported by engine (any non-zero value, default: 1)");
>>   
>> -static char *ae4_error_codes[] = {
>> -	"",
>> -	"ERR 01: INVALID HEADER DW0",
>> -	"ERR 02: INVALID STATUS",
>> -	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
>> -	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
>> -	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
>> -	"ERR 06: INVALID ALIGNMENT",
>> -	"ERR 07: INVALID DESCRIPTOR",
>> -};
>> -
>> -static void ae4_log_error(struct pt_device *d, int e)
>> -{
>> -	/* ERR 01 - 07 represents Invalid AE4 errors */
>> -	if (e <= 7)
>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
>> -	/* ERR 08 - 15 represents Invalid Descriptor errors */
>> -	else if (e > 7 && e <= 15)
>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>> -	/* ERR 16 - 31 represents Firmware errors */
>> -	else if (e > 15 && e <= 31)
>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
>> -	/* ERR 32 - 63 represents Fatal errors */
>> -	else if (e > 31 && e <= 63)
>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
>> -	/* ERR 64 - 255 represents PTE errors */
>> -	else if (e > 63 && e <= 255)
>> -		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>> -	else
>> -		dev_info(d->dev, "Unknown AE4DMA error");
>> -}
>> -
>> -static void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
>> -{
>> -	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> -	struct ae4dma_desc desc;
>> -	u8 status;
>> -
>> -	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
>> -	status = desc.dw1.status;
>> -	if (status && status != AE4_DESC_COMPLETED) {
>> -		cmd_q->cmd_error = desc.dw1.err_code;
>> -		if (cmd_q->cmd_error)
>> -			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
>> -	}
>> -}
> why is this getting moved?

To avoid circular dependency between PTDMA and AE4DMA, we are reusing PTDMA code to prevent
duplication, as AE4DMA depends on PTDMA.

Thanks,
--
Basavaraj

>
>> -
>>   static void ae4_pending_work(struct work_struct *work)
>>   {
>>   	struct ae4_cmd_queue *ae4cmd_q = container_of(work, struct ae4_cmd_queue, p_work.work);
>> @@ -194,5 +147,9 @@ int ae4_core_init(struct ae4_device *ae4)
>>   		init_completion(&ae4cmd_q->cmp);
>>   	}
>>   
>> +	ret = pt_dmaengine_register(pt);
>> +	if (ret)
>> +		ae4_destroy_work(ae4);
>> +
>>   	return ret;
>>   }
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma-pci.c b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> index 43d36e9d1efb..aad0dc4294a3 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> +++ b/drivers/dma/amd/ae4dma/ae4dma-pci.c
>> @@ -98,6 +98,7 @@ static int ae4_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	pt = &ae4->pt;
>>   	pt->dev = dev;
>> +	pt->ver = AE4_DMA_VERSION;
>>   
>>   	pt->io_regs = pcim_iomap_table(pdev)[0];
>>   	if (!pt->io_regs) {
>> diff --git a/drivers/dma/amd/ae4dma/ae4dma.h b/drivers/dma/amd/ae4dma/ae4dma.h
>> index 666bc76735cf..265c5d436008 100644
>> --- a/drivers/dma/amd/ae4dma/ae4dma.h
>> +++ b/drivers/dma/amd/ae4dma/ae4dma.h
>> @@ -35,6 +35,7 @@
>>   #define AE4_Q_SZ			0x20
>>   
>>   #define AE4_DMA_VERSION			4
>> +#define CMD_AE4_DESC_DW0_VAL		2
>>   
>>   struct ae4_msix {
>>   	int msix_count;
>> @@ -55,6 +56,7 @@ struct ae4_cmd_queue {
>>   	atomic64_t done_cnt;
>>   	u64 q_cmd_count;
>>   	u32 dridx;
>> +	u32 tail_wi;
>>   	u32 id;
>>   };
>>   
>> @@ -94,4 +96,5 @@ struct ae4_device {
>>   
>>   int ae4_core_init(struct ae4_device *ae4);
>>   void ae4_destroy_work(struct ae4_device *ae4);
>> +void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx);
>>   #endif
>> diff --git a/drivers/dma/amd/ptdma/ptdma-dmaengine.c b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> index 3f1dc858a914..cfc60cf571c2 100644
>> --- a/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> +++ b/drivers/dma/amd/ptdma/ptdma-dmaengine.c
>> @@ -13,6 +13,17 @@
>>   #include "../ae4dma/ae4dma.h"
>>   #include "../../dmaengine.h"
>>   
>> +static char *ae4_error_codes[] = {
>> +	"",
>> +	"ERR 01: INVALID HEADER DW0",
>> +	"ERR 02: INVALID STATUS",
>> +	"ERR 03: INVALID LENGTH - 4 BYTE ALIGNMENT",
>> +	"ERR 04: INVALID SRC ADDR - 4 BYTE ALIGNMENT",
>> +	"ERR 05: INVALID DST ADDR - 4 BYTE ALIGNMENT",
>> +	"ERR 06: INVALID ALIGNMENT",
>> +	"ERR 07: INVALID DESCRIPTOR",
>> +};
>> +
>>   static inline struct pt_dma_chan *to_pt_chan(struct dma_chan *dma_chan)
>>   {
>>   	return container_of(dma_chan, struct pt_dma_chan, vc.chan);
>> @@ -62,6 +73,52 @@ static struct pt_cmd_queue *pt_get_cmd_queue(struct pt_device *pt, struct pt_dma
>>   	return cmd_q;
>>   }
>>   
>> +static int ae4_core_execute_cmd(struct ae4dma_desc *desc, struct ae4_cmd_queue *ae4cmd_q)
>> +{
>> +	bool soc = FIELD_GET(DWORD0_SOC, desc->dwouv.dw0);
>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> +
>> +	if (soc) {
>> +		desc->dwouv.dw0 |= FIELD_PREP(DWORD0_IOC, desc->dwouv.dw0);
>> +		desc->dwouv.dw0 &= ~DWORD0_SOC;
>> +	}
>> +
>> +	mutex_lock(&ae4cmd_q->cmd_lock);
>> +	memcpy(&cmd_q->qbase[ae4cmd_q->tail_wi], desc, sizeof(struct ae4dma_desc));
>> +	ae4cmd_q->q_cmd_count++;
>> +	ae4cmd_q->tail_wi = (ae4cmd_q->tail_wi + 1) % CMD_Q_LEN;
>> +	writel(ae4cmd_q->tail_wi, cmd_q->reg_control + AE4_WR_IDX_OFF);
>> +	mutex_unlock(&ae4cmd_q->cmd_lock);
>> +
>> +	wake_up(&ae4cmd_q->q_w);
>> +
>> +	return 0;
>> +}
>> +
>> +int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine)
>> +{
>> +	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
>> +	struct ae4dma_desc desc;
>> +
>> +	cmd_q->cmd_error = 0;
>> +	cmd_q->total_pt_ops++;
>> +	memset(&desc, 0, sizeof(desc));
>> +	desc.dwouv.dws.byte0 = CMD_AE4_DESC_DW0_VAL;
>> +
>> +	desc.dw1.status = 0;
>> +	desc.dw1.err_code = 0;
>> +	desc.dw1.desc_id = 0;
>> +
>> +	desc.length = pt_engine->src_len;
>> +
>> +	desc.src_lo = upper_32_bits(pt_engine->src_dma);
>> +	desc.src_hi = lower_32_bits(pt_engine->src_dma);
>> +	desc.dst_lo = upper_32_bits(pt_engine->dst_dma);
>> +	desc.dst_hi = lower_32_bits(pt_engine->dst_dma);
>> +
>> +	return ae4_core_execute_cmd(&desc, ae4cmd_q);
>> +}
>> +
>>   static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
>>   {
>>   	struct pt_passthru_engine *pt_engine;
>> @@ -81,7 +138,10 @@ static int pt_dma_start_desc(struct pt_dma_desc *desc, struct pt_dma_chan *chan)
>>   	pt->tdata.cmd = pt_cmd;
>>   
>>   	/* Execute the command */
>> -	pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
>> +	if (pt->ver == AE4_DMA_VERSION)
>> +		pt_cmd->ret = pt_core_perform_passthru_ae4(cmd_q, pt_engine);
>> +	else
>> +		pt_cmd->ret = pt_core_perform_passthru(cmd_q, pt_engine);
>>   
>>   	return 0;
>>   }
>> @@ -288,6 +348,52 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
>>   		pt_cmd_callback(desc, 0);
>>   }
>>   
>> +static void ae4_log_error(struct pt_device *d, int e)
>> +{
>> +	/* ERR 01 - 07 represents Invalid AE4 errors */
>> +	if (e <= 7)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", ae4_error_codes[e], e);
>> +	/* ERR 08 - 15 represents Invalid Descriptor errors */
>> +	else if (e > 7 && e <= 15)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "INVALID DESCRIPTOR", e);
>> +	/* ERR 16 - 31 represents Firmware errors */
>> +	else if (e > 15 && e <= 31)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FIRMWARE ERROR", e);
>> +	/* ERR 32 - 63 represents Fatal errors */
>> +	else if (e > 31 && e <= 63)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "FATAL ERROR", e);
>> +	/* ERR 64 - 255 represents PTE errors */
>> +	else if (e > 63 && e <= 255)
>> +		dev_info(d->dev, "AE4DMA error: %s (0x%x)\n", "PTE ERROR", e);
>> +	else
>> +		dev_info(d->dev, "Unknown AE4DMA error");
>> +}
>> +
>> +void ae4_check_status_error(struct ae4_cmd_queue *ae4cmd_q, int idx)
>> +{
>> +	struct pt_cmd_queue *cmd_q = &ae4cmd_q->cmd_q;
>> +	struct ae4dma_desc desc;
>> +	u8 status;
>> +
>> +	memcpy(&desc, &cmd_q->qbase[idx], sizeof(struct ae4dma_desc));
>> +	status = desc.dw1.status;
>> +	if (status && status != AE4_DESC_COMPLETED) {
>> +		cmd_q->cmd_error = desc.dw1.err_code;
>> +		if (cmd_q->cmd_error)
>> +			ae4_log_error(cmd_q->pt, cmd_q->cmd_error);
>> +	}
>> +}
>> +EXPORT_SYMBOL_GPL(ae4_check_status_error);
>> +
>> +void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q)
>> +{
>> +	struct ae4_cmd_queue *ae4cmd_q = container_of(cmd_q, struct ae4_cmd_queue, cmd_q);
>> +	int i;
>> +
>> +	for (i = 0; i < CMD_Q_LEN; i++)
>> +		ae4_check_status_error(ae4cmd_q, i);
>> +}
>> +
>>   static enum dma_status
>>   pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>>   		struct dma_tx_state *txstate)
>> @@ -298,7 +404,10 @@ pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
>>   
>>   	cmd_q = pt_get_cmd_queue(pt, chan);
>>   
>> -	pt_check_status_trans(pt, cmd_q);
>> +	if (pt->ver == AE4_DMA_VERSION)
>> +		pt_check_status_trans_ae4(pt, cmd_q);
>> +	else
>> +		pt_check_status_trans(pt, cmd_q);
>>   	return dma_cookie_status(c, cookie, txstate);
>>   }
>>   
>> @@ -464,6 +573,7 @@ int pt_dmaengine_register(struct pt_device *pt)
>>   
>>   	return ret;
>>   }
>> +EXPORT_SYMBOL_GPL(pt_dmaengine_register);
>>   
>>   void pt_dmaengine_unregister(struct pt_device *pt)
>>   {
>> diff --git a/drivers/dma/amd/ptdma/ptdma.h b/drivers/dma/amd/ptdma/ptdma.h
>> index a6990021fe2b..9d311eef50c2 100644
>> --- a/drivers/dma/amd/ptdma/ptdma.h
>> +++ b/drivers/dma/amd/ptdma/ptdma.h
>> @@ -336,4 +336,7 @@ static inline void pt_core_enable_queue_interrupts(struct pt_device *pt)
>>   {
>>   	iowrite32(SUPPORTED_INTERRUPTS, pt->cmd_q.reg_control + 0x000C);
>>   }
>> +
>> +int pt_core_perform_passthru_ae4(struct pt_cmd_queue *cmd_q, struct pt_passthru_engine *pt_engine);
>> +void pt_check_status_trans_ae4(struct pt_device *pt, struct pt_cmd_queue *cmd_q);
>>   #endif
>> -- 
>> 2.25.1


