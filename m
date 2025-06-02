Return-Path: <dmaengine+bounces-5298-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C38ACBAC9
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 20:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A363BFB7F
	for <lists+dmaengine@lfdr.de>; Mon,  2 Jun 2025 18:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55B5225A37;
	Mon,  2 Jun 2025 18:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="G4tvZ05o"
X-Original-To: dmaengine@vger.kernel.org
Received: from PNYPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19010015.outbound.protection.outlook.com [52.103.68.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1D227E89;
	Mon,  2 Jun 2025 18:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748887653; cv=fail; b=iZ1VLm7Fvw7qb7vyCYXg2nrmAcwji8DoDB494XY8p3Wk0rabsRI5DgQ9aXPHCcXvsJWYiKMzW2PiuX7Y396dY+a897+mWprFJURDN4h4342gJowMdQJut03NIHKSirGACyXXNExKBj2uKozaE0tQIdwKv3a2WlAHuMQRWloXEtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748887653; c=relaxed/simple;
	bh=Sy4oQJpeYQ5dKsuwHuIM1sSSI+MjJdqSqqguTeXUfqs=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VJu3Wy4Legz0r+tZRf3LGmnpsVxvNrGKxkMdxpXcn239fRTRhZ14dK8LO7o7rkOHv8Hl6uF4o4ZsaggV/iwl9lKkvgoBk2z7o6pGhgwqydKfUKSDD05Plkvp1QKs+VoH+ILzkxdiVYk+GoZJGlJC5iUQNh5s7XFTpUaAGRmQwDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=G4tvZ05o; arc=fail smtp.client-ip=52.103.68.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xYPPRWGEyDnQGgh4x2o+mcMPqdyQz/Nm3NS6RwcgWRtHOQp0+48ZNrrxGb0FzLRbyZMuVH1Ctt4tCziXRrYsXiCricpWicSWE6rNZSpDv80YL0gvACRiMEv3JIrWgPBZzzeDt0RRFest6CEoOAIGQuwDpGZ4I4JJy6CtWb33sk67gy1ljpZ/5rkYImzDjxKafO7mCX4A5N316jEPh2b0SV+GHCIxyn4qaS6Bwp9j5HaE1ZGUNfg/A6MF0kBfW2NDhbXBu6uibG0n5RhhrKmi1iAyfHoLFn50DIG7kE5h+oq+qnnrBdZGdgiqIRw+9zZUn3ReiwjT/LEA+Z1doEg50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2iWdLG+7Hm9FahIX/F/NfF+xWi7H/4aCMm8WdehO8Ds=;
 b=Y6x1njfaAv+PtIdk+CO3JcDE2kT63yJX50aQjyWQarbdf3GczEoroyUOZkZLHtMFGo1E2IgGjdb9XBdZhPk+Fn4qHdvA/PSzg4g8arl50e8EYp/L9P9nxt0dmwCO57xW5zbcVYklecSy/+Fm31/69MQRaxddf0fEHDbWRusn00Wuqw+t8qc8HSNdNHJtNnVjxl7jGvrVkl9ZzG9Gp9LX2MXPKi2LKVoGa5BHGvCB/vhrOEPLYek3Wvr3aX8AbbphgZt9Z4eRGeM/PpD1dLwQamJj7kh3nBLMbP17wat2mL9wtFuixLHDdMnE5COFCF+WCje4qWN+ckueyfCRe1ByBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2iWdLG+7Hm9FahIX/F/NfF+xWi7H/4aCMm8WdehO8Ds=;
 b=G4tvZ05o1PiR3/CpaavliZaOe6XGMgU82RNCZ079XnFyOReIDkc3pXyzUiMDfh563njKo9A/SZTz1xY5cex5WrjLXE7wPEnqMVNf398wUWb0eU+sSM2HICOY7yhEm4gYoGMV0FtGfRn0RVIj/9kJVyQdewTAq8IcjlUG7SDrtND481H3alpNU4ppo22zd6bmw1tz6EG8Ido7jsc2iFPbZAczSmb3QM2rRneTTMSMT8VbY9w7rNFDYBN/U1K7z63ueJU40RAPQDTaYrEXqPUdRvFZwKX7+QgQTkkFmKqtDpiM5L8LT6XlMCLDVWhwq5oncIb+kt08sft0yn2QatPa7g==
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:f7::14)
 by PN2PR01MB9411.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 18:07:25 +0000
Received: from PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77]) by PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::324:c085:10c8:4e77%5]) with mapi id 15.20.8769.038; Mon, 2 Jun 2025
 18:07:25 +0000
Message-ID:
 <PN3PR01MB9597F96188E061EB0B7ACBD6B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 2 Jun 2025 23:37:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Re: ELAN1206 Touchpad Bugzilla 219799
From: Aditya Garg <gargaditya08@live.com>
To: agski33 <agski33@proton.me>,
 "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 dmaengine@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
References: <z9A_-FfhGGSZqAHPl-DnF-qPhbI563CsiUUiC8nhdhcZUZYkgpkruvHQ6Vdt8Jt0s0ogm9tCNXFAfn06utR9Zwh_UNTUy4whJ2Z9oVcfPEA=@proton.me>
 <PN3PR01MB9597C74E424033DC90B6F3B2B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <PN3PR01MB9597C74E424033DC90B6F3B2B862A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0158.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::28) To PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:f7::14)
X-Microsoft-Original-Message-ID:
 <f5c6445a-c3b9-4b65-9cf0-7ff1713b278f@live.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PN3PR01MB9597:EE_|PN2PR01MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: c43bb029-f09b-4c37-5565-08dda2005419
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|7092599006|15080799009|8060799009|19110799006|12121999007|5072599009|6090799003|461199028|440099028|3412199025|4302099013|10035399007|1602099012;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RXdsWk1seENPcVhhWlIrVi9meEJKb0R3SVVPYjdwOUViRUdqZm1RT0Znc0lx?=
 =?utf-8?B?cWZsYjhOTk5wODFaYVJCdERjWXBnMHZucWdpbVlvVGdDZ2QyTzMyY2FVL3o1?=
 =?utf-8?B?cFJXVjRHTzBCMUc2Umk4NTBwT2NhYnVPY0FXcURObEt2cTRPOWU2eG5jL3Mx?=
 =?utf-8?B?bllkWkRHR08zb2JVa2xUbUlsNGl6Y0ZxeFloVFdmYkFKM1lDbkpVUFFGR0Z6?=
 =?utf-8?B?ZU5tdWN2Rk92WjJDU0M4WFVObEV4ZktnVVUvMnc0MDFLZmxmOFJOQXlQbERI?=
 =?utf-8?B?bitrRjFuMDZJZ2lxYnJSbHF4WkREb1NTMUpiWHNibDNkQkRpZnhNbWFIZStk?=
 =?utf-8?B?Q244NHV5UU80ODdYRUxBSWFCYm50VnFzSEhCcjNMeStCSGkzRDB0OWZwSVJU?=
 =?utf-8?B?c2M1RWo1ODZ4Z1pzQmVZYk1FOUxad2FVUFZwM3d5WnMvR0k2ekhXbk53aEg0?=
 =?utf-8?B?R1lwVjhzTVJ3QlNYbmw0ZXdKcXo3MjFJbVB6dFI4QjNGU3lubTlVVVgxY0dk?=
 =?utf-8?B?RkFNQXU2QVdGT21vemZGck9sWXF3UWZTMUJMeFV0SGwyYklxMlp3ajhKdFli?=
 =?utf-8?B?WkhGd1o3RWtNR3dmQ3dmYzl2RTU3QU5ES0FsTEZrS1ljRkk5UStCeTBVdjh1?=
 =?utf-8?B?bTFxMVNhUlZjakNDME05L2hRUTduTXhUOXBMQnoycUFKZ1F1WTZWOUZCcnJt?=
 =?utf-8?B?dDFDcTdRYUpMS1p4blc1L2JTWE9IeThZR0lIVERWRFoxVjFaSEpUMHh4VmNl?=
 =?utf-8?B?UWxBMWdZQm8wQzRkeHBMdVM3OERQUjJpYWg5QUcrdXhQK0xocjAxb0RUTTBw?=
 =?utf-8?B?TXk4eEtPQk9UM3NFTDBmY3lHNngvTXcxRjVDR0lqaURRNXgxaDZVa2lybWJQ?=
 =?utf-8?B?SFY0MG1LTFFKdDdHNGRLWGNkZG1jbTYvQ0ttMXB0ZVl3V3F3UmttWU9UM0RD?=
 =?utf-8?B?SkpsTzVIMUVQZkN4dE4xbGpwRHVDRmNOZFRoT1V5d2lEV2JXTWNFL2tjdnBG?=
 =?utf-8?B?WHFzdjAzb254bFVsb3B0dmVCbXptYnBHekxvZjZnL2VpRVFxVUZFRnJrdEpW?=
 =?utf-8?B?elNsMSsrMnVyWlMvTUc4UEFPb2MwRzVKb2RQcjVoSkY5eHlwdjBLM1p0clNo?=
 =?utf-8?B?MVRGY0JDSW04cmxTUXNXbFljN1czT1NldmQ1VVVib28vSUtBOHl4NlM3dm1w?=
 =?utf-8?B?Z0hyZ3h0bGZNak5WU0FSdzBXeGs5NEdaZy9STzF0eEh0U2Q2Q0JJNnh2NG8r?=
 =?utf-8?B?VmhlUDNUUFpvMkcwSnROZU82QkFDM2haQU5nK0hoQUthVnIySS83MU44QVNY?=
 =?utf-8?B?Y1RiTXl0bEZGSVpLZlp6VVpPQ2dCQ3YvYjNwZnZIeStqOUZjMFdHYTltMi9r?=
 =?utf-8?B?VG02QnU3NE1KY3l1dzYvUUZHd21rSkQ3cHRNM0V6SE1RV2kvaEFNQnVMa3RI?=
 =?utf-8?B?czNxS0FQQjNBbUhpa1FYS0g5UXNTKy81T1VGRURDb2VvdHdOdHl1U21vVUFw?=
 =?utf-8?B?S05nQlFERHdma3ZSUUt0NHlUTmlzUkRxUW04UXN2NTBLSGJyWUtmdFRGVGsx?=
 =?utf-8?B?ZnRuajY4bVFBZk95eVZYTy9jMFkwNEYxcUorT0VIOHI2Zmk1Mmg3bW51UHZy?=
 =?utf-8?B?aFk5Q01CRGtKSWR1TWM1WVhmdXhiU1U4MDlNbXFWOVFjVzVJdVV4Ly8yd0dE?=
 =?utf-8?B?QmVFRnVKd0NteGVlN0ZzSFF5L2Y2L1lsNjlFOCtPdjFOU0hJbVE3RHFNUzQ3?=
 =?utf-8?B?NFlWQWgwQmdFVGcxbWpSYml0aTZiTDlKK25sdnVuaG52WW1DV0YzanN3WE1k?=
 =?utf-8?B?b1NpNWV2bDF5cXVFR3RLQT09?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THpUSURyL0wzZ1h6dDA5UmpTL0J2MGtRbWtwajF3c1NvNFNKc2IvWmY5K1d1?=
 =?utf-8?B?Z09yRjl5cExHdy84bmZzQzNMWjd0OUY5dDhUTHZFd0djRmxZd3B5N2xKNGtF?=
 =?utf-8?B?YXllRHV3QUFkRXNmNStYRWZZUW1HajBYWGQraEtQcWZqUmhwUnp5WTBQS3lx?=
 =?utf-8?B?RE5JSStiQ0huNWN5aFc1bkJ2SjhncWpWQ1QrelZRWjZxdWNYTW1GQTN1YUwv?=
 =?utf-8?B?VWR0eTNJL3hnbW9zTnRvaGZxY1dTc0ZoanFSVitzbjJDc0xsVmVUazNUbXho?=
 =?utf-8?B?Rys1WUhlaVlxc3lMamN4bVBVZjlPZHp4V2M0TGxsTW05M1RhNUkyMkU4ZUZy?=
 =?utf-8?B?RjhiWk41ZmFiYm9VOCt5ZUFsNklRNGpvVmlaNDhHYzBGdERxUmx2WjVUSHpo?=
 =?utf-8?B?VlQvRjQrNkZhTU43NXJKYmpUV2lWcS95a3dLc1pJVUtTaUpHWjRJT2kvSUpD?=
 =?utf-8?B?Qk8wVEE3eklhUjN6c0IzMTlvZjFlcWtnaDdjcjYxTlhhNFRDVVBFaE5yOXlD?=
 =?utf-8?B?M1JOdnJlS2JxdTZ6RDFhczhQUEZWeDlWWXBLM0dsR0EvSlU1MmJGbWlLQ1Y2?=
 =?utf-8?B?ZEtkYzNmVmMwMXMzd1EwcGVqVnJZZzNMWVNLLzJibGFSVGV3ZGY1VVR5L0Rn?=
 =?utf-8?B?dlhHaUFScXdLd1h2MDlmYWtReUpoeHdHYTE3bWdRWjZ6NW5LTTBkdGN4blkw?=
 =?utf-8?B?c3F4cXpZN3ZiZE1vN1hhNzg3b3RlbEE1MHBmQkRPOXFIcFFnY1c5cDJub09q?=
 =?utf-8?B?N0NHNDJlYmpOZDd3bC82QTIyOXZFcHpjWUN4OTh5YkhWTGdLcmxUTWF3OUxE?=
 =?utf-8?B?aFpFKzcwSDczZWlJN3NZaU1KSFdsdkx5N1BvVEkzZGgvU05WWDZiemtxSzN0?=
 =?utf-8?B?bFE5NXlGUDdXVERNeitubjlHMXpDR0szL3liUnNPSXpTVHdXeHQ3a0srQnhu?=
 =?utf-8?B?Y1B1K2NCbUkzS3dXUTJQVTMyQS9RYTVMVWdDVVA5M2NwTDFnZEwxZkY1Y3o1?=
 =?utf-8?B?ZnJYblRHRWgyb2UvK3VGUnZEdFdhS2Q4dlUzSzc4ZkhjV3pueC9LWEhJOVBv?=
 =?utf-8?B?U1pNRjJnb0NkRkNMQm04U1M5MXZZYWl4QWJVRXpoK0FrbHN6cmN5V2hpMDRQ?=
 =?utf-8?B?THdLUDFkck0yRU1obzRHUmNtL0orTUt1VVJmOWhsUEo4cnRyanRmMTBhWHo3?=
 =?utf-8?B?L2NkOHF3TEJOMmV4eHJmSHJ3ei92OVpSR2lSZGJsMEx4WVVKalhMaW44RHUv?=
 =?utf-8?B?Tk5FZWl1SWE2WHUvbWJ6bEI4NzRDWTRHWlQvY0VWUU1sMUUvL1FwVU1qM2NY?=
 =?utf-8?B?bkNzQVRKYUkvc2ZOVVRxVXZOOFo2SEhzVlRONFE0ek0vbnkweVBGR1NBUUtw?=
 =?utf-8?B?RFV2YmZFNlpzQWZFSkJWaGh3UVp0UjI2NWhUMGY2VGRqZng5QnFSVW00SXNt?=
 =?utf-8?B?NHE4eHpQN1ZaVzFvcHZUZ3k2TEpUaGNhdzVGdjNvbUYrNHNhWVNnOGVNZUpE?=
 =?utf-8?B?ZVlHSXZxc1dIaVFjVHpsRStyWE80YnJ3LzZsYmx6MEdHUDF3b2UrVEhwSENT?=
 =?utf-8?B?bGVqeWhES0gyaWFrRlRWU3ZkQ1RNYjltWnI3bEo0T0tqRGlvTlRyUDlyL0x1?=
 =?utf-8?B?Q1B2dFR0dzg5RzRabnNVTmhidk0xRVRhdVBNSFlhZ0tIOTY5ZTVqUjlaUFdS?=
 =?utf-8?B?YktINmM2Q2hHU0k0VGQvc0g1R1JBYlFRU09sMEZySTg1THBsTUZPdjhBVEY1?=
 =?utf-8?Q?dn0rTq5oljE+nqTnXs=3D?=
X-OriginatorOrg: sct-15-20-7719-20-msonline-outlook-18ccf.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: c43bb029-f09b-4c37-5565-08dda2005419
X-MS-Exchange-CrossTenant-AuthSource: PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 18:07:25.3617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2PR01MB9411



On 02-06-2025 11:35 pm, Aditya Garg wrote:
> 
> 
> On 28-05-2025 07:44 pm, agski33 wrote:
>> Hello all,
>> I am currently experiencing the issue that was previously reported in the following BugZilla entry: https://bugzilla.kernel.org/show_bug.cgi?id=219799.  I noticed that the bug was marked as NEEDINFO so I attempted to fill in the relevant information.
>>
>>
>>  From my testing, it seems like IDMA transfers relating to the touchpad input are taking too long and causing timeouts within hid-multitouch.  
>>
>>
>> I contacted ASUS in an attempt to obtain information relating to the workings of the touchpad that may assist with this issue, however I believe it is unlikely that I will be able to obtain anything useful from them.
>>
>>
>> I am wondering if anyone has any additional suggestions for next debugging steps or things that I may try - would be happy to provide any additional information or do additional debugging etc.
>>
>>
>> System Details:
>> Device: ASUS Q528EH with ELAN1206 Touchpad
>> Kernel versions: 6.9-rc6 is where the issue starts, persists through all kernel versions after including latest.
>> Symptoms: Touchpad cursor will not move.  
>>  Additional Observations: Something of potential interest that I noticed was that it appeared the touchpad is sending data byte by byte when doing an IDMA transfer, not sure if that is normal or not.
>>
>>
>> Any suggestions for next steps are appreciated!  Thank you in advance for your time and input.
>>
>>
>> Thank you,
>> Aaron Gdanski
> 
> Looking at https://bugzilla.kernel.org/show_bug.cgi?id=219799#c2, dd4478d63b6a2b6891fcc1800eb26ce3f1ead1d4
> seems to be the patch causing regression.

My bad, its 9140ce47872bfd89fca888c2f992faa51d20c2bc, the mailing list link is correct though.
> 
> https://lore.kernel.org/lkml/20240321120453.1360138-1-andriy.shevchenko@linux.intel.com/
> 
> Ccing relevant folks here.
> 


