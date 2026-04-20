Return-Path: <dmaengine+bounces-10070-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5F9JBfSr5mlgzgEAu9opvQ
	(envelope-from <dmaengine+bounces-10070-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 00:43:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68368434B9F
	for <lists+dmaengine@lfdr.de>; Tue, 21 Apr 2026 00:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CCB730107E0
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956483845DB;
	Mon, 20 Apr 2026 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="juPr+MoL"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAF37B00C;
	Mon, 20 Apr 2026 22:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776724977; cv=fail; b=qFZ67CS8vFbwkrkXQnPRDZ5ogC+XQ7I3O78yeORfdSDn6SI0GdpeFhjXVQxpQ4ec/nnFPpNNNo0vKvH40hT33ChBAX/GGcLDmga1g7qmeQK5Xmq4I2sFWhgy666wZy/sp9fKy55cuR8BeJ7TECyYWbZPriCQA1zs6a5O65Cl+Q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776724977; c=relaxed/simple;
	bh=1CiT+NNCrWBOx1LK062XLPXZ51ZPaMsr6ZiFMwSrZPs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gsppYsdT9uX7hxA7fV2CHB4CPMSIRvkL81jMz7ceXXmAwyBVRwfJOrhXKYTAsBwNDJLgkW6NivD8qfaf1UeR8cakhoSUNamjZJ7dSZJ6inIc98J/nOOJRukse16Ez9Jz+gUvkjHSgydmNANaXG8JdShn5zd2CqwIqSKur7RGnF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=juPr+MoL; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8iG1YBQzAIMwn1gSk3MDl4QYKNFA9FM6h20+blG7iv9TNwofauhBGrDsR3j90okMH4srUShkX8i7W2TsoKt5L9gyO1NMlOT00U3xGqKLkmn+qDAh5jEowf1nfs5o9o/gzS+KXDVDH3IIA7Vs+y82tFesfuzi+wZ6++4p8l91Uv028Gv/lChg7Oyi5300mohRMsUb9enpEqbs+ehkksuMLGSehS8cGPqbQDt0tMFBShnOQBe/Rsbl6/dXWHuYGbd4Uzt5MKh9Mbm1Oo9Efpdzf1nfKgs0qws2s7vtMVNFM7xjQwJjwKZF9CA56GAbuuWDKA0KbX42bDplnXWAsEgNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d71MRWjFsNzx7a+U/zB0iwKmBbL7Bmxt+Dzn/nx1FAY=;
 b=FwkpjwIVLQtbuLs5pFilOVLN4QPiT1Jhqp5z9q+AaNqIvUUDXiz30rQPOrCd05wg+JUpCwgvgZS/ntP4WXtMCMefGiAu3Tb74atMwKWDv21T/j88rfBZO+SF0BqZNRVnRPewGzRcJjs8kK15nqKo3u2i6UdBnYtGq96BLgWjxpjLr2n8sHMLRbPcbVnVkg5gBKi3WDqW9OU5m6mf1uxVKh5pf0H5ezbMI3r0pZg+UgJQOVzXvA9qWCRyycAysvTJPaJ4KIA674RHTF9LFUjdIkNgXX5ql3Q79/3ktFHSGR8tqq/ggm2rAqfrRu3Q6hnv0KpFIzTWGtk9uegVE6y0Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d71MRWjFsNzx7a+U/zB0iwKmBbL7Bmxt+Dzn/nx1FAY=;
 b=juPr+MoLCP9ChxccAEgz0erV/07kJKJgyd4iIpt/mCRWCtvwkeAEr03kyuoczGXNMVd0bIEGG7xwuSZAUbExg5RFafYkHMbKwl3YyBQd+EMIpKzQFjI7mp0yELSmvInKJyLGl57/HBl6SoQt+fPqVZ72631baTBAo9eTVMgYN84=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 22:42:50 +0000
Received: from MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57]) by MW4PR12MB7357.namprd12.prod.outlook.com
 ([fe80::a230:c3c8:a903:2b57%4]) with mapi id 15.20.9846.014; Mon, 20 Apr 2026
 22:42:50 +0000
Message-ID: <839d1fb4-8519-4fdd-b04b-b2a9e88bbaf9@amd.com>
Date: Mon, 20 Apr 2026 17:42:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/23] dmaengine: sdxi: Add descriptor ring management
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Wei Huang <wei.huang2@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 John.Kariuki@amd.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
 <20260410-sdxi-base-v1-12-1d184cb5c60a@amd.com>
 <aeXkrudhvhTRtS9d@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <aeXkrudhvhTRtS9d@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1ef::10) To MW4PR12MB7357.namprd12.prod.outlook.com
 (2603:10b6:303:219::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7357:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: c0b8538f-13d2-460d-9353-08de9f2e26d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	iPcWDD9Ip+RVxWgakned/kVRoX8QSEo0+G16q07/Ii1UHC6psituznR4w/Bz/4TQ0dCq6OjcoutDKw9DAns6lMMpju+HTZQZs5iRxiwZIJUkmLeGSDBVajoybFvXdmglX57IHQSae8q3h8wXiWNc79UKMaKMg3UqteHXIZXSyR0Pqh2n+VD3ibCMutKXScppxRkaLn4xdpruEsyY9QLndK4ig6jEP+8oELVk1NfQTwmJdRlq4ZYE7JB0MNbv1FCl8+FQ8WL8i//yT28xMjr6/OiHgKOvUCy8PaDR2xk+eU67RS36jjSNmupLe6VAkFW6X3joeFOian4/kPWL1dtQ9zt2oy6YPLLSSCnrW9bVGpNDlnGaLMbjlgHLrZlqqvQHn0kTTY/kpirYfIuVXJsZMWO83rbgAW7CU/5/baU03JaUCbXvrTpwQITZUBiMC6YMn/sYYlYoocAgM5qfCgTvagf0XP1d7c3svjMhAaKy5NuZ0AgwEe+nJrBf8l9GEENaPSFqBU7L957pAT6/NftMw9Z1gqf6kaoW4Zqou9K3Dz3Tp0k9gMqGw7n8fPQ5d42kE8Tc7CQEBIL0GuiNAscGfBqCEF8BEdMllUYVSjJ5+f85mCDdNqRSaQqjtnhl/ke66AmbcoWSrmxRJwt8GWPXmcFs6zwb50lO6tHKNW5gULPEafqTw1v36h0uiHDxyUBDmbJZVx9E41bBWV7s5WMs80Jn2JxlzVxVSkY9nPH6XsM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7357.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VG9iT05HR3AvZmszRlNjMzZpMjZvREl3SU5nZlVQcCtxYUs5STZhbit0eFdt?=
 =?utf-8?B?blhmbXRUN2V4dDg5Y2NSUkxNMGhEWnFaSituQS9NMEpvQzRaekJpZDV0N0dq?=
 =?utf-8?B?em5Wa3dHZmlPOWZoVVRpMUc5L2pkU2pESEVySEUxSDl0SnZWRzl4Yk9HTFRR?=
 =?utf-8?B?S0gvYUYycjUyRTBucVpBNzQzc05JNjZnL1NZRGgvTTU1d081Sy9ndHh1OExw?=
 =?utf-8?B?d05WUUw5UVg5SjR2R2xicnpxdzJScUlpM2Rsc24rdjh1cEdaZUw4S3poRUt4?=
 =?utf-8?B?Qk01K0x5TEh0Y2tEMnZzQ3VCWjAwelF2RE9vMUk3ejl4SHh1cU5jVXhrN1Zv?=
 =?utf-8?B?cUUvdGJGU1I2aTVDWXZOaEEvbERBOTE1elhGWFJkYkxjNUNKWWZIUG04Y3Vn?=
 =?utf-8?B?NkZRQzZSZlBXOFB1RDk3TXNQemxOSHArcjB4aktMQXZoZVdtTVIycE9ERm5z?=
 =?utf-8?B?K05aN1FSZVBvTDJaQ2lFajc1YXJNTjlQQytRcjhKd1RuS3N2UGU4QllGSTlD?=
 =?utf-8?B?U2FrMkNhbitWNitNQnR6YWI2UEE5Wjg1Zms5RlE3dVdhZWY0VHZYZlBnN3lY?=
 =?utf-8?B?NzQrM2I5SmFaMGU1Ykh1VmgwbDlreE5kRmVnbzFZc0QwRlMyL1czN2RoWW5n?=
 =?utf-8?B?SW9SLzVEZUUrMVJZeHpYY3pCMDNCT1dFdkJKZnE5UDBCODZ2L0NmUExiNWZl?=
 =?utf-8?B?eVpqWHdUMzRwQzF4MHptdW9RMGs0c3llQmJ2MG1jMU5SeUpVSnlHQlBad21L?=
 =?utf-8?B?NWYrbWpTc1UxQ3pUUEV3NGtkQnRudW9Na2puUzd0UDFFYW8rR1hSQ2R6dHpj?=
 =?utf-8?B?cncvUWdMTFJGMm9qZ3daSStMdXpPbWFVVUFxK2h3d1hqeXU1N2N1bDF5cUx5?=
 =?utf-8?B?VXNCSG1URHkyVVU2dzR1UEdWVE81VDVXSnRGMjJGWVd3eExQYUZ6dXVoc3U0?=
 =?utf-8?B?a2ZBczZ4ZWtXQ3FOVTRHSzlCTTF4bERyNlhGOWptblMwWmJEeUhZWkprWkNG?=
 =?utf-8?B?SFVMMVV6T2F0U1NoWkxkMC9HOUpUZk45cElveU9qem9RU0NSeFJEMzNpNXpy?=
 =?utf-8?B?aU1wY3FJWEw1dE90WC9NaStmRE8ydDJINkQzSU96QVNLcVVjKzByWjcrZnpQ?=
 =?utf-8?B?ZDBZaEtWVERRWEc3eEhGTkltMFBYWW9sZGFZNnZjUEdiTTFDQ0lUY0F6RDR2?=
 =?utf-8?B?OHFIMExRM0c3UXg3ZUFrV1d0Y2tVQ0cwekNrKy9SUDFxc3JhQUJRRklLVktQ?=
 =?utf-8?B?dWFMMUg0YkxRQzNQRmhBWHluZkhLa0pua3JacXZEVlZ5S3ZscXNpWjJDYUJm?=
 =?utf-8?B?TGM2cUtmSERVNFBmUWcxZlJWQm5FTm51bVJNaE4wTk1tdEd5VDExTENJeDQ0?=
 =?utf-8?B?S2UzcStKRnZha1Z4QktXSXdLVjFIeUtqa3JkQ0VXV3EvbWNWa0ROWjJKa3hU?=
 =?utf-8?B?ZFFkY01nSzg3MTJzcDBKQ2NWemQyUE42Rjhha015aWpYb0ZwNUVqaGxUS1h1?=
 =?utf-8?B?Z3BiYlpPZnpoTlZRSzlDbGRHZU5uQzVzRlNUNjRQVHN1djlEWm83elFGelNP?=
 =?utf-8?B?N0xpT1Z0dFFXNGtUaTJtUDNvWFBoVEt1blY4THNXN0dOQ25CbXp4WFB2K1A2?=
 =?utf-8?B?bTFKTmdNdjdKVFVLa3BxNjZPZCtxVFdGVXNTK2JiK3ZPYjROTUJuL2M4OHQ2?=
 =?utf-8?B?ZkFTUGhQVWNEc1lnNER1NDdzS3J2aDZGOEVoWmlSbkxycjNmWUh3WDV1TzVO?=
 =?utf-8?B?bUFldGpmRlg1aFhqSFc4cTVTZktnOHp4bFRpWWhOZUpPekhNU21BVVExT1ly?=
 =?utf-8?B?eGlIOExlZ1RtU2t1UnEwSGl1a2dwd0RKMHFqY3JIbWxjd1Q1M2RKOTVkV24w?=
 =?utf-8?B?dVp4NWR6OEdjNi9lZUdjMnZaLytFclVwSzdQZzdFcGlDVXdUMkxoK3R4ZVBY?=
 =?utf-8?B?L3lXRExvNCtyZFpudUp4Y0JER3VxdnRzaXNNV0lhRUNaZVRNUTZGQTkvL3dE?=
 =?utf-8?B?NE9ZL3NNc1d1U0o3V2h6di9VZTkwcEsyNmFZcDgwZ21qVGFyN2d0QWNXbWc1?=
 =?utf-8?B?cVNYelNHd0ZEaVdOWUxpak9jeEN2bmROdmJwRGEyZGRMSU15QUdPTU1KZ2xK?=
 =?utf-8?B?ZHlld2JjSm0zbEVpaUJtTmRhUHE4a0lxbnBrWjlNZDJkYmhEUGRrVk9YV081?=
 =?utf-8?B?SXRYU0x1UmRUNlFWc1lHWTI2UkNjUHdvdVloR0xvcS95NUlvckZZemVMUDYx?=
 =?utf-8?B?THUvK0ZKRlJyMDhnRlBHMWwwSEJQNTdrMDRtRUtDRElWVThmUm16NFo5S2N0?=
 =?utf-8?Q?AnhQjJYVb6Wd3yQEUt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b8538f-13d2-460d-9353-08de9f2e26d3
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7357.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 22:42:50.2942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cW7XFqMGwPInhUsNmJcMWayfLGbeK+KfzkbhrSbw7HDirle8hF5U+WUyHDWyIGCZCWz+lZ2irYMYwuDFsdvhEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-10070-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68368434B9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/2026 3:32 AM, Frank Li wrote:
>> +
>> +static u64 sdxi_ring_state_load_ridx(struct sdxi_ring_state *rs)
>> +{
>> +     lockdep_assert_held(&rs->lock);
>> +     return le64_to_cpu(READ_ONCE(*rs->read_index_ptr));
>> +}
>> +
>> +static void sdxi_ring_state_store_widx(struct sdxi_ring_state *rs, u64 new_widx)
>> +{
>> +     lockdep_assert_held(&rs->lock);
>> +     *rs->write_index_ptr = cpu_to_le64(rs->write_index = new_widx);
> 
> Does it need WRITE_ONCE() ? you load_ridx() use READ_ONCE. I just not sure
> 
> suppose doorbell will drain write buffer, most likely it is okay without
> WRITE_ONCE()

The SDXI implementation is free to sample the write index before software
hits the doorbell, so I believe WRITE_ONCE() is required here, thanks.


