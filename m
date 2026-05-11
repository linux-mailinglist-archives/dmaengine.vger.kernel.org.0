Return-Path: <dmaengine+bounces-10335-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIUTAwNYAmpurgEAu9opvQ
	(envelope-from <dmaengine+bounces-10335-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 00:28:19 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F598516E5D
	for <lists+dmaengine@lfdr.de>; Tue, 12 May 2026 00:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DDB130242A3
	for <lists+dmaengine@lfdr.de>; Mon, 11 May 2026 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79B383316;
	Mon, 11 May 2026 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KcqPzbDG"
X-Original-To: dmaengine@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011022.outbound.protection.outlook.com [40.93.194.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A26383323;
	Mon, 11 May 2026 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778538495; cv=fail; b=fYK8oxYraiwMkcyfxIr47CpTSu6lsxMiPVsv/djFASWUKKvcO3mJgVWq7jz+D12JAnkYW2vFSfPgLxkQuTkKajCzj3ZrfK38aWMQdUuOyVFzMN5BQFUPHZ+ckB/0Tswe1gxKqCrgS0JqTZh9IOyvOlxWiJrZscxhnJa6OYyk/l8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778538495; c=relaxed/simple;
	bh=pAHWpKvTc9KyrPhIFFcQJN8AYi2QFjEAc2x3IJAjoqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HxBiFbigoGwJksgVdsfMeZju9mLDuacF0B43opgdQ/qcq+Zw+Q6zqPra8qPmKHZZNbO9hg1Nw5+ENLsSNxfO2DlMBGpV5jwkdlg3s8ut5birP8SLEDCcC/gBksc1HkPPuAHhQNIJ9oHT3aXas95XusQxvHYXDXWzjJS7ylQv7+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KcqPzbDG; arc=fail smtp.client-ip=40.93.194.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSm7Im4V8ZZHmxAjcGvUO1Gwv9rzkSpG763MmFIyh1RdGcatVTHeAP3cYxijWnbQTs2+YAhW0Qj2dKKEw4u6M173phKN9B5dpMVv6hG7epbbBlcVfiU6nwhtUkhjDzWfq5NHFLvOlUzifWNHXzwdOrirrkxbcj38XYgWt4Bb9hDDSGv+65ghHMnCo1cVt4Nn7ApxYIqsQHFQ8ccqLG+eu9+HgXyppiJrmCzivw1M07L2dlw2RVFZ0kqV1YA5wLPwUIHaXy0HsTsnZNebHVII/969bE2xTTdbt0MQ7LOA8O6UAOq2VfAVPGnwU/ZYNNSpsQX/T2k+ZdnXCSCiO7bO+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpaP6MyZJfNSy3VvHT6wWMZlPfiFQkSI+QQEVV/3Gno=;
 b=XHX7rkr4+OjMAJSCj+ZGv63wzVhXEXmLmnVLKjwF31ZSZZzDHkfznQBCeWiRzJcLTSWdzzO5cF1GIgO1qF6dj9hC/hwlDebRyM/H5Rc78KKHcBALcHGE/D/HeTaN3/oAwiEi9Z7U/UV2ktHS9iQh38+qhz9T+q4yZHtobsQ8gNF6VP3dvA6lPr1CbVAFA2lXIvH0j9K3KuDIHVrg2j8VTkiw8LQGrrBd8jDX/U3KiV5v3KVImNJrho2zvFUXNHx1E1iLTi3TOuW5mmH77j2QYrZL/tOT46e0OHooTopIvrqvlEVqs7NnGZMwOZZWdws4WokpK9MLiTj+/ORI/Bow6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpaP6MyZJfNSy3VvHT6wWMZlPfiFQkSI+QQEVV/3Gno=;
 b=KcqPzbDGBfNVomSWpersNbopMnkcb6T4uZfqkbtqc1CScEmy8NeZ+A7sHutXCZKdnOg6MbWcIN2fL8zh1mOTgoznW5iZyqytdfQvUucOEbF7M8rCTd9TLc9GEJP+e83mex9NXBg6W4tJ9dxtzEpnPyYYR/YLZOqNs6vw5p/h+go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6)
 by PH8PR12MB7303.namprd12.prod.outlook.com (2603:10b6:510:220::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 22:28:07 +0000
Received: from MW6PR12MB9020.namprd12.prod.outlook.com
 ([fe80::879c:bf22:f7a0:e8c8]) by MW6PR12MB9020.namprd12.prod.outlook.com
 ([fe80::879c:bf22:f7a0:e8c8%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 22:28:07 +0000
Message-ID: <187196b2-fe7c-4d1d-af9d-0df7bf1d0159@amd.com>
Date: Mon, 11 May 2026 17:28:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/23] dmaengine: sdxi: Add DMA engine provider
To: Frank Li <Frank.li@nxp.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, David Rientjes <rientjes@google.com>,
 John.Kariuki@amd.com, Kinsey Ho <kinseyho@google.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>,
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>,
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
 <20260511-sdxi-base-v2-23-889cfed17e3f@amd.com>
 <agJAeVtiJnQ1In6_@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: "Lynch, Nathan" <nathan.lynch@amd.com>
In-Reply-To: <agJAeVtiJnQ1In6_@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0016.namprd20.prod.outlook.com
 (2603:10b6:610:58::26) To MW6PR12MB9020.namprd12.prod.outlook.com
 (2603:10b6:303:240::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB9020:EE_|PH8PR12MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e84e73-3370-473a-b81e-08deafac92ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	35ntq8X5Hlr/IKC6QLv3jbFADIy4CPhL7hfvYvxMSdZG2cjy6qgEMr8/xVes12fOMcgTOC9RTKT6rmLA5uKPkG0HlaCPGTc7nzTILOLnz1G1vWID5CsCREDzRo8/eqKZcVQU9WuYseCYvzpCa7uj/Z4I9MDLu9n9hBcznPvT3AKcqY4KC+RqvuuQIfRNrHuyZjY6ltWAa86EZzu/N1zq4ylRKwyJHidfRtPUERji7SEAdp7/vZtDphAu29TXMZ8nI/IBrAf47OWhjudEjPEM+idvQMuR9XdeiVZB/DIeqWR6h2mf+DZZRyjV6avo2mIdqmCM6Bec01q4aG9WO1eVkbki0QKXTeiVKm9DY+9Cxe/Wf9VRTse0VOD44V5zViWFWBQoYsxduZ1UJw+lTulcBxjm7bTuYwsMvyEEXL8CNOvg5/Vh4MQ1EghGFZq5Xf2i6gjBssjGXDPzdZ9WC7nNJ6/OrXOrHELw+Efe3ZDERDTx7qPmtnEHiUqUZEFuCIt+h4gtJ8jIdzC/zH4rTzVfpSZw9SAPAMcFsh9sK1n3GWFlokodzXg8DxPx1ROxcoovbMVCM0BC0y5Caf0QBYOAMQ0453Q+OkeKlJtzbtbh3rmlNVfmiUw0D4EnUSW9Y1WxMuPBq4l/g/IJbVWB4b8/So0jwRSysRThQ8ADEw2zlk7CT9olfbucfKfYcub8yyAd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB9020.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(11063799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1YrT3hhWmtUNGhSb0UxWTlUUElJalZMRUhIYmFHWEZNNVhzUlBoS2NXY1By?=
 =?utf-8?B?Sy9IU2syM3pOa25VcFNnOG90a2g0a0FTR2JTc21wYithdFZ2YWl6RGJNS0Vn?=
 =?utf-8?B?Njh4OFNWeGZOTnpqRHorbFBBTE84Y015OHFrTUxQOU5RSk8rdXJqNTdFU00r?=
 =?utf-8?B?N1V3K2N2KzZIaityMVZRUzMrRndrUTVCM1BtRzJ5VnZaMmJvL3NYalhtZkFF?=
 =?utf-8?B?clBZTVhZRUFaS3Y1T1JSbDNsbEpLUlkxK1NFSHN6RTlqNGo4M2drZDVMUFZN?=
 =?utf-8?B?YVRmUFBiSnVHcG9lUDFPcjNDaGh1c0hqYlVmdUUxWHRvbVo1UEl2YzRmRitD?=
 =?utf-8?B?MGQxZElWdm93M0pVcUErTTJUWGxJQXZRVFBrcjBWTndvKzNXMkNyK0pkWith?=
 =?utf-8?B?T1hQVlRLT2JJN2pEeE9OSlVLWVVpMjFoOEhWWFE1WGxSTW1qS2haQm5zNzhu?=
 =?utf-8?B?N0liUjQ2UWtreitRMVA2MnRlV1pDRVQ5UFV3bzl4cWJSMzBsMlVlbkZNRnZY?=
 =?utf-8?B?Tnk3ZThGQXkvMTk0MEJEdVhWQzVjbitmaDd1MHRhbjNKZEVCbFRCcmVsRmNQ?=
 =?utf-8?B?dThaMUlmOFU1MGQzWThKQzYzUjVjR0lKdWEzK1NIZTltRVRyU3BjN0tYajYy?=
 =?utf-8?B?RExzd0xkY0dQd0poc3lkSHcrc1RlS05Hc2RNY1RURElQc09FWHhKemxpVFpo?=
 =?utf-8?B?eEkvN1lMbHQwVGJSN0Nkc2RYK28velBLaVVjVmhXZ3JtUGExQjZ4YnJKTTNl?=
 =?utf-8?B?L0NSVmh4b0NlbWM5SEdJdklPRjVsbFhCa21Nd2NadmN6aGxzTVAxRW50ajYx?=
 =?utf-8?B?UWFpOW5jcUlmejc2Smgzd1N0cUIzdDg5VFRENElXVjh5UHFiWHBob01haFdS?=
 =?utf-8?B?MEVDQXdDTXcweHV3Y2dsWE5WaUR0VDZVZGoyY1dEN3pJSnFwU3cxd3Byby9K?=
 =?utf-8?B?K0NCQ2lWWWxoLzIwaXJmemVUS25mem5INGt5RjVSYzdBQXFWRjZVTGRqdTNC?=
 =?utf-8?B?RkFTY3dsRkhKYjBEVFlIcTdLRDJaRmhFTmpEa2x0NlRQcUdFQUx1SkYwdHRS?=
 =?utf-8?B?cC9hK3lKU1p1blJlcVJ3eVlyZHY3aGFOdEVzNmljS0RtWVlnQ05BTjErb2Fu?=
 =?utf-8?B?ZjJZOTJpNFExWi9rWVJiRVFOSTBXT2hna1FkeXd3bWh6Q1hhREFjOFoyamc0?=
 =?utf-8?B?V2I5V2JpeVNFdVlNWkZYd3QxdW5BbUxub0N1WWVpUFMxeXA3TTkyS3FBWFQz?=
 =?utf-8?B?ckp1NWJOdWZtU1lRa1JDRTdka0JZMFVjUXF0RUQ2c2pzSzkxeUpWaHArVGRt?=
 =?utf-8?B?K21XQjMzTnBlOXJ6WnJuSE9JUzFlcjFpU1d0TEI2VWh1VHhNZ2Q4bzE0NEZl?=
 =?utf-8?B?K3VhbUNzY0xvT1VYQjhtNEN4RVF6SHJpUmxwOGdXYjlwR3Vhd3dnUldBeFEz?=
 =?utf-8?B?dVVsUW5qNVpZdUt0TnM2d0lWNHQ0WTNQMUdVdDhDRVV0QXNCR2R4Ukd5MEhR?=
 =?utf-8?B?ZmdlL0Z2VDZZV1JrY0lPRjE3V01UTDlocGtkU2RwMGIwbzhIYmppcFBGdVBK?=
 =?utf-8?B?WVlPNDJlRTlUTDhZZm8rTHZKaW9xZTJaN29wa0FaOXNRWEZyZmVvQ05UbmJO?=
 =?utf-8?B?cjJ4ZTI4V09SMm5jUHljU0phdEMyOWViV2wrM2tVRXByMnNIUVhRTzUrRnNn?=
 =?utf-8?B?dThCOFhHclFVOEVzV2xNT0VKVDM4OHYwTGNybUNwcHVhWWY2NjFNWnIyNTdJ?=
 =?utf-8?B?Mk9xNkZ0VWpmYlZoZ1ljV1REdHpzZzlOaEwzb3liMENKNDhncUhVaTNiQ0Fs?=
 =?utf-8?B?RVVQTzczclNpWGg4Rncwd1FzYUVSSFBlNnF1SGZpQTRmeURXaTJzQnlnVlla?=
 =?utf-8?B?U2ZwZ1ZHSWpSQjQ1OHREbHR0V0NGZEVGNmJlSGliTHZSMGlycEtSOXJPMUlH?=
 =?utf-8?B?Q2diY2JET085WHlJb0xVdkh2QnY0dWczYjYxclFVYjhobmp5WnFyNy9raVo2?=
 =?utf-8?B?a2JoZGxNRTdTZ0tHQUltVHMrcWRLQ1UzSi82ZGJGSTd2MzMrY3hRK1VobE1q?=
 =?utf-8?B?dlpOK3FEZEJoaUwraFlxQnVDOU16TFJqN3I3N0FHeVZVQjlrVnN6QW5ienUr?=
 =?utf-8?B?K2F1a1YvTkVtenlBcmg0NWs2V0UxRCt3Z24vNENUSXFpWnVmWkduRGxpUzlX?=
 =?utf-8?B?eXJGUklBdVdBYU53TDZrdmtyUDl4eGRYV0VvdG9xTkxMSmtFcEZBN0YrbS9u?=
 =?utf-8?B?MFFsMndwQVBaZnFNZWNBMXp3dlRieVR4bmtpWnl6OWpDR3hPNkFFV0JBV1JY?=
 =?utf-8?B?N0ZrZEFXYm9zakNKcTVia3JvRi9Db2YvcEVLUjE4VFprS1VGNUlEUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e84e73-3370-473a-b81e-08deafac92ef
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB9020.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 22:28:07.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPBfcoR3944UnT4Be/Rkh0+GrfwqrYkJy+wc+usGzfY4DTD6aijugbMA3fJ2dSk1ZpNfhJJ/euBBo5v2U9OGlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7303
X-Rspamd-Queue-Id: 8F598516E5D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10335-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan.lynch@amd.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/11/2026 3:47 PM, Frank Li wrote:
>> +static struct dma_async_tx_descriptor *
>> +sdxi_dma_prep_memcpy(struct dma_chan *dma_chan, dma_addr_t dst,
>> +		     dma_addr_t src, size_t len, unsigned long flags)
>> +{
>> +	struct sdxi_akey_ent *akey = to_sdxi_dma_chan(dma_chan)->akey;
>> +	struct sdxi_cxt *cxt = to_sdxi_dma_chan(dma_chan)->cxt;
>> +	u16 akey_index = sdxi_akey_index(cxt, akey);
>> +	struct sdxi_dma_desc *sddesc;
>> +	struct sdxi_copy copy = {
>> +		.src = src,
>> +		.dst = dst,
>> +		.src_akey = akey_index,
>> +		.dst_akey = akey_index,
>> +		.len = len,
>> +	};
>> +
>> +	/*
>> +	 * Perform a trial encode to a dummy descriptor on the stack
>> +	 * so we can reject bad inputs without touching the ring
>> +	 * state.
>> +	 */
>> +	if (sdxi_encode_copy(&(struct sdxi_desc){}, &copy))
>> +		return NULL;
>> +
>> +	sddesc = (flags & DMA_PREP_INTERRUPT) ?
>> +		prep_memcpy_intr(dma_chan, &copy) :
>> +		prep_memcpy_polled(dma_chan, &copy);
> 
> Maybe I am wrong. According to my understand "DMA_PREP_INTERRUPT" is trigger
> irq when complete.  without DMA_PREP_INTERRUPT, don't trigger irq when
> complete, not means use polling.

OK, my choice of function names there arises from the dmatest 'polled'
parameter which selects the completion signaling mode. I can rename it
to prep_memcpy_nointr() or otherwise refactor to avoid the confusion, if
that's the issue.


> for example,
> tx1 = prep(flags = 0)
> submit(tx1);
> tx2 = prep(flags = DMA_PREP_INTERRUPT)
> submit(tx2);
> 
> issue_pending();
> 
> DMA Consummer just expect get irq when tx2 complete to reduce irq numbers.

Yes, I believe the SDXI DMA provider satisfies this expectation as
currently written.

> If using polling here, it will reduce transfer efficacy.

The SDXI code does not poll for any descriptor's status unless the
dmaengine API asks it to, I think? E.g. via device_tx_status().

