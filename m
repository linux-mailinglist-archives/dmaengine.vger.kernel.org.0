Return-Path: <dmaengine+bounces-4007-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA25E9F4DAF
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 15:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F36F161277
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2024 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C631F4E36;
	Tue, 17 Dec 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o822NvaI"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2049.outbound.protection.outlook.com [40.107.104.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5393398A;
	Tue, 17 Dec 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445695; cv=fail; b=D5ItP1VLpJFNhwuQuKHGDKUOIlUSDwVI3kwQ8FRkfhNg8ORqxIBEPj6yxG09qdDfKo+TgeCRVZK9y6KM0GN7NAeDSSZTU0d3ylzmGsbmXYt4bUv42aXdH/g/WkQ5C57UTW8/cQlvSB6zJyvYBgZFZCzrRPQPjbQiXKkoHZHfZq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445695; c=relaxed/simple;
	bh=9Z08oROacNV4nirtpZATlmT89hLj5fUKYRelHLe4jiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rcfv1zqrTl8b6E0n4B7PvT07tOpVGPgrXlITWmeW6BRjvFoEv4/S2wlBv7oU3fQa72BRQENI2OlfjY4O7w0nnFrFn3bfYMb4NigOFOhxzEJJMi2tNHwcF9CXlWClXbBzrOq8EwRPj8M/sQWIUfd1H9PeREA4XIuIgDA7An8LNuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=o822NvaI; arc=fail smtp.client-ip=40.107.104.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EYP/z+x/fYiOmqoUsbwhk+YkeWQvtKxdblziQUDhK5cQVI+5FOXKjza0A7O5XuZmZkYA0AxPwKDKXLRGF63ylV/uWx9eQwbCmkteKvZb2tzkQGJ5/OMulKre5+efeXdHb1JDiTxjcYxeTWq3YOfVd/uHdu8gi2Z35u90SbmANbb+wI+UU59D2whd5e8CRteNlJZ/z/n7ohnL8Pi9Ubr7sR0HSXJFtrhUocMrkfwFEAU3OJ43Lw0gUaVO4/P7vRe9Gj40RY8Ezm62/ZcOwUcuZ1XZrwvk+P/iK/PMuWqNRnfK5WpAjx6Hu11czCQ0sPsmanXowMu1WJi0q/qwu35Okg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsnNi75ad2gJTEJD8Itv6fa/W+pVoM2RqY7ER9n9NOo=;
 b=x6GzajmYIgyEmlh31v58O3F3qiOec26ExXg2zPmMc9m3cFKbV+7qnQwx7IzdzLmtDrv06SHk9vkWHZuSK955PZPiT2nVvRp3nEZxe3FcI/Vwey0hTscULI8ZuW83ssWFiIIZkvWj/yqH1aP6sXjSKrzCuXk6U76t2C1qr98LJ9PVQtWTBxcFJMZlFZQm0slBiZEGDufR2zkZyeMHnqcs3GCJes1zSkN7T4KaMqmcL45YsoxWodCD1G6tv9sk1l+dnpymcm1vU1LmVS9TszYdw0dMNzOaVvoYYBQXgXF+nqfjNwKHp0j7RKo723IDZLXh0Z/IAJDr+8+dV3KP9VkJyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsnNi75ad2gJTEJD8Itv6fa/W+pVoM2RqY7ER9n9NOo=;
 b=o822NvaIWQyv5eHacS4eewwSJimTyeGUoHTF+9+3ARJDRc3iYChL2ePmn+pWrXS0G00oMeavSuZ68ft4cYb4OlzzCLpp0e/Ageb1HA5PZQkqUO3kHOmqv1EM10Ud4xVyazTC6WMPQ6cyKAUsaItmqhO1YgBL1rihBRK49B6znBnUULTo6pFa0JtzuMU4LunoRQ0pVVT8Y7JOutZn7n9R7cRnKeFDFpV+Rpt1OgBxj0e4W1xhrvngNo+EiZadb0WconQ0e7BSRhsyXp5pLC2uOXAKKHgPjETHmg4YRYsIcd+s2n0yKuKvP1AuuqxcFyKvsKGPcGK2bZMvkv3pgSDkeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::17)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.12; Tue, 17 Dec
 2024 14:28:01 +0000
Received: from AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7]) by AS4PR04MB9550.eurprd04.prod.outlook.com
 ([fe80::e28d:10f8:289:baf7%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 14:28:01 +0000
Message-ID: <fa6ee270-52fe-44a8-ae31-4a2a88604a70@oss.nxp.com>
Date: Tue, 17 Dec 2024 16:27:59 +0200
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_3/8=5D_dmaengine=3A_fsl-edma=3A_move_eDMAv?=
 =?UTF-8?Q?2_related_registers_to_a_new_structure_=E2=80=99edma2=5Fregs?=
 =?UTF-8?B?4oCZ?=
To: Frank Li <Frank.li@nxp.com>
Cc: dmaengine@vger.kernel.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, s32@nxp.com,
 Christophe Lizzi <clizzi@redhat.com>, Alberto Ruiz <aruizrui@redhat.com>,
 Enric Balletbo <eballetb@redhat.com>
References: <20241216075819.2066772-1-larisa.grigore@oss.nxp.com>
 <20241216075819.2066772-4-larisa.grigore@oss.nxp.com>
 <Z2BSn91PDfwKOc8s@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Larisa Ileana Grigore <larisa.grigore@oss.nxp.com>
In-Reply-To: <Z2BSn91PDfwKOc8s@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0200.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::7) To AS4PR04MB9550.eurprd04.prod.outlook.com
 (2603:10a6:20b:4f9::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9550:EE_|VI1PR04MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e1cdd1-320a-45a5-55d5-08dd1ea702c1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXd4emJhTmJkM29CMWdibncxcEdQSkpIRy92YUZ1aFZRbGNLYWZVY3ZuSWll?=
 =?utf-8?B?Y2kra0p3L2hmS0pHcHdoM1h3MHNYTUtTWk5hRHdvNXAwbUF4TTJPVjFGZndv?=
 =?utf-8?B?bTBkbTdWMlRJVDV3dm0wNGdFeEJTMzBFdDVtOWVrc0prUTV3V2ZGOEZTN3di?=
 =?utf-8?B?UmxyY3h3VkYvVW12a3UyeGE1MGcrQzBZLzN2Q1NaSEhNM01rVnBkWi9BaVcv?=
 =?utf-8?B?VEI4dllvWG9ZODh1MmNJYXFadjZlbkZYVVY2d2I1Mi91R3hQRDNKNzhFc1M4?=
 =?utf-8?B?NjdjNitnRVU4ZlU4L2ZDWGpKZFlIZ3doR25zM25jbThXODdwTlBPbTQ3aHVT?=
 =?utf-8?B?aVI3dU1ERHZ0VmRCdXpnREU1RStGNzdZcjdkQ00vUzJ5RlMzUTNhaHA2MCsv?=
 =?utf-8?B?SGZqZk9KT3ZoczhxR0VjdDBOdzVTZ2toeGIyemdqeFVXY01tNDN1Q0VibmNB?=
 =?utf-8?B?YUFRTXd4SVdIRjJtRmtQcW1KRHVoaTFUeXJpM29NUUlxOWM0a1pRZmJlRWJE?=
 =?utf-8?B?M1d0SWo5eWdqUlh6U2xNUVlxNHEzMDNCbE5tam5tNW5vQzVtdEhoRkhnYXlY?=
 =?utf-8?B?c1cyaFFMMEsxdEwzM1lnL0JRTDdFWmphbWZQZ293R2JRN2ZYOUpaeDhEOGZq?=
 =?utf-8?B?SDBMeWc2RFU1SHlZajJaZklRS3Q0WmFkSzdlOG15V0p6VEc0cVBaaFdrUUlF?=
 =?utf-8?B?c2VwQjNLYlU2bmtqUlkwbVFiM3BFWFpYK3lYVHlhS3hoelZwaFpqZ21PbWdu?=
 =?utf-8?B?K0piUU1wWWVNRXBCYnNtYklLd3ZNTmtGZUFJbXBFUWVwVU1IcFJNN2dGT2Jr?=
 =?utf-8?B?UFlON1o1TTh1SVByZTBIOXdaM05ibXRsam44TWJhbGhTMUk4N1FQbmFuK0po?=
 =?utf-8?B?SVJaSHJkMkJVVlB0c3lOVjhWck5VNzRpUVE4NkMwSlEveDhJaVE3Ylo2WnFu?=
 =?utf-8?B?TFZJOHA2aGtDMmluOVBIUE5zZWV0REdJL29oOHNRZE9hVUhLTEh5cUllYXQ2?=
 =?utf-8?B?MU84MVlWeWFYeW9MWkFQYTZzZjltdzZzY1FNZ0ZyTndRSXJGeVBGT0hOVmk5?=
 =?utf-8?B?b1RjN002T000SkJCV3pPVStySWM5dm5ZMnEybUFRbUhGQmFRdk5LdWlSbGty?=
 =?utf-8?B?cXMxTktmVUExNWQwV3lxWXZiWVhka1lkQUV2ZHBCS1BxeFlHUzc4eHhkam5l?=
 =?utf-8?B?THRsN1BPS2lMMTZWM2ZVV01jWnc5VG5YcEZOcERlSTJFRW14OGxUNkhpaUlJ?=
 =?utf-8?B?QVJWRE1UamxEOU9abTk5Y0dPOWtnZ3EzaHdHNHIzbk4vdFdTSVl5V3k1Y3lB?=
 =?utf-8?B?dTVXVlNPeC9HaUVkeUtKM3pZbU1DdDZwaWtid1FHaUJoTlh6WmFSNHdibTNo?=
 =?utf-8?B?VDhiUUx2L3k2a1lZSmZzanFDRkJ1SmtmelZTdDFoaDB5WVgzejZndUcyTGVP?=
 =?utf-8?B?ZHdYSVljWUE5ZzQ1YXpJamc2Wjcwd01wZ1RqM0k2WjljYmhTelRWYTBsc1d4?=
 =?utf-8?B?OFRJK014VDFKMlR6ODg0NmJIaFRSaHpEYkFGWTBtcy9POVdKcm1IbTRaOHdZ?=
 =?utf-8?B?M21HeXBRL0tFQnVHaXpMK01BazhGVGk5b2JHOEJLSXA0MWdjYnlsbTF6OUxj?=
 =?utf-8?B?OFlFSVZ0VHBDT2xacC9oempFd0xicnNralJraThjUHZjMW9TcUU4bndxTW9y?=
 =?utf-8?B?Z2ZLRzVLS1RCVlBUU3dzSnNnbWkzM09MUWtpNXBSOW1UV1BOdjZhWkY5NUk3?=
 =?utf-8?B?SHRTOFMydnRUbFRrNTN0bllyWEhtVDJkd3g4K3pSUkhZK2Q1ZkpzLzNDb2dK?=
 =?utf-8?B?THBrOFAreHZEV1RPeTVpMUYvTWhGemZZbWx2aGcvVENNQ01IWWRlZktVbkRW?=
 =?utf-8?Q?rDkMs1lzRVJRT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9550.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yk1JUndrQllNc2lBR21JaGZXQ0FUNnNOUUdiSHdkSDI4MEJ2R2xRVWFVQ1BZ?=
 =?utf-8?B?UFpaK0RtNWcxd1ZpVFN2akttQzRhaFdLc2VGZjIzSjNYSHRZQmN2bnpkTC9o?=
 =?utf-8?B?MzUvQ2FGcE55YjFYSkkxS25TMFdqZndKcEpVMFBuLzFsSUtsYWRnQzYxQk1X?=
 =?utf-8?B?MjZsZFRyS3VabSthOHVyaHRMczJtekg2OWtNc3V3T3JQNzJ2TFJrNE5vTExY?=
 =?utf-8?B?QXl6Tk1FM284R0VnM1dHK0dkNnE3TnZFMmlqcXJKYUFYc2FzU0Y3TEJLY3Vv?=
 =?utf-8?B?cE9IaHJuQVg1a2xSZ05oRzlzbWI4V2tRODlKUkRQQXcwTW9URERxYm5MK3p4?=
 =?utf-8?B?eXRPR2dldjRhZEhzVjZ2RzNEc2FXUGRscFZMNnVrSGtXZDlEUUJMNE5rdEVK?=
 =?utf-8?B?LzlnVlBrR0psckRiL0hYM2oveFgrTlhLWk5oOVBrS29RWkcyVnVQVE1KemU5?=
 =?utf-8?B?Uk0vV1N6ek5IQ2Y3RkdqWEF6V2JpeVlTakVHZG1PeC9JNjh6MzUwc050Ull2?=
 =?utf-8?B?ck53ZDF5dnFCcS9MT0V0d3BGSnVZNTNWMDhSdU11SUl6dlpkNGJkQXRXZ3c0?=
 =?utf-8?B?SVh1MWI0SkFPWkF0dWpDQWRoM0NDNDFVeUZ4YzAvTEpQWWJzQ0haRXNBdXdy?=
 =?utf-8?B?dGpOY3YrYmRzUjRSSURoNUJoYkVwZ0pDaEkvcDZtSWdCNEwvOURhSnl6TUpX?=
 =?utf-8?B?ekxIU0UvNGV6djNIcTgxL2pCOE1INFpZbExoWEorRXNpL2VjR3NNUENSMjFm?=
 =?utf-8?B?WkNCRDJYaUpXbk5iM3pxemxYNXg5L3U5ODBZU21yb2hvSkF2dnNKQ2ZYR21t?=
 =?utf-8?B?RzdNeFZydXlnWEN6ekpsZDdjanlFTGFMQjk2OFZqazREc3RkQ3NtWHVlOW5J?=
 =?utf-8?B?cDBBSWltSnZwMi9hYkdyelJ6b2trOWs1NnZNTkVuYmZpQ0hRaXhsbzJDSDNj?=
 =?utf-8?B?U2pzUkZ6NGlQbUlSZTBkeUVtcks0UzNEMXppTkZHMW54SFJuaWNXYlg0OE9i?=
 =?utf-8?B?QlB3cDA3VnpYVWVRTlpBa2lyMC90MWdiMy9vZVh5dlBFanFBVWdld0lzTzk0?=
 =?utf-8?B?RllOb0N3MDlrQ1ZhbnorSXVyYWRCcWxSd2cvcHB4SWJ3bzdDZW1vS2NLNUNF?=
 =?utf-8?B?M00weWNvZzN4WS9IR2tpelp6NE5OZko5WmtkRlprNjlCbDdsaU1JQ1hJM0lR?=
 =?utf-8?B?TmUvaS9zSDZCNWxXZnRLMmh5MnRhSkdhRno4NkVPLzhmWkE0Z0pRZG40bUpD?=
 =?utf-8?B?UHN1RGdzby9XcGY3akV1Qmg4MGFNQlREVGo5ajhPck5BUjJKVkVqb2Vic1N6?=
 =?utf-8?B?a0VkV0R0Q0wzU1hxRG9VMkpFazc2eUJkVjZIdUVwWXNGYUNkSTB5cE5kZkxL?=
 =?utf-8?B?d05zRzdiRkhqTm5NdVYyZ1p0OXRXVmZGUkpnWC9XeUVxKzhObGlwT01lYld0?=
 =?utf-8?B?aFVoSm00WktwRElQMis5MW1TNVEwQkZnMDFzY2huSjFCKzVhQWdNVlVtL1dl?=
 =?utf-8?B?L3ppOGQ0RWRjZHo4NXV4MXNiTlRzeTB0S05ReXp4WUg1c1NRdFZ4eER3TmZp?=
 =?utf-8?B?V1FpTXNtZ2hKYXZSbEd6RjFyUDVhODl1TjZuVnpRY0liU3Q3cEhqZ1IrTTBi?=
 =?utf-8?B?OWhtenVRZ2lPZm1VYlhCem1nQmZLV0NtUmgwYnFRQkRjK2REektpelVsbFFm?=
 =?utf-8?B?VEVwT1R3N09DM1NjK0paeTdCNWwzL25LMlplaUt0V1E1SXdFK3gwNmVqdDlP?=
 =?utf-8?B?R1UxQldqOXdXK2s1QVVueEJramVTYktCOU9XT3JqSXd6Z3Q1UU8yc29raHlX?=
 =?utf-8?B?NUM3RFNKSlVjTE15d1lhRTEzOEJkbFlyOGwwOG9mdDZpODQreDE3bXZyenlr?=
 =?utf-8?B?a3QxdnFTTkZJd1lGSWpCRGQwN3g5NktWUG9La0FnT21SQkJpMUw3VDNQei9h?=
 =?utf-8?B?VFJUaldtalBqQm5LeHpNU0hVRDNESmhMMmoxZjgzNWRpYVF2WUg5QWdtUHFy?=
 =?utf-8?B?dGZDbjQybUpTRHRoOGY3OU1EbHVoS2NCRUc5dzUwdm9xdy8yYVpoS2orWVZE?=
 =?utf-8?B?TDJTdXZYei9WRjFqT2ZsTWoyMDhUTC9mVDlidlp0VmZYUUtJamI5KzgvZTRC?=
 =?utf-8?B?ZnltWkFqTEJCdmwwY0x0MmdESm1icXZVRVhzaHJ0ekJwWG1sWHpnNktLWUlj?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e1cdd1-320a-45a5-55d5-08dd1ea702c1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9550.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2024 14:28:01.2390
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTpnlx/fUwSBMqHEMwt/dOPIhAQs4qTQR8KfWM7ONCUDPUQayzeH8umLdkx2EIVy9fjUqW8JBw5fTtpdkvARNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926

On 12/16/2024 6:17 PM, Frank Li wrote:
> On Mon, Dec 16, 2024 at 09:58:13AM +0200, Larisa Grigore wrote:
>> Move eDMAv2 related registers to a new structure ’edma2_regs’ to better
>> support eDMAv3.
> 
> nit: empty line here.
> 
Thanks for your review Frank! I will fix it in V2.

>> eDMAv3 registers will be added in the next commit.
>>
>> Signed-off-by: Larisa Grigore <larisa.grigore@oss.nxp.com>
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> 
>> ---
>>   drivers/dma/fsl-edma-common.c | 52 ++++++++++++++++++-----------------
>>   drivers/dma/fsl-edma-common.h | 10 +++++--
>>   drivers/dma/fsl-edma-main.c   | 14 ++++++----
>>   3 files changed, 42 insertions(+), 34 deletions(-)
>>
>> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
>> index b7f15ab96855..b132a88dfdec 100644
>> --- a/drivers/dma/fsl-edma-common.c
>> +++ b/drivers/dma/fsl-edma-common.c
>> @@ -108,14 +108,15 @@ static void fsl_edma_enable_request(struct fsl_edma_chan *fsl_chan)
>>   		return fsl_edma3_enable_request(fsl_chan);
>>
>>   	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
>> -		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch), regs->seei);
>> -		edma_writeb(fsl_chan->edma, ch, regs->serq);
>> +		edma_writeb(fsl_chan->edma, EDMA_SEEI_SEEI(ch),
>> +			    regs->v2.seei);
>> +		edma_writeb(fsl_chan->edma, ch, regs->v2.serq);
>>   	} else {
>>   		/* ColdFire is big endian, and accesses natively
>>   		 * big endian I/O peripherals
>>   		 */
>> -		iowrite8(EDMA_SEEI_SEEI(ch), regs->seei);
>> -		iowrite8(ch, regs->serq);
>> +		iowrite8(EDMA_SEEI_SEEI(ch), regs->v2.seei);
>> +		iowrite8(ch, regs->v2.serq);
>>   	}
>>   }
>>
>> @@ -142,14 +143,15 @@ void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan)
>>   		return fsl_edma3_disable_request(fsl_chan);
>>
>>   	if (fsl_chan->edma->drvdata->flags & FSL_EDMA_DRV_WRAP_IO) {
>> -		edma_writeb(fsl_chan->edma, ch, regs->cerq);
>> -		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch), regs->ceei);
>> +		edma_writeb(fsl_chan->edma, ch, regs->v2.cerq);
>> +		edma_writeb(fsl_chan->edma, EDMA_CEEI_CEEI(ch),
>> +			    regs->v2.ceei);
>>   	} else {
>>   		/* ColdFire is big endian, and accesses natively
>>   		 * big endian I/O peripherals
>>   		 */
>> -		iowrite8(ch, regs->cerq);
>> -		iowrite8(EDMA_CEEI_CEEI(ch), regs->ceei);
>> +		iowrite8(ch, regs->v2.cerq);
>> +		iowrite8(EDMA_CEEI_CEEI(ch), regs->v2.ceei);
>>   	}
>>   }
>>
>> @@ -880,25 +882,25 @@ void fsl_edma_setup_regs(struct fsl_edma_engine *edma)
>>
>>   	edma->regs.cr = edma->membase + EDMA_CR;
>>   	edma->regs.es = edma->membase + EDMA_ES;
>> -	edma->regs.erql = edma->membase + EDMA_ERQ;
>> -	edma->regs.eeil = edma->membase + EDMA_EEI;
>> -
>> -	edma->regs.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
>> -	edma->regs.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
>> -	edma->regs.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
>> -	edma->regs.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
>> -	edma->regs.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
>> -	edma->regs.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
>> -	edma->regs.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
>> -	edma->regs.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
>> -	edma->regs.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
>> -	edma->regs.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
>> +	edma->regs.v2.erql = edma->membase + EDMA_ERQ;
>> +	edma->regs.v2.eeil = edma->membase + EDMA_EEI;
>> +
>> +	edma->regs.v2.serq = edma->membase + (is64 ? EDMA64_SERQ : EDMA_SERQ);
>> +	edma->regs.v2.cerq = edma->membase + (is64 ? EDMA64_CERQ : EDMA_CERQ);
>> +	edma->regs.v2.seei = edma->membase + (is64 ? EDMA64_SEEI : EDMA_SEEI);
>> +	edma->regs.v2.ceei = edma->membase + (is64 ? EDMA64_CEEI : EDMA_CEEI);
>> +	edma->regs.v2.cint = edma->membase + (is64 ? EDMA64_CINT : EDMA_CINT);
>> +	edma->regs.v2.cerr = edma->membase + (is64 ? EDMA64_CERR : EDMA_CERR);
>> +	edma->regs.v2.ssrt = edma->membase + (is64 ? EDMA64_SSRT : EDMA_SSRT);
>> +	edma->regs.v2.cdne = edma->membase + (is64 ? EDMA64_CDNE : EDMA_CDNE);
>> +	edma->regs.v2.intl = edma->membase + (is64 ? EDMA64_INTL : EDMA_INTR);
>> +	edma->regs.v2.errl = edma->membase + (is64 ? EDMA64_ERRL : EDMA_ERR);
>>
>>   	if (is64) {
>> -		edma->regs.erqh = edma->membase + EDMA64_ERQH;
>> -		edma->regs.eeih = edma->membase + EDMA64_EEIH;
>> -		edma->regs.errh = edma->membase + EDMA64_ERRH;
>> -		edma->regs.inth = edma->membase + EDMA64_INTH;
>> +		edma->regs.v2.erqh = edma->membase + EDMA64_ERQH;
>> +		edma->regs.v2.eeih = edma->membase + EDMA64_EEIH;
>> +		edma->regs.v2.errh = edma->membase + EDMA64_ERRH;
>> +		edma->regs.v2.inth = edma->membase + EDMA64_INTH;
>>   	}
>>   }
>>
>> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
>> index ce37e1ee9c46..f1362daaa347 100644
>> --- a/drivers/dma/fsl-edma-common.h
>> +++ b/drivers/dma/fsl-edma-common.h
>> @@ -120,9 +120,7 @@ struct fsl_edma3_ch_reg {
>>   /*
>>    * These are iomem pointers, for both v32 and v64.
>>    */
>> -struct edma_regs {
>> -	void __iomem *cr;
>> -	void __iomem *es;
>> +struct edma2_regs {
>>   	void __iomem *erqh;
>>   	void __iomem *erql;	/* aka erq on v32 */
>>   	void __iomem *eeih;
>> @@ -141,6 +139,12 @@ struct edma_regs {
>>   	void __iomem *errl;
>>   };
>>
>> +struct edma_regs {
>> +	void __iomem *cr;
>> +	void __iomem *es;
>> +	struct edma2_regs v2;
>> +};
>> +
>>   struct fsl_edma_sw_tcd {
>>   	dma_addr_t			ptcd;
>>   	void				*vtcd;
>> diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
>> index 9873cce00c68..0b89c31bf38c 100644
>> --- a/drivers/dma/fsl-edma-main.c
>> +++ b/drivers/dma/fsl-edma-main.c
>> @@ -36,13 +36,14 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
>>   	unsigned int intr, ch;
>>   	struct edma_regs *regs = &fsl_edma->regs;
>>
>> -	intr = edma_readl(fsl_edma, regs->intl);
>> +	intr = edma_readl(fsl_edma, regs->v2.intl);
>>   	if (!intr)
>>   		return IRQ_NONE;
>>
>>   	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
>>   		if (intr & (0x1 << ch)) {
>> -			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
>> +			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch),
>> +				    regs->v2.cint);
>>   			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
>>   		}
>>   	}
>> @@ -78,14 +79,15 @@ static irqreturn_t fsl_edma_err_handler(int irq, void *dev_id)
>>   	unsigned int err, ch;
>>   	struct edma_regs *regs = &fsl_edma->regs;
>>
>> -	err = edma_readl(fsl_edma, regs->errl);
>> +	err = edma_readl(fsl_edma, regs->v2.errl);
>>   	if (!err)
>>   		return IRQ_NONE;
>>
>>   	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
>>   		if (err & (0x1 << ch)) {
>>   			fsl_edma_disable_request(&fsl_edma->chans[ch]);
>> -			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch), regs->cerr);
>> +			edma_writeb(fsl_edma, EDMA_CERR_CERR(ch),
>> +				    regs->v2.cerr);
>>   			fsl_edma_err_chan_handler(&fsl_edma->chans[ch]);
>>   		}
>>   	}
>> @@ -216,7 +218,7 @@ fsl_edma_irq_init(struct platform_device *pdev, struct fsl_edma_engine *fsl_edma
>>   {
>>   	int ret;
>>
>> -	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
>> +	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
>>
>>   	fsl_edma->txirq = platform_get_irq_byname(pdev, "edma-tx");
>>   	if (fsl_edma->txirq < 0)
>> @@ -281,7 +283,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
>>   	int i, ret, irq;
>>   	int count;
>>
>> -	edma_writel(fsl_edma, ~0, fsl_edma->regs.intl);
>> +	edma_writel(fsl_edma, ~0, fsl_edma->regs.v2.intl);
>>
>>   	count = platform_irq_count(pdev);
>>   	dev_dbg(&pdev->dev, "%s Found %d interrupts\r\n", __func__, count);
>> --
>> 2.47.0
>>

Best regards,
Larisa

