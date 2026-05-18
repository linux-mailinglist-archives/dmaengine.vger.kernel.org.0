Return-Path: <dmaengine+bounces-10509-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOCgBD8FC2rd/QQAu9opvQ
	(envelope-from <dmaengine+bounces-10509-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 14:25:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A76AE56C992
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 14:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5B29302166D
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B10A3FF88E;
	Mon, 18 May 2026 12:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hKj/5JbR"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33403FF89B
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 12:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779106614; cv=fail; b=cCL9V94gQPeoW5XYxL+yFSUoc6Q1XUavu5Ig6rFwZYcPyGIy5q8AyFZxXB+nw34/Q1pK7IM1N/JejrCXZHrIdhmCOnfiy/lspqjmEe70+xotWT9ZgQ18gd3d8w0aY7DoIJLavcvT/942TxUW53/kZocjEs0YuiKm3LRgWQSVZTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779106614; c=relaxed/simple;
	bh=VvoTsicAUnXo7/a36Nn/zH7v0EZ3j63f4WLiw/jh8gc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=StmrE8oj+DWPCOLwDFyqi11bEyIZi0+6bgtotRYmqRkjW9ElY+g7mgHrvTDygkaNoY4ArcJPsO/JKew3EFTxF24Uild/okuIfmN1nMoRNqcGuQTYv+WsZeSR3b4wg09W2vrJf79REsRzC3B2ru1VIivX0ogT6lMCbF1d40yDXuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hKj/5JbR; arc=fail smtp.client-ip=52.101.52.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZBtvzITpVNrRticVqYTqDuw/WvwJ5Yfu8MMDp2K06Lak/PuoUyGuNFGxsK8/9x3nO0oTVmq6zTX+uWKFgvBJ8qVfvCIzo8fEFO8aVX+i8Ba207DjuE3gR7n8QQp1ALQQjdTt4qZZuVSTY+KzmiIQOfYvx7qrzGZuqUlqhzEH9clV+oPLTUonnhkaKZKirBFd1ocVav2JKOhHjxuJRghCG1xC9bDemDUovLwBHYjuC/xWtB1Ho4ZTSDDxTKDKTSj49CJXxo6ZaUUw+c1wyKbog1qvbjiFLtu4fK0E7JMuF1oFFeSzWMHdxk1Klhem08zWrgj2voH5ldiIdA601m3/1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3IJC1UM7Y4WC4QZaQXRpEoZb+aqBeRjsboKIMX7l8n8=;
 b=Cgnfjs5luyX9yoCbL87sualfjrFKj4dqx1CB6zIyvvJ6a/j3hAuzS10fRg0vG8z1e7U/MxdyCAr3HoPCgr1ZdDEk2xRxFf5+6xrbmrPA/gdlsLlv2A5exXMD9lp3eD8SE4gryCldXnUnFGgQwHJOWx4RileYL0OWmFqYjBhXXjMigIK6pep45wlm+xyxjhXxy8d2wDkdj4qBKK21grXqNtI6tWcklaHD+6Qrfp5M5VeMqjAq4mXXyS1WrrqyGO6PKLU+1oJhIfW0drUlQWwQCLdh8zvUTUwD5KfqOqTVPECjkbaJQLl3IIW8WZt9nSXRjxRBNH4+RwfZ0teH8sr3+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3IJC1UM7Y4WC4QZaQXRpEoZb+aqBeRjsboKIMX7l8n8=;
 b=hKj/5JbRiAg8gTiG68EJD/vUS9wkATZFZc/75n0BYwq2Y9zjF+30EgYYbXDpIJkCdhXSyrUtfZkj+/o3kkqZp8/mN2/BDwgzSXbEM8yEMooL/nEXqww/HCMz6XmmhWSt2QlMV+TGl7MuC4oIg735opdZ9dYuvD/qbvPNdHuYCtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5259.namprd12.prod.outlook.com (2603:10b6:408:100::17)
 by LV2PR12MB5726.namprd12.prod.outlook.com (2603:10b6:408:17e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.20; Mon, 18 May
 2026 12:16:49 +0000
Received: from BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed]) by BN9PR12MB5259.namprd12.prod.outlook.com
 ([fe80::122c:cca7:c2b3:90ed%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 12:16:49 +0000
Message-ID: <7e036790-3e3b-452a-8895-d7bff66ccf36@amd.com>
Date: Mon, 18 May 2026 17:46:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: Fix device kref underflow in dma_chan_put()
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
References: <20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com>
 <20260518082920.B9BB1C2BCB7@smtp.kernel.org>
Content-Language: en-US
From: "Garg, Shivank" <shivankg@amd.com>
In-Reply-To: <20260518082920.B9BB1C2BCB7@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN5PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:260::13) To BN9PR12MB5259.namprd12.prod.outlook.com
 (2603:10b6:408:100::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5259:EE_|LV2PR12MB5726:EE_
X-MS-Office365-Filtering-Correlation-Id: 242fa27c-bfc1-43f7-44f4-08deb4d75678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	vLXd/EpQR+z+h3WtGrP1igZi9hK5XOiCF2Odb4QhNVtpbV9cwsOLOUCPdYET+eEOqC5LP6l1MSixZN3lNt/QNEtpd/H9AFW+PLuuKSVo4vEtUojUE9DlpPfRRgNXG+Rov142SxUQcMeEs6BMf/K0vMqzvqvhgh9o2laBfVoaeezqSz3v7H5kd9F9/mH7Rrg3FBX7sWtK3NnUcc5/KhvG9Ry2ft9rIDtHx6jCxR1qCxPxRX/ElmbLmkLmuc3aKJ857v1tZcmdB4M2BKSRyvrklXWtVvVo4Z1Q+QL8RrSOXDMk2AEQBbZJz0ltTJoPmKip4ncGLRl0OCrCqxAjNnYJeO5HunSm1TX8YX4duDcGBIlLO1CsutTYFFFlYxEqCpshUtOODT3uCSsEipOWUR0GSWTpODZMlfpmRTp3zs6EdnSZ1fTHWQ0o8yOoWX05HgZ6J2qc/Bvr9smw1DRU8868cQ5QYAatyT4EfDKoNjLDpFp9btwomviqTmfuJUFuNNLRXAtyy/d1qBwTK4mP3ESgRW+nfRdoZM7yfkRGsHvmgGZrw86nOBsBEZQzkLX4iDtSRxVUyy7JUXk91g46PbVrsygq/mmUD2S/GRNKz6NCe1wFOYigDShcnffBQKHuJ9bThJWKXiO/gmMuSRrwzvBHvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5259.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K25JUmtMaTI1QnlTVmJYdy92T0s2b3RwZlhQZk1uVUJjMFJkK2kyMTlyVmgx?=
 =?utf-8?B?QTg4UUVBWmpORXB6aG1OS21PUVhqUWRHamQrTWVCRnZUaHhhUGI3WC9ReXJE?=
 =?utf-8?B?bXNTTHhySHExUFdIaWdFN1NCakI2b0xLMDhpRnpXWW1MSUQwS0RJTEQrZVpj?=
 =?utf-8?B?K2dHTGpqeERic2ttY2M3bHBTK0plUjRnN29pZHpuenFrUkJ1N2diWFBKaE5h?=
 =?utf-8?B?VzFMdklOMWFtREtIa29zb2Y5MVM2dXJmcC9wNTI2Zi9xblNLb2o4eTR6bFJL?=
 =?utf-8?B?c04rajJSRm1keWdkR0VyQlhvMisrUmlaZW1sYkRWNEw2UzBoUHNjUlNsQXNl?=
 =?utf-8?B?L0FvTGRqSWswMXllVW81VXJmb2JKb1N0T3lvQmhUd2lxRnF6ZnV4Y0Vya2JM?=
 =?utf-8?B?dnlZb1hGeFVacnN0WEFFTlBMM2Rvdk5qVnhUNGJTQ3d0OCtYakNEUXVhdUI0?=
 =?utf-8?B?Y1VxZ3A2ZldVRWVMc3l5UkRPdE54c2lTcWh5SHB4L3dtdWdNVUIzeXJ3K3A4?=
 =?utf-8?B?SmlCNjc5dGY5YzdoNkV2eU4vb3l0ZXd0WWl2T0x1eUtQZXNGbGVpUXB4OEhT?=
 =?utf-8?B?ZTVHSjFKMTN6b1FvTllNdE1uTG45eDEyK2FCVjZuOUxBaXNHWjBCWUZWeHFV?=
 =?utf-8?B?bUI3UXRrajluS3VlWTFndW85OEMrcjM5dnV4MnNMUXp5V1dGWmtEeXR0NTJP?=
 =?utf-8?B?ek1wN0xWWXhodkZBSXhjdU1ERWpPa2dTdlZYNFlibjJoUXdNQy92dm1yVFhh?=
 =?utf-8?B?TUZzUFh5OTY2WTA1MXY4MU52RDJmNk5xc1M0eHEyTGpORzE1aE01RmJkbS9K?=
 =?utf-8?B?R1dQREQ4Zko2R3czRDAyQ3B1MlRsclRlcjc1NmFEVFMxUElsYTBnWlRva2Nm?=
 =?utf-8?B?VW5tWDB3R3QyblhKenFhVDZGSVc1RGRsd1JOVlhVOFkwVjJQN0JxWjZwaW04?=
 =?utf-8?B?a09BMGowVldRN3ZDdGg3M0NMWEpjakR0RSs3ZU9CRk9KaE9XQS9LWmdta1FE?=
 =?utf-8?B?clIrNXJNZGhOT0lObGVFNlpQY2FaV01xZWhzNzcxMElIK25JbGNnenFPTzk5?=
 =?utf-8?B?Rms2NHlJRGJyZlpsVFUvOG5NSi9SZDduOWdzVUF1K3F3RGt0UTRDRk5FZlJq?=
 =?utf-8?B?SzlBTmx3dTM5aW9xaEJXVVRyY0g2NnRVenorK1B5S2VZYnpHdUs2czZIdmdR?=
 =?utf-8?B?VVdBVW9qQkE0QnRqZUprWE9GdllnU2JKTlpkOVpISjVxZVMyWE90ZVBRblJr?=
 =?utf-8?B?bzZ4OGpmNDdTbTBRWWVZbSsxTEJwUGlLSUg0RXZUOE9JRldzbStUVVA5bUpo?=
 =?utf-8?B?Z2x3WUdXem0xTUdEcERodmI3MWFGTU1oanBYa3NsY1lVdVM1bGhaRkpFdWxF?=
 =?utf-8?B?Q3grOVlCamh3T29xLzI1cjFzTUs4MnpCb3VlYm1ibU5OT1JMVlJOSWYwOU5u?=
 =?utf-8?B?amI4eEc0WkE1elY5a3ZCcElTS3E1R0lkWDY2Tno0enVoeXZ3LzQyK0ZFMFEx?=
 =?utf-8?B?S24xOHFnT001dEt0a1lUOWFwYkVaREVGRFNRazJuZlAwekdlMEVGMFh3RDEv?=
 =?utf-8?B?b3c1N05aOStQSmZqTHNCOFVrVndnRlZGY0ZLMFhTc0NwSGozS1RSNlZBVG5Q?=
 =?utf-8?B?bHhJVENMYmFWdE94MGttREZiTm5RL2MwSWRKT08zRnovR1hNM0NCeW1rMU1S?=
 =?utf-8?B?cHJDc1BuWXVTQVlIaUlZQ2R1Ri91Umt5REZCK1F0ZStROFpTR3VLMmdHWHB4?=
 =?utf-8?B?NVAxd0xBeXZVWEJ1cCtRSUFRZzYzOUZudWFpUzJUTWVSdzdxczRXanoyeDlu?=
 =?utf-8?B?ZUdDUUhxd0FaaXpnM0tGL2R2NTlOT0hVU0cyeTUrVXR3K3NrNkNvaHdvVGNq?=
 =?utf-8?B?cFBSdGdHV0RZZ09vdmpKN0l6QzBZYnhxYUUvUFRjNXVPR005ak5haUxJOGc3?=
 =?utf-8?B?NzdES0pHaWNPRGh2UUV6ZlR1QmJZK3ZPYXl6RVZYYXhVTmtoejNXaHJQMkJk?=
 =?utf-8?B?YzRUVjFOTlNRNzRSR09GVVhRZTV1WUVwZWpqdUwvbXZIcjZGRXg5eVlRZjlT?=
 =?utf-8?B?ZU9LaVFyN1lSZWJST1pmenJWdUhkdkNDYkoyaGFNSGtpNytXWndQRjNRSERJ?=
 =?utf-8?B?MjJGVmU0aCs5L2VDQ242akxucjk2N0IvS2Fid0xzWnpRSmZtdU5BajFpK1d4?=
 =?utf-8?B?ME9JdVRQT0FtVFdxd3ZuOXdNODFxak9zbHZlY1l4VWgwVDhKZzZFN3FaZmVB?=
 =?utf-8?B?OFIvSTZYSmtlZmlZU01YSURFU0tjZ0lUNzY4OW9TcEhmcmY3dm0zSkpPSlZw?=
 =?utf-8?B?cW13MzFUWHN4N2hMcGpFVGMweWoyOWJ3SDdwN0w0M1VRbGVXSDlodz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242fa27c-bfc1-43f7-44f4-08deb4d75678
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5259.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 12:16:49.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p655VfU1Y6krq9k5LblchHE0JxYEEbhrbE6e+NL5MHIT9ECvViwufx+5b/kZbCdGSYb4nfYbg6uJL8+zArcenA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5726
X-Rspamd-Queue-Id: A76AE56C992
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10509-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shivankg@amd.com,dmaengine@vger.kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[amd.com:+]
X-Rspamd-Action: no action



On 5/18/2026 1:59 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Pre-existing Use-After-Free vulnerabilities in dma_chan_put() and dma_release_channel() due to device memory release before teardown completes.
> --
> 
> commit dcce1cbcc027c7a50b03bed56fe875a7390be677
> Author: Shivank Garg <shivankg@amd.com>
> 
> dmaengine: Fix device kref underflow in dma_chan_put()
> 
> This commit addresses a device kref underflow by ensuring the device reference
> is only dropped when the client count reaches zero, matching the slow-path get.
> 
>> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
>> --- a/drivers/dma/dmaengine.c
>> +++ b/drivers/dma/dmaengine.c
>> @@ -515,7 +515,9 @@ static void dma_chan_put(struct dma_chan *chan)
>>               chan->route_data = NULL;
>>       }
>>
>> -     dma_device_put(chan->device);
>> +     /* This channel is not in use anymore, drop the device ref */
>> +     if (!chan->client_count)
>> +             dma_device_put(chan->device);
>>       module_put(dma_chan_to_owner(chan));
>>  }
> 
> This isn't a bug introduced by this patch, but does this sequence present
> a use-after-free risk?
> 
> If dma_device_put() drops the final reference to the device (for example,
> if the provider module previously unregistered the DMA device), it can
> trigger the device release callback and free the dma_device and dma_chan
> memory.
> 
> If that happens, module_put(dma_chan_to_owner(chan)) will dereference the
> freed memory, as dma_chan_to_owner() accesses chan->device->owner.
> 
> Additionally, when dma_chan_put() is called from dma_release_channel(),
> returning from this function leads to further accesses of the freed memory.
> dma_release_channel() continues to access chan->device->privatecnt,
> chan->device->cap_mask, chan->slave, and chan->name, which could cause a
> series of use-after-free issues during teardown or hot-unplug.
> 
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260518-dmaengine-kref-fix-v1-1-4d6125048fb7@amd.com?part=1

Thanks, this makes sense.

I'm able to reproduce the dma_chan_put() use-after-free issue with KASAN:

            slab-use-after-free in dma_chan_put+0x3e6/0x4c0
            Read of size 8 by task insmod/6319
            Freed by task 6319:
              kfree+0x225/0x470
              dma_chan_put+0x395/0x4c0
              dmaengine_put+0xf8/0x160

I'll add the fix for this in next posting.

Best regards,
Shivank


