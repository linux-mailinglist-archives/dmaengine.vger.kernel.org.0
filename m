Return-Path: <dmaengine+bounces-3666-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9E89B830F
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 20:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A90D282D62
	for <lists+dmaengine@lfdr.de>; Thu, 31 Oct 2024 19:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF691C1AC9;
	Thu, 31 Oct 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="CoyWAodx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA71C9EBC;
	Thu, 31 Oct 2024 19:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730401570; cv=fail; b=eE0Yk9Rn+a2avWJiLZKg3XuEkww2HhBh6iKszTvTzyh6CSSzomiXI1aDNaxYrt2uq+eehqgrzzeQKsjlf8CdnJbQrHm86iRTtM39OZq1nLtvic5CTZWFV1Qg+e4Ftbn+PMAXzCfMcEYzGOd3YXvmh3d0582UVKtrODMVJXxdMzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730401570; c=relaxed/simple;
	bh=QIwKb6mU2O1bQ/fx4s0p3eUOr5+9WaKZzqB8DuklbV4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OYXQbAZPD0h3Eef2fKJu76odurv48XWKs96YtJOwuHofcqelpMIkpBmuAxafl9cgV9ncYh8c/us7vWYf5qBjiEU7cX7uf/7dKrOsWzjliD1FDCyrb4pM5RJsxb7fpmveKx9VCoWZ5+62U5pKG89QO5mjCCSMWxWUz1aAQjj0Vq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=CoyWAodx; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VALrWJ020980;
	Thu, 31 Oct 2024 12:05:39 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 42m4931jhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 31 Oct 2024 12:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VGzYvn2ERfBzEA5Ti8GAP/67FceuXriTCbanuaOX+qruSE6y2o5p0KRFcsrnAMTtMTq8biV5ERlICuGIsyp+bQ4+tZyaUaefaGKeMFNoeY3lcOwgtB98rCcn5EmyFbwm6ncQf0fyHxfG9JqTMy3hc5RqorxrXbxKBN5agDccUzlt68itsHA3r/TA2ZWeH+NOQ/3sE8HlFdqtISSReBN41psBM4pHESeYgGJh8o6AXIfze51nQnBbxh1onAYFdNivzOR2CBQQJ2hITAEF0JPLFDbL3iBKeTLf71nce2N1F3Gq7xo/c18FaaLdeoMAgpgC/CHMCm+5HxuKKut+HX0iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhrHkzQK0PoDwRjYdSOWc5Wlv8mufoOff5OG3NGfKOc=;
 b=uUFzxefIKk5/EuTn0+JeTVoLlX1bcJqtWIczqgwsZBHxd42vaFYacQA8xY+NkrBkrDiXZtKqbRIRMhqLOWfY1UW81vgzS35nTvaZGRrbtZj8NGdnDzB96/TlhQXlxitnP5InRY5ePzJCxstxU50A+QPh8MHm9nCxN2Xlp7Tgq2UlOMZzcPqOCSx0jpUVbcyjLNllf3Cr6TZRpgXIhsmEoygF9iQMzMa6dm6ooelaY9f5ScbylEG3u8Ye76LQ3EQpUwpgT3bWwyOk9/qgCsh3OOFH7E1wchLF+USz1AmnEAOo7ckKbh7U1qS4rI3ySf8t3i5Nr0tAhETGUq8JLZy4SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhrHkzQK0PoDwRjYdSOWc5Wlv8mufoOff5OG3NGfKOc=;
 b=CoyWAodxv9SdpfZd/RdEbOzvxwPPIhrMZUmtYJ+MW5YXOr0BtYAUU64st/Ns5VBANhjCSdpkG3ANBxi3tzDE3jNzePQJA94O69cWBEM+O+t5tNA5fMOrKbNIFvV1AjfYYa7SDp7O1UVQhZGcTZ0wJkqZ495WdVrQMm5GRh//bwY=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by SJ2PR18MB5561.namprd18.prod.outlook.com (2603:10b6:a03:560::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.24; Thu, 31 Oct
 2024 19:05:36 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 19:05:36 +0000
Message-ID: <53df7ebb-d6bf-4b34-98b6-442fdbd5d348@marvell.com>
Date: Fri, 1 Nov 2024 00:35:46 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 04/10] dma-engine: sun4i: Add support for Allwinner suniv
 F1C100s
To: =?UTF-8?B?Q3PDs2vDoXMsIEJlbmNl?= <csokas.bence@prolan.hu>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Cc: Mesih Kilinc <mesihkilinc@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
References: <20241031123538.2582675-1-csokas.bence@prolan.hu>
 <20241031123538.2582675-4-csokas.bence@prolan.hu>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20241031123538.2582675-4-csokas.bence@prolan.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::20) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|SJ2PR18MB5561:EE_
X-MS-Office365-Filtering-Correlation-Id: 44ea70d9-20b3-49f0-ebca-08dcf9df004b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGIwN29ISGdXWFFSTjU1ZGJBcWU3ZklDdU90UVdwQ3FuVnh1em4rb25tenlj?=
 =?utf-8?B?VlFsclBkTEJyV3RsMXNYLzR0czNhTXVVSWo0ZitXMnhtdDc4SmduaUtLT0hM?=
 =?utf-8?B?dTh6REoyT3NSQmhoL2FQSlZPZUpuVUw2T2NrNERoaEF5K0JxcmdWNlYxMFo3?=
 =?utf-8?B?Vm9IYWhGVW5XRGlMWkNaNlROcHFVV1RrUTF3T2RFN2MwZExvMnJwdWtSQXJV?=
 =?utf-8?B?bmJ0OHArdzU1ZGJBeEViVVhYZ0duQkxWb1lodkVobzVpamt0WXhuWUMwemlN?=
 =?utf-8?B?NHN1cUo1ZmFWOFYzSm5ubUtIN3JRL0tiWDV5cWVrQjVENDdOa0g0L0ZtK2Zi?=
 =?utf-8?B?QXV0SXBUQU1IOHJQTGdaUFdlcHhhZU5CK0tybWEwaWcvYVBFZTVxZm9QTit4?=
 =?utf-8?B?NGlwS0V4bDNFdlpPTFVyZ2FVcDlXeGlEOU9LUVVvdTBVa3Y3Yisrc2lwTEdy?=
 =?utf-8?B?UUgya3dMbXh2MFJMQkM2c1V6a0dpL3p0cTVYS1lvR0RhZEhmVzJESzNzYXJX?=
 =?utf-8?B?MVYrNWZpQUk5ZTk2NmdDblNKSy9BODZtWXhxSGc1WWE5VnkxOXN0WUVkQU94?=
 =?utf-8?B?WEN2OGJmOCsyN0t2MExPdHFBZGVVT1NZVHY1c0kvVVZtejlXbnZYc2hJb1VK?=
 =?utf-8?B?OS9vS21kdmUvaFBUMXJRb1RyYy9LVVFKSnBRYmh1MkpWL0xRdzlwMW1jeUY4?=
 =?utf-8?B?WHlpdm1qaVNpU1dHWWFIVWRoUVlkUnUwVFhGdE9HZTlybm1mMnd5VFh6cmZt?=
 =?utf-8?B?QjBHNndiRnk3TFJTMEZWcjVPM2lJWWVIYzBOQW5kS1c3SWtaeHVxUHlhQWlC?=
 =?utf-8?B?eXpyWXVidXUvUmxNNEVRWXczakkxVzBWQWdhbFdrT29CTjJVOTlsU1lSU29o?=
 =?utf-8?B?YkJmcXcwdjdsNlQ1WHZXSGxYdmFOZ3UzTU96cjYzM29Tb0EyL3NoZlVXdEZI?=
 =?utf-8?B?Y3dVc0NCMnM0OUx1eG5ndy9tazVsNmN5VFpzZ245ZWlrWHJOcmZxR3luTTJk?=
 =?utf-8?B?cGltMXR2bjRnL0xjbUlCMDRRcUFicTJaK21KU3U2L3dud1JOT1NBNzBZUjc0?=
 =?utf-8?B?aEM3YWhRWXpZbW5TbjJTYUVoTXBFczQremJ5WHljMHNyb2hZTDRaM1FabDhq?=
 =?utf-8?B?bllLY1hScWxSUHVHMGVBSlBvVktlRzVmTUNXZlcxTEl6KzdKUjROYkNreUtI?=
 =?utf-8?B?QzBKbXRnaDVWbzVGNit5MmVYNHJDQmg2VnlXWFpqaTgwRmc0ZEJqdHFqVTVj?=
 =?utf-8?B?bHRQS1hZaVE2Nm9wcFZ1WTM2eS8rRmVyeWNXTlJTUThPbWhQNVp5ekI1em95?=
 =?utf-8?B?VHVBNzNuRkhDTTNrZFp0Q2ZsQjV5aXg4emNXZERNNWkvOWZkZWdib3AzN1Iv?=
 =?utf-8?B?Rjc4QVlVcTRKYkxXM0s2YmdkYTB6ZmsxME9OODEzVllWblNjdENubkxvNVlH?=
 =?utf-8?B?NmZlWERDaDJhYUZhd1JwS1B0RlNIT1E4YzkwZGNoQlozUnBvaGY2aGYrU01n?=
 =?utf-8?B?T1JaZDRUVGo5MndHTVhLd1oya3ZXcU04UG12VWVyN3FYd0MzcGtrV2JKbDQx?=
 =?utf-8?B?VVMwNmZsc2ZVZVdhNFQ5c0k3QTRVakhGYTVKZHBWRi9hV2E2V1pLMTdPc2FC?=
 =?utf-8?B?cERhRkJjV2RFUXlSVHl3c3hTckp5VFdjUVlDY2ZQK3dqQXY2SXMwczVQbDBD?=
 =?utf-8?B?Rk9iNzFQVlg3QXFTTUNZMytUcmdKeWtMMkR0Zmg3YTh3dFU3eklwa3hEVER0?=
 =?utf-8?Q?wErGw8WpkexPgPVsvhPLTAVgxmNsHGdCuzZnlpl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkMyNTV0b1dOMEM3blgzOE9LNnJZYlhtK01Bdit0ckltQkdqL1ZEQTdFb3Iv?=
 =?utf-8?B?Nk1mMU82RVg2aVJYV2N1U2dzS0NRVjVqRzNMTUo3Q1cyZUk3OHlnS2FSdUJy?=
 =?utf-8?B?R0JWRk9XSTk3enhYUWFhbGw3WDU3Wk1IekZ1Q29jMGFoSjdIdmx1Q2oxVEdB?=
 =?utf-8?B?cTdTK2RPYldCZmxBU3NQVVVheHpFaVZXbTVKOWJwMythMTk1MVA4dFdCZ2RY?=
 =?utf-8?B?cVErYWZyTERVVU9ZZE42T09jYnlXaEI2aTZBZjNRaml4dElyc1RTN2dJLzIv?=
 =?utf-8?B?dUtPWTVtMXhPM0dNNzVxY2wxcyttWHEvR3hrNGFDK2xYSzF3WFVMd0YvMzRR?=
 =?utf-8?B?VDBPYk9oU2VIT1QwaXgzbTdYYUxycXhIcUFTZDVwakEzY2MxRWVPclVxd2hx?=
 =?utf-8?B?Q1FBRmRON2hKdnlIVjY3bERNcHFkTFgyR3dROW5XL0pSYTVQaW8xMDF5QWpx?=
 =?utf-8?B?L0R2OXc4ZnlyVVBDcjIxVGRCcW80cXQ4Y25PMzc3azBXYllNV1FYNU9UcElR?=
 =?utf-8?B?UXFPT1ZobnZUYXVNV0hNbzNnS0oxaDVrK0YwSW0rMHgyZFJKQXppM3IvRkw0?=
 =?utf-8?B?UE9tNHpuWmdLbnVmdEs4cEFYNEgvSXhadFBhbVpST0JzOGgxYkd2MEtsaDFV?=
 =?utf-8?B?d2RHNm5RV1h1RmQ2VG9RTlM0Rmo2YWlPbHV4d2drb0cwTkd3TFFzZ0RzNlkr?=
 =?utf-8?B?SUdjUytUd1lBeVY3VDBGcU9HTnBYR0xlVkdUQ0pZRE5rV2g5OTk1SWllYVl1?=
 =?utf-8?B?a25kbks2MGplbk56VHEwNnNhcHRvOUNQL090cWhSUUNFU2ExdG9DOWhwdWNP?=
 =?utf-8?B?WlFoclFUTjUyd0Q5eDJacXlHendFTTZva0VOaUd1Q25WZUpCdkhvMUNjZWhq?=
 =?utf-8?B?d1J4RG5WM1doMnZVSDczV3dTUE9Pa2NYMWdKSU9YYzUwaGVhVDJXZ2VKQ0E0?=
 =?utf-8?B?QlNDWVZNbml6Q3hHWHFvSDBaclZaL25mOEcrSkMvTFBnY1RuL2FXd2p4ODNr?=
 =?utf-8?B?T1c5SnYvbThRdVZRM0hOSDhBcWFZaGRnelFpenVCNmtxdzBRY08vU3lhMEpH?=
 =?utf-8?B?M2FHQzR5OTgwTDQzU2JiZHNRczlkd0ViTHo3dnFhbmxaS1M1QVpqQThUaU15?=
 =?utf-8?B?VXoxMkdGeGVnWWRaeWZpS0tYZmVzcjVUWVVjWTM3cVQzbDFObEpyRUk0a2c4?=
 =?utf-8?B?YlFQa3Z0L2RtVzBYSVd2Zk1lWFBYTkpKVEo0MG5ueHVYcTAyYVZxdXVncTVE?=
 =?utf-8?B?L2pmcEFodnRQS1ptektjQkVkNmpka3oxQ25kb3Rqai9mcXZ1dUJnR2E0U2pP?=
 =?utf-8?B?bnRyZW5KbnRyejdESmR0RTNmYStNUVYwMklIa013UXY1S3crTHhvRVJ6d3pL?=
 =?utf-8?B?ZFJjbUh6amZVYXlhWmg2MVN6N05INXl6QzdMb1ZEZ2phNHFHMURIYUxuekl5?=
 =?utf-8?B?ZkpvWkVoOGM4L0xHeitOelJHOFdFMm9MNHJXV3VQSEE4bnBzdFNPNG9qMFBj?=
 =?utf-8?B?bGh2c2QxeUFQZTVVVUtSR1FkY1o1MUtVY1FIcFdVUzFveENQaU9IQ1h1S2Zh?=
 =?utf-8?B?bjVZZ0hGRGlva0xRRWlrWXkwUUcvNGMyTW5VWWdlSmEyZDhlUGk4K3UyN1RU?=
 =?utf-8?B?b285SlZ3UWhId21iOENmKzhiUnNITFlUeEVWTndScUNqL2wxVi9pR09VZHpw?=
 =?utf-8?B?MmFOcjZpNDlTUE9Bbk9XU1lBcE5UYlZsWlYxMTF5bEpNM2dXM2VFNmJVMDlP?=
 =?utf-8?B?UVFUK01hK3VQYjJsTXo4NnkyQUNjaXZ2eWR2bm1VRU1lajlpdkpBVVlyOC9R?=
 =?utf-8?B?aFBKTlhyOWFqSUk2NzZZTXF6cFBaY1JWV1RkeFk1TlQ0Y2ZiekYybkV6dzZP?=
 =?utf-8?B?K1YxWUl2SWF2eVhDR1E2ZjZYcGhUNXlJeGhpVjBjZ2VKaDI2RFFya0pBMUNw?=
 =?utf-8?B?M2VkbVE4WWhjMzltZWJHMVhvRlFlWFJIZFYzZDZrZ0dSQ1VZNXVMZWhUSW01?=
 =?utf-8?B?ekpPTjREREhpdG0xdXFVOHRHdk1LZk9uaEhnRU9DbGlXeURDa3ptRmV1c1ls?=
 =?utf-8?B?UE9ENDVHODRRYlVUL21BV0FuSXJPQ1IyRUJkUlRySTMvRXhZYkpDQW4rc1E0?=
 =?utf-8?Q?ZC4cSas2mTGr6VVrDd85v9Ggw?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ea70d9-20b3-49f0-ebca-08dcf9df004b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 19:05:36.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l5ZEmDg8cQoTstpWimqkIDcGDRU3dttvpecUJinPMcvJZ3+MHL/dn53fg/N4JzYDevBToxr8qREVuAYaITz95A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5561
X-Proofpoint-ORIG-GUID: vrPd_fzcBu1rxRCqGuTgFjLlNjdRrtTe
X-Proofpoint-GUID: vrPd_fzcBu1rxRCqGuTgFjLlNjdRrtTe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

Hi,

> 
> From: Mesih Kilinc <mesihkilinc@gmail.com>
> 
> DMA of Allwinner suniv F1C100s is similar to sun4i. It has 4 NDMA, 4
> DDMA channels and endpoints are different. Also F1C100s has reset bit
> for DMA in CCU. Add support for it.
> 
> Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
> [ csokas.bence: Rebased on current master ]
> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> ---
>    drivers/dma/Kconfig     |  4 +--
>    drivers/dma/sun4i-dma.c | 60 +++++++++++++++++++++++++++++++++++++++++
>    2 files changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index d9ec1e69e428..fc25bfc356f3 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -162,8 +162,8 @@ config DMA_SA11X0
>    
>    config DMA_SUN4I
>    	tristate "Allwinner A10 DMA SoCs support"
> -	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
> -	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
> +	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
> +	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
>    	select DMA_ENGINE
>    	select DMA_VIRTUAL_CHANNELS
>    	help
> diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
> index 4626cc8ad114..c0a4e40134dc 100644
> --- a/drivers/dma/sun4i-dma.c
> +++ b/drivers/dma/sun4i-dma.c
> @@ -33,7 +33,11 @@
>    #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
>    #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
>    
> +#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)	((width) << 24)
> +#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)	((width) << 8)

nit: Are the extra parentheses around width truly necessary? They seem 
to be used throughout the file.

> +
>    #define SUN4I_MAX_BURST	8
> +#define SUNIV_MAX_BURST	4
>    
>    /** Normal DMA register values **/
>    
> @@ -41,6 +45,9 @@
>    #define SUN4I_NDMA_DRQ_TYPE_SDRAM		0x16
>    #define SUN4I_NDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
>    
> +#define SUNIV_NDMA_DRQ_TYPE_SDRAM		0x11
> +#define SUNIV_NDMA_DRQ_TYPE_LIMIT		(0x17 + 1)
> +
>    /** Normal DMA register layout **/
>    
>    /* Dedicated DMA source/destination address mode values */
> @@ -54,6 +61,9 @@
>    #define SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN	BIT(15)
>    #define SUN4I_NDMA_CFG_SRC_NON_SECURE		BIT(6)
>    
> +#define SUNIV_NDMA_CFG_CONT_MODE		BIT(29)
> +#define SUNIV_NDMA_CFG_WAIT_STATE(n)		((n) << 26)
> +
>    /** Dedicated DMA register values **/
>    
>    /* Dedicated DMA source/destination address mode values */
> @@ -66,6 +76,9 @@
>    #define SUN4I_DDMA_DRQ_TYPE_SDRAM		0x1
>    #define SUN4I_DDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
>    
> +#define SUNIV_DDMA_DRQ_TYPE_SDRAM		0x1
> +#define SUNIV_DDMA_DRQ_TYPE_LIMIT		(0x9 + 1)
> +
>    /** Dedicated DMA register layout **/
>    
>    /* Dedicated DMA configuration register layout */
> @@ -119,6 +132,11 @@
>    #define SUN4I_DMA_NR_MAX_VCHANS						\
>    	(SUN4I_NDMA_NR_MAX_VCHANS + SUN4I_DDMA_NR_MAX_VCHANS)
>    
> +#define SUNIV_NDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_DDMA_NR_MAX_CHANNELS	4
> +#define SUNIV_NDMA_NR_MAX_VCHANS	(24 * 2 - 1)
> +#define SUNIV_DDMA_NR_MAX_VCHANS	10
> +
>    /* This set of SUN4I_DDMA timing parameters were found experimentally while
>     * working with the SPI driver and seem to make it behave correctly */
>    #define SUN4I_DDMA_MAGIC_SPI_PARAMETERS \
> @@ -243,6 +261,16 @@ static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
>    	*p_cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
>    }
>    
> +static void set_dst_data_width_f1c100s(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |= SUNIV_DMA_CFG_DST_DATA_WIDTH(data_width);
> +}
> +
> +static void set_src_data_width_f1c100s(u32 *p_cfg, s8 data_width)
> +{
> +	*p_cfg |= SUNIV_DMA_CFG_SRC_DATA_WIDTH(data_width);
> +}
> +
>    static int convert_burst_a10(u32 maxburst)
>    {
>    	if (maxburst > 8)
> @@ -252,6 +280,15 @@ static int convert_burst_a10(u32 maxburst)
>    	return (maxburst >> 2);
>    }
>    
> +static int convert_burst_f1c100s(u32 maxburst)
> +{
> +	if (maxburst > 4)
> +		return -EINVAL;
> +
> +	/* 1 -> 0, 4 -> 1 */
> +	return (maxburst >> 2);
> +}
> +
>    static int convert_buswidth(enum dma_slave_buswidth addr_width)
>    {
>    	if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
> @@ -1379,8 +1416,31 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
>    	.has_reset		= false,
>    };
>    
> +static struct sun4i_dma_config suniv_f1c100s_dma_cfg = {
> +	.ndma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS,
> +	.ndma_nr_max_vchans	= SUNIV_NDMA_NR_MAX_VCHANS,
> +
> +	.ddma_nr_max_channels	= SUNIV_DDMA_NR_MAX_CHANNELS,
> +	.ddma_nr_max_vchans	= SUNIV_DDMA_NR_MAX_VCHANS,
> +
> +	.dma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS +
> +		SUNIV_DDMA_NR_MAX_CHANNELS,
> +
> +	.set_dst_data_width	= set_dst_data_width_f1c100s,
> +	.set_src_data_width	= set_src_data_width_f1c100s,
> +	.convert_burst		= convert_burst_f1c100s,
> +
> +	.ndma_drq_sdram		= SUNIV_NDMA_DRQ_TYPE_SDRAM,
> +	.ddma_drq_sdram		= SUNIV_DDMA_DRQ_TYPE_SDRAM,
> +
> +	.max_burst		= SUNIV_MAX_BURST,
> +	.has_reset		= true,
> +};
> +
>    static const struct of_device_id sun4i_dma_match[] = {
>    	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },
> +	{ .compatible = "allwinner,suniv-f1c100s-dma",
> +		.data = &suniv_f1c100s_dma_cfg },
>    	{ /* sentinel */ },
>    };
>    MODULE_DEVICE_TABLE(of, sun4i_dma_match);
> -- 
> 2.34.1
> 
> 
> 


