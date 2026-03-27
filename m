Return-Path: <dmaengine+bounces-9690-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOuLD1dtxmmkJwUAu9opvQ
	(envelope-from <dmaengine+bounces-9690-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 12:43:19 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B74343A5F
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 12:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7747430405AD
	for <lists+dmaengine@lfdr.de>; Fri, 27 Mar 2026 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C7637C906;
	Fri, 27 Mar 2026 11:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vkPGyA1C"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A137B03E;
	Fri, 27 Mar 2026 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611794; cv=fail; b=P6ca2gD2F0IxzJRBpEooRiwsDviEbNom/gWGXd7nNfXPg0jM++Fb7vJtgxJlKiFQxXfFz2Gk7oysfH8oWz3o1MpaDJpCTkw37aByhAAo9UELEmf9e3Layzb0KS9Ee7t+H0IlMw5+pI1NSfMhDulbzDswotDDnhL/vzjNdlCiRt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611794; c=relaxed/simple;
	bh=a/nZp/voQ8yTRlyGgzDtwVCAYSSqJhSvBBgnXI1ghvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jVBrSyMfvrT51xZrI1YB+fiao5/H5cW6E8jfsmtsVB2SSS3aRu917oY7EgOXZYmsnQcnJTWwtq33QFlW5bZJFNswFp39ttqp9TFiJfi5fpjPjh7yFBc5dTLs0H3E0q9F1j1/scL/KVh3MF6HnUvcUZP2y1mgFFCxwELlkapi4N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vkPGyA1C; arc=fail smtp.client-ip=40.107.209.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncOh8qbCsnCOyLJHXqKGFf7tt012FUIPxaTKCX47UeknH6I7nZGmA4yzff3EwQGPGA0/8D9iHK81ngA50RqbqXISBRMfGhij03L4Y4QdkEMB1qHd0feCcOGi3KwtMMixJGg5HTq/+JP+J/v/YkqVk4OzH7+Lk9wthY98otyH+EQZ9g5qNUPd+s574qBXsvDJXFmWZG4jj47B//NTJ89JTGNZ0aziJpdrE2ja4GKXITAGSnu7/9Rpy27mxDJ3R8GhwgW07AKjfWKJ/t1OcsXJsph4wipGF+gwlYLNmhxObisLAUR33BTkJxpjlWl6tofA0cHvBnG7Ve+SbF6kuyKWjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=is5FZSFfu72C5rwGobHCunv6Ecrb5riEbSQEynJHquE=;
 b=SNgNP4UcUPZp6C0iXNS/omgqo2QyQ5pRHYdVb1qG7FFntzZvmSDMzYKOX8BCMPGcFeKb2d2OLHJwjkXD8JTKcMMSbrHpwC6RWxGzNAfLTkPaJVV0ifVlycXf1hFv165ooaFov1X4TatGdW6EI6h0Tj9QGYDUsNlZ676rB7oBC7JtGFG4CUrlnVq7BF/OFZL2VXoAdIGobLYNX27Z28MOZTQBpJuccVCGoVRpQQkeMTZxG4nczXT/O2rwe8Aprhtl6bokkG9kAfMPmz1GD15asb5o/0KtIaotc+CULyLjrA27+yF9j05z/xVr7kcwraYrVlKfIKBmdrMWW66X8RrMXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=is5FZSFfu72C5rwGobHCunv6Ecrb5riEbSQEynJHquE=;
 b=vkPGyA1CUIwOS2RDqTUPr3mcoC9r3u6u8uAmAsGZtfpmSEG8higGELIr/dg7cghABVSY119RY/kbESEDT3yAGVD8ATaz5pidPugHwpB0xSKYONVratLhCtvZmoFT22MmLkNPIjSRZsDxoZateBYkw+KjjyeAI9MIN2mIpHj6/dM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 11:43:07 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%4]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 11:43:07 +0000
Message-ID: <5070b60c-91aa-4718-892f-0788618fd826@amd.com>
Date: Fri, 27 Mar 2026 12:43:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dmaengine: xilinx_dma: Fix per-channel direction
 reporting via device_caps
To: Rahul Navale <rahulnavale04@gmail.com>, dmaengine@vger.kernel.org,
 "Gupta, Suraj" <Suraj.Gupta2@amd.com>
Cc: Rahul Navale <rahul.navale@ifm.com>, dev@folker-schwesinger.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 vkoul@kernel.org, Frank.Li@kernel.org, suraj.gupta2@amd.com,
 thomas.gessler@brueckmann-gmbh.de, radhey.shyam.pandey@amd.com,
 tomi.valkeinen@ideasonboard.com, marex@nabladev.com, marex@denx.de
References: <DGHGTCJRRZCW.9TGXQW44V6RR@folker-schwesinger.de>
 <20260325142300.3680-1-rahulnavale04@gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260325142300.3680-1-rahulnavale04@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ec7a00-d004-40cf-6d21-08de8bf603be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Rvv9RsgWeSyvCr+gC1195cFt/PhLvLqKYnXLV17kvBExtUDvR07SRplGpoYL1wjaUu6g0+WiFZgTUDzwfdkq0SeoiLRVlLmwWz9t8zFA7xm/VHVqzn3pEvCBBEKhEkniwkoTBhGSUS9XMe9bHm75Em78HFdrRfAmKUmBO7p+w5QWE+zm/6qtMrPIfnEoRnz49du6oFpNBH+0QTyNm1M21LOVWRbpHk8Xl286O14XM24lZM40uvWuLalbLYNsvN+7f/UH+69oa3zEO/uBydhX8FOLe4j+FuuaZZkDmp3vD42cdX3unsBd0zcWr9gEmWLY1Tb+t3Bna22ilamzqIgIKMDMEh7otR0X3E0iQp+9jZs+4A4O0uWNxdP8odqefMM09suntix48gFSgid+YPTVGeG3+sEdvpd2aG/miSzRt96KavTU7j1hEtYKCjINy7gfEPVuI5AbopxMuXfkVqqb+9rdKACZ6PtuTPcLBwnGgXYNoog6HM3BOcO/nD1JNaL61w1n9roQYFL/nQoKdrvJGvLUQyaQOLnP8uOdhjvJuJYDD56tWXugoFmi9J7IUAt5RYaoeQI1i/LJHUEQCU/JKGWMhqSB8VVRslj0LLF0szg58ID7KMrxqUo6hJ5TfdMU3cgxlGRH5PmkTayGw6cxDWbWN9hPaN3n6iFETMUj01+Hx9GuJBiAmZ8jBn14Th6TBBk55m0WM+i0xUBAaqtHgFMWMgqya0klQRm5VMQhwe0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTNPOU12ZU1ncDFnR1RYMzBhb3p6UnNUb1ZBUHZUZjFNUTlKQ09RakJEZWhl?=
 =?utf-8?B?NVJCVmpUNnRtbEhpWGxwK0xybFVGWVpZZFhXUUVxZmJZQVZxOXIveFFVSjZk?=
 =?utf-8?B?cEpXYmZTOSsrcDNnNjZVMnlGNnUyODg2RFdNaGhqV3JHM1dBaG1XaEwzVStZ?=
 =?utf-8?B?ZTVYVjRRUkc0eHc2Zjh0SkhTYmJYd1pGNSswVzRSNjhRRjZYT1BXS05Da0ho?=
 =?utf-8?B?VzdWR3RGUi9yOEk5cFVhR3lJN2x3cWs1QjZScE1JM2lxbFp0cmN2OGdjWU5D?=
 =?utf-8?B?WGZ3cE1oSlJiakxKSHYrSVhkTHZUampPbnpPUmtBRmVqMFF2VGVGRExjcVpP?=
 =?utf-8?B?bVA4S21hTlVxZGFnY0NObVFWZWpLRWVFR2haRmFncWVkQ0NCTC81bU5zaWVX?=
 =?utf-8?B?dXJBQm1rV3Q0WWpZVGpGay9iWWZyd0tPdlRWL3l3TzN2WHRxYnRKRU90MVhD?=
 =?utf-8?B?L1pEckFZcS92WXpGMDM1YUJZcEFTbmFUbmh1eXdERHpFMzZDTVJtUXpRamxY?=
 =?utf-8?B?MVlKeVFBYjAxQ0psZG5MTE1SZ0ZJUnIvSzlVKzcvRS9NMnpRMy9ScFRIWGZF?=
 =?utf-8?B?Z3ZGd3VYOFVmK2xHeS80SHY3WVVWZHpjbjYzZmdLMWxYNjdwMnhhcG9GZkgy?=
 =?utf-8?B?SVFrLzB6YVE4RDFpclpQaDRja0EwVnNDNWs3dTBMdHVjOTRGR2FMdkVXWXlD?=
 =?utf-8?B?YXpaVkhTVUdqWWlsd08wZGhMQjdMUERaK1RKekxTa2FScEQwSEpVeDRDMjE2?=
 =?utf-8?B?aC8xcDBUY0s0RWN4YlE2aC9wbThtZURMZWFXYVQxbk1qZUE5UkNWQWpnbmRw?=
 =?utf-8?B?eDhmVURRRVpaRjBTS21lNGNsN1JqWG9ER21PUmltSVJueWdXY0t2OXYzZkZh?=
 =?utf-8?B?YmVHTEFLc25HdXlQaUhZUzQyMWhwTTFITVc5Ui9oeGVPeDZYZ0pZa2EzSm5s?=
 =?utf-8?B?eU9KbzBnMlNYMGkrN2czem1LOHZPOHJ5YVorNFU0VTNmQzlzQzA0Sldrcnoy?=
 =?utf-8?B?WGUyS3RtSDJTRVlqeEo2V202VTlMWWR6VXk4Z0hzazU5SFFMRWMydjlabUpO?=
 =?utf-8?B?YU90Y1FrNDlDMmErbXk1Y29lODdhRjBMWnl3YmVyQUY5bUxJTFNmUXdJUitV?=
 =?utf-8?B?bExmeWJGM3pCUXZTNG85dzQyRHMveFF1emZuUmdvU0ViMUNJbDFuVUhwMVdv?=
 =?utf-8?B?KytHbEZiVitkUVllR0w5ZDlUaC9XeTZocjlRSncyaFJQM05lTnAwakREcktm?=
 =?utf-8?B?VVV3djdyNnFHYzEyL1BSSjBWNFBVSEVVbktYN0RVa2FvT3lOL1FMb2lBMEFP?=
 =?utf-8?B?R01oNmt6UjV1aXN5Lzk5YXg0UmxodnFFVzNhNWh0SE1taWd3YXV3L3pHaVA3?=
 =?utf-8?B?emZ6MC9MY3dYbGNwbmdDWVQrNys5ZHZDOHJpU2tJMVpnVkw1dDRCMUtsZWV3?=
 =?utf-8?B?aS9QNjVRNW9qcFFkT3laQmFjTlhlTnF5YUhnSk4za0JmODlpVE9MbUFocEt4?=
 =?utf-8?B?TmtwRjZxeXJab2FaRWJpbEp5azNuS3dqeVIyVExqZCs3UlhVZnlGMU81YTB2?=
 =?utf-8?B?SnRxY01QVVVOaWRoaDAzNVNHU2pUTzZnOVQ2YzJXczNISDg4VmJONVFINTl3?=
 =?utf-8?B?SnY2a2JTajFIUTdmZmVyRGd4dTF2WWZydndWREdmQi9uU1NodHM5bExWdVdC?=
 =?utf-8?B?ZFh5RGZ3UjMvUVRJbS9lcGJQS3VlNUNoaFNBL1dwQ05qRzFPQkZRbURVNWIv?=
 =?utf-8?B?R2J4M3NzdTdRdG1KMnNwa0lkUlJUK1BCb0xSS3VEdkNZcmpSb000U0xrWnl5?=
 =?utf-8?B?RWExUGFNVGQ1aDNVM0xiMUpyc29rcDE4QndWZ28vZFhLcTdRaUVuRk42Mzgz?=
 =?utf-8?B?RzRpUExUUU1Yd21aQURndXFkdVRYTGdmT1NWSFFEZ3dWZFowaFk3ejBleCto?=
 =?utf-8?B?cFBuNy9CYkxIejdtOTZrMU1JZ24xQXp2S25CUm10WVJLN3pFVlc3SHIweE1o?=
 =?utf-8?B?clFjQW1IUkNkNjRoV0JNZUhsSlVGWm9wV1JiWFA1SzRrdnR4enJLRUxOK3dD?=
 =?utf-8?B?cGFROFlIYXRId2FlTXJBMEdESlVYY1pybWNGbFZRODlDWkc4Rmp5ZUY0cFlu?=
 =?utf-8?B?K3NzcVlaM2laS0Eyd3hOMnhFZWVZRjFna3piaTR5MzMydlZhekE3ZXJEL3pZ?=
 =?utf-8?B?TFE5VEhZTGp1N3VBcmcxVllOWVpUdG9HK2EweU81NXkvOWhPUFNod2FxV3g1?=
 =?utf-8?B?TUowV3Nxa2hVQ05OeG0vUndtOHRSMHlGb3pQdXRUWmtISjBOV2E1ZjJNbmlP?=
 =?utf-8?B?SGZnd1F0Tm5iaWFoa29Uc0hXMjVQNWRRY2NpY3NmZEhVYjU3TWxBQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ec7a00-d004-40cf-6d21-08de8bf603be
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 11:43:07.5536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwwKluEeG4L3dshU3OU5z3Zg3zk7MzSM9iYl0sonyDfzQ3QdtdMAK1R7qR5nWH/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-9690-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michal.simek@amd.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: D3B74343A5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

+Suraj,

On 3/25/26 15:22, Rahul Navale wrote:
> From: Rahul Navale <rahul.navale@ifm.com>
> 
> @Xilinx/AMD maintainers:
> 
> Quick status: the ASoC playback regression is still present.
> when 7e01511443c3 ("dmaengine: xilinx_dma: Set dma_device directions")
> is present. Reverting 7e01511443c3 restores normal playback.
> 
> Could you please advice the next steps / preferred fix direction to address
> this regression upstream?

Suraj will take a look at it soon.

Thanks,
Michal

