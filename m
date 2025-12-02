Return-Path: <dmaengine+bounces-7451-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 43422C9A3EA
	for <lists+dmaengine@lfdr.de>; Tue, 02 Dec 2025 07:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA14D345722
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 06:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFD72FE060;
	Tue,  2 Dec 2025 06:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="I+qNaJfC"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011059.outbound.protection.outlook.com [52.101.125.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E8D223328;
	Tue,  2 Dec 2025 06:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764656736; cv=fail; b=q4w5kJ9wbUIBXbKiRXlR+gFS00Em6xsNQMa0Nr+QGSz+iriudhKTIlyn8NF7r/ZUjIkB9a0NN1dczaXukMlLydbV27ccQgY3CCVKCapBPFbVQEsRJA72yCv/0EJ6qub1zqomTcV7EGhnE2WjQkBQkrDzl4XZjCDNcl8wSES4R4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764656736; c=relaxed/simple;
	bh=4BMyifLuvHnmV1KOSSOLzCF12Thcs/23Ze5B0iDHAsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHpYrX17WEfzD66vAE1MPpa3fS2xTnClbNLe/CL7Ofni2Kyq1Jsd4S/+BTAneC/grrCAdPeb1Wefs0uHUQX9RComkhK6mgkp0iW+/0QuQVifovDzUpnsFebXskcZqMYMstB5mvB+jaqB5fgPdoSdIpkpxQKsfZBPBfQZfgJeR8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=I+qNaJfC; arc=fail smtp.client-ip=52.101.125.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gPAsVzGVefWTNnrY5t9FXrKIW/VlGN0XPrAo8f1t8iJCe2dX9wzpgz63JYQjhM6E7jzePuPOaH8we3MIML4wpwxelTNpx9hITCZpwr20AXRIQ8+vWmi+TeXUyqYCZ/DDPrLA/kRpOXHKoTQplH2mfbh3Da2qsKTx/hXbxoyr91FnXQMQDnoZjGosWOPnoTtAld4INfW4fkF9f9LOAOG5ZYiQWYpeAa6u9SLuIbXgf+dkkTQmG0We4gayqfKMyWCFlNU5QolJHT8HhD9KEpVguAL6N7cdDG2L4dZRCw5jJU3i1JQFtP5Ctg+kPdjli0erpnP2a6+ETI4wY1SYD09e+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FikFyzwozo6fJOMDfpS3X2NjWL4L52LVmgQak3JOFpg=;
 b=NwUbfUcq3oCQKYmluXdOVxLjHghRXjSkV1XSzu0B7oclnMWzEQ0bMUlT0DnpD7ZrvSpnGhF8vmTOfKHgcQCszCfFVanaaqjVEQ7dvM3L7Wau8rg5o7vXU2Rr2ZdV/+evuPLl1Mq+hjjmNEK243xOMw6r++NH8f4UYG59BtrFpWILHWGRbyIfa16w3sCC9Xrl3kxQfSdbx64SPVHcGzC8EuqAIxKxMcz99+PiyLJYtBtoudTepeEcWwgefChrmWjvkIP352GX1BjKp6ZWvAWuE0GA1N4aV2URB50Wouvlop2WYLnpbZ5ancMURyFP6AOnAja0H6L1UwBvzaM8+VTbsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FikFyzwozo6fJOMDfpS3X2NjWL4L52LVmgQak3JOFpg=;
 b=I+qNaJfCVNgr/SFqqT1vnMnLh5l251nOGQm+mGoSH4CklilGby48zTzIec+DlFdoyNp59rCiYqJVXLat+c9szDknTrSwdnHPAAAlhvuQ+w8H8lfgdNMTs0o2PO9qGyjBvbGNwOaVC9JNNWlBqzRfsMQIXQYXdAepzan0B7zONPg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OSZP286MB2142.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 06:25:32 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 06:25:32 +0000
Date: Tue, 2 Dec 2025 15:25:31 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 04/27] PCI: endpoint: Add inbound mapping ops to
 EPC core
Message-ID: <dqqewhnmesylgqmj7vohhwxs3aqemysgkymayst4p24yhkgszv@prztzziimnx5>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-5-den@valinux.co.jp>
 <aS3qW0LX/ueo2ZP6@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aS3qW0LX/ueo2ZP6@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P286CA0090.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:369::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OSZP286MB2142:EE_
X-MS-Office365-Filtering-Correlation-Id: f3693976-4386-406b-abc5-08de316b9864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NURKaTNBc05pcVMwWmgxV3MzVnpxK05NQW9qUi83ck9nQ0svbWxOb1k0R0RW?=
 =?utf-8?B?Nm5IK1VIekxzbzhWZHpleHFBRytCZXNRbFBNVlpNOVUyNHpXQytyNE5GeTVM?=
 =?utf-8?B?aVBYcVQ0REFjdTVOb2dWbXl1dmI1ZjR4R1B1d2phMTREdFliMjF3TlYrNUFm?=
 =?utf-8?B?dnhGVGV2SlB3UUx4YXFOUTVSSUVXTXVCL2NJcTA3c0JZdjNPUWo1QmpqMGQv?=
 =?utf-8?B?eVMyVi9MTi8vYUdYVTR6U2ZPVXZMa0pORVpXZlNuS1FMdXMwTWF1OWEweFVZ?=
 =?utf-8?B?R2NSUktSSGZaMkp6L0pQekZTZFlUajdraklNUytlOTNWU2VYRWJJKzlmTWdT?=
 =?utf-8?B?SndpWmFOL2hRbHhPWU03c2F6Y0pmRWNmU1hYcUlxWDZZdDEzMEdIL216Y1Bl?=
 =?utf-8?B?VE9Vb28xcUhlc3QrS1ZkaHkzdnhpSXNTWEdJUXFWRXhIVnllL3k5QmJ5aW9m?=
 =?utf-8?B?MTlLNUwraUp2ZnZIN2piMEQ1am0wUEl6YmZieU5nOUcxMVBveVNodzJWVVA1?=
 =?utf-8?B?ZTZ4SGJFdHBEV0ozY1R1bGNJN0xUeWppWmxEU0s4ajV2NmhydUxBdUdIYVN1?=
 =?utf-8?B?Z0NkSm1Reis3ejBxVDluaFIvOVBaU05nbXM4QWhid0lpN2RPMkQvVGxGVXFj?=
 =?utf-8?B?VjkzUmFDYStWNVZTMHZiNXBCNm0vYnNsNk9SQVRmWGtiZEkwTlEwVC8vaTd0?=
 =?utf-8?B?YlFwek1OVTBZUjNSMmJacW1wTkR5R1NBVHBZaXl6ZkVFVnAwRWw3SThKWWJU?=
 =?utf-8?B?cC9vWWdXQVVlU0hzZU90NmlqSDdJcmVjUmR1ZmplZEovZm5EMHRWRjFYWkt1?=
 =?utf-8?B?VTVvT09MQjNzemJIY21nQnB5TTZLSGxyU0pQTVUyVlV1R2QvaG9kODR3RFJo?=
 =?utf-8?B?YVgremhYbk5VKzJXMnFGdVJjZUc1RkpyK2s5TTVsWTQyOVhJTG5kMHB5VXVn?=
 =?utf-8?B?MWdyNWFGc0RnanBybCt0cnpQWU84cURXUDZmV3dPRk1pbnllbThSUkpLdURZ?=
 =?utf-8?B?VW9pTDk2RjZDVHhQRjVKLzYyd1cxVlluR3d3d05yMFUvTG9sNVh2bHdWV2Y1?=
 =?utf-8?B?THdYTFAwd1pBc3BURUJrT0NOT0F4cWxxMG43bkE4eUpGbkJCcEhvQnNEazUv?=
 =?utf-8?B?aW4xVDdFQytZUlhXbTVFVU9MYmZTWGtKaUljVVpHMVQ0UGcvUmtYUVJvbWRh?=
 =?utf-8?B?ait5U2xXdVFDWWlEQXRBL1h6T3lPWnFpWVJ2TU1tQW1yWk1DK2lIbTI0MEZx?=
 =?utf-8?B?bGcwNHEvVkh2VTZERUIzV0pBMloyU0pOWjBKa0ViVTFwVUpnem9TMGdJSnZV?=
 =?utf-8?B?SzdXeHhVbkQ5WHZEblAybnNRcFdZdUNnSzF6bFhaa1d0UzlUY3c4UUpZeWM3?=
 =?utf-8?B?dE54MEJraTlMVE4rMWEyY3hNL2dLVEoxeVJVUExSdmtuRytMY2pXNVJEYnFH?=
 =?utf-8?B?Vm9CRWRBcVNkTmlIeldTQ1VWMUt1RmVEVHkvRFhhR2FaR0h6anI1b0NkOGNH?=
 =?utf-8?B?Z29BV1BtTE1EZ25oSzEzN3dKUGppRS9NQzR2SXRmOGVUNnBNN1YvczRKK3px?=
 =?utf-8?B?eWNzWWJlUWcweE5MNXpxOGZCQjUyeWxyR3hhbnJ0Q0VMTC92M1lZa3l1Q0xk?=
 =?utf-8?B?Zm9iajhOOWN6SnhGSlJ0eVlVV0ZPY1pZdHo0M2JNQWk5UEdEUEl0ZGk1cm5s?=
 =?utf-8?B?RHIwdkNPb1pyNlloZlpzL1owNUg4OTJwMkV3UXo2UGs2UWVwY3JVb01ickpy?=
 =?utf-8?B?bXMxTUJCOG8wUDhxeDdhSkl1SkVtUk81aHIxVE5UMENFQTVFdGl0UmxVelBC?=
 =?utf-8?B?TjBvT2xXWllrajZjUmRKaW5WdjFidVNUbUFobFQ4OUNteXFUTmpKa1p4MHAy?=
 =?utf-8?B?ZndXUDhLaVZaV254YmhrQUhXd3VpRW11QkxqdUZUdithZGorbkt0Z2tmU3FS?=
 =?utf-8?Q?RQ2N4nlSwwQTod1A+C3nAHV1ADMC88Sz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFk4NUd0ekxER093eHlEOEVLSFdkaEgzMStGam45STBUTlNEZlFzdzBXazZD?=
 =?utf-8?B?bVhITVR6djVHSTZzbE9CUHVweDBCK0kvUTU1VUY5MFRqcFducGVvdHJSTTU0?=
 =?utf-8?B?MlJqNUZrZStBNzVEbCtHWVFXQU9ISStzaFFET1VmMEZrd2pyVGg2bThpbXA5?=
 =?utf-8?B?a3h3UFJwTkpMWTN2S3ZIRFlKSTVrRjRucTB2UWpSUXNRa3N0b1dpc3MvWHRL?=
 =?utf-8?B?TUhWd1g2QmFYcy90dEEyT0tLQ2MrRUMwcEVvQis0cytjb2d5VlVLWVJDVjg5?=
 =?utf-8?B?a0FLdFlIWHhjNTF2WGlMRWNnU3U1OHg5VERGMGNFRFV1Si92ZmM1ajBKMmhp?=
 =?utf-8?B?NkFTOUlQUEN4VjhnV1ZCWSt3emJVSHJKQXZMVWgxR3d0QXl2SFJJY0JOZ1FS?=
 =?utf-8?B?UnpmcEM0VkVuTEkvT21Hc1ZFT2lJdEIxeTlOclhSTDlPNTBBNGNSZXlmWlEz?=
 =?utf-8?B?WnhuRGNIc1lObjlJQW9GSEpQTy9qQ2h3L0RVN3c0VlJxZU5uYlpObndMeDVu?=
 =?utf-8?B?am91b0Y0SXpRU0tiWmY4OWZ3NEUxcWgzbnRNb0gwWkVmRmpGRHgyblNEMWNG?=
 =?utf-8?B?cUVlbG5HeFd2NVhMMmRmN2tlaTFEcGppVDBRQkNlSGNhekJkTHJRNjk1c0JH?=
 =?utf-8?B?cUJ1ZFNRTVk5OGx0emtWV2IxaE5xRzZlYWFOUWJDUWVCU0FiZTdxTmpFSWVQ?=
 =?utf-8?B?ak1Od01pd094Q3hKdk5PWGxsTFpkUW42a3lhOU0weHdhcHR6d3JoMTlWalFI?=
 =?utf-8?B?VWFIWWlqTTI0bkhTVzBTZmJ6dXcwSTJRYThTOE41Z1lVWDZ6eSsrYkRvYWpz?=
 =?utf-8?B?VStyNTg4Q0hVVHdBNW14OG5wOEx3ckJYQU1kbldKWHlCNVhhMWJyVVFWY1Fi?=
 =?utf-8?B?ekV1dHU4NGhUZllOU21KMm82bzZweDZVdnp1NFVUUmpGdVl6OFNaSWwzWXdm?=
 =?utf-8?B?ZXRKREF2K0tEVUZVZmhLeDZybGN3RWZRcnFYWlRjWHRQZEdYNklOVUtEVUJZ?=
 =?utf-8?B?QnZGM1ZmNWFrRjllS1JLZGxBZnJPNThpM09QdFNsdWhLSXY4ajU4cm92TWZs?=
 =?utf-8?B?WGdZbENrS0diQXpob2VmVHAyRWdxN0lQVFJ0WXJiSXZGbzJiZnlsQzB5eVNj?=
 =?utf-8?B?MFlySDl5ZXExRGVmbFZiV2w4bWlRL1A4RGZEaHdIY1UyR3h5V2xtYnkxRktB?=
 =?utf-8?B?QXZCeDBIMXUwRmd2WTczdmhIU1FNNGgxWDNGU1BEa3YvQ2hubGQ2allObnhi?=
 =?utf-8?B?bFp3MlpWTDFmMmVpUVpjYVF1SDV4cGViQjlSR1Z6MUtNL0F3NDN0cnpRQmdk?=
 =?utf-8?B?REtadm1EY2xkQUpsMEl1QWhlRUR5WG5wWnIvWnV1dDYweDlRcXJQbEpuQ0o5?=
 =?utf-8?B?Rk5naEZiMHJsUzZpUTgyU3BkcTExOFNmLzNDdUc4M0pOenJXa2REdTNyZ2dR?=
 =?utf-8?B?djFNSW5ZeHBtZFhDcGwyTXF6TDdhOUlOSUhtKzlWN3YvU0lFNXRuWGFzZDJu?=
 =?utf-8?B?NEs5VVgwaFQydkFMdHZ1cERwa2FQakRiWDBxalVKdnpoUlNtTFgrYU5LWEtx?=
 =?utf-8?B?VkE0UjkvYlk5dnZ2aFQzQUdqTXlSc2ZYRU1QRFZwV1Q3ZWRldWxwS1pvUWo2?=
 =?utf-8?B?VWtuNCtKZzFKYWVkay95djhqKzRoZzhOZXRBS3dlTncwRi9aajc4RUJ4ZGJ6?=
 =?utf-8?B?M3c2UXArUGlUZGE1c2RhdWx4a2plOHlVeWZNellCVnRtUXlRam5EV3I1UjJQ?=
 =?utf-8?B?eno5Rmx4NnVvUnlRNTlVRXF6YjMydDdJMUZOUTJqUFR4TExuQTB3aEJvcFBl?=
 =?utf-8?B?K3FCNjJCcHF2MXo3dm1tUVZza1hPd3pvdUxmL040ZXVjYXM4K1lLSFUvRzl0?=
 =?utf-8?B?S0ZLRjkzODhqbE84VENuQmtCNzNhcnl0cklJaWFqYU1wT0liVU9LOHMvMTNr?=
 =?utf-8?B?dllYY0lNTGhtdm9Rb01HN21mYmJHanRuMUM1dk8xOUVtZTRUSGxFcDgybDBz?=
 =?utf-8?B?SFZ6alR5a2ZXQmp1cWUvbVBRL1dhaHBqZ1dLSU9VRjBtYWZFZFBZUENSOGdU?=
 =?utf-8?B?WlhRY2NqU1RwOVVwcUlQenJWSWovbzVZSm8rMlJ5elBNK1BuRGJPRjFRQmM1?=
 =?utf-8?B?ZHhIcXpsckNZem5TQzVVckVvaWpuU0FPbExrRFRzLzVneDk0N2wyb0RndXZU?=
 =?utf-8?Q?f2rmY/hmnaQllfQ3Q8iY4LQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f3693976-4386-406b-abc5-08de316b9864
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 06:25:32.2287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0F4hyYJviI6SjXXWc4cNlCxohzLS94XSckvxywyOayclF6E+10Dm5+SOksRvKVlS3x+SaC6G5vllsHJClU29Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2142

On Mon, Dec 01, 2025 at 02:19:55PM -0500, Frank Li wrote:
> On Sun, Nov 30, 2025 at 01:03:42AM +0900, Koichiro Den wrote:
> > Add new EPC ops map_inbound() and unmap_inbound() for mapping a subrange
> > of a BAR into CPU space. These will be implemented by controller drivers
> > such as DesignWare.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/pci-epc-core.c | 44 +++++++++++++++++++++++++++++
> >  include/linux/pci-epc.h             | 11 ++++++++
> >  2 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index ca7f19cc973a..825109e54ba9 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -444,6 +444,50 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  }
> >  EXPORT_SYMBOL_GPL(pci_epc_map_addr);
> >
> > +/**
> > + * pci_epc_map_inbound() - map a BAR subrange to the local CPU address
> > + * @epc: the EPC device on which BAR has to be configured
> > + * @func_no: the physical endpoint function number in the EPC device
> > + * @vfunc_no: the virtual endpoint function number in the physical function
> > + * @epf_bar: the struct epf_bar that contains the BAR information
> > + * @offset: byte offset from the BAR base selected by the host
> > + *
> > + * Invoke to configure the BAR of the endpoint device and map a subrange
> > + * selected by @offset to a CPU address.
> > + *
> > + * Returns 0 on success, -EOPNOTSUPP if unsupported, or a negative errno.
> > + */
> > +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			struct pci_epf_bar *epf_bar, u64 offset)
> 
> Supposed need size information?  if BAR's size is 4G,
> 
> you may just want to map from 0x4000 to 0x5000, not whole offset to end's
> space.

That sounds reasonable, the interface should accept a size parameter so that it
is flexible enough to configure arbitrary sub-ranges inside a BAR, instead of
implicitly using "offset to end of BAR".

For the ntb_transport use_remote_edma=1 testing on R‑Car S4 I only needed at
most two sub-ranges inside one BAR, so a size parameter was not strictly
necessary in that setup, but I agree that the current interface looks
half-baked and not very generic. I'll extend it to take size as well.

> 
> commit message said map into CPU space, where CPU address?

The interface currently requires a pointer to a struct pci_epf_bar instance and
uses its phys_addr field as the CPU physical base address.
I'm not fully convinced that using struct pci_epf_bar this way is the cleanest
approach, so I'm open to better suggestions if you have any.

Koichiro

> 
> Frank
> > +{
> > +	if (!epc || !epc->ops || !epc->ops->map_inbound)
> > +		return -EOPNOTSUPP;
> > +
> > +	return epc->ops->map_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_map_inbound);
> > +
> > +/**
> > + * pci_epc_unmap_inbound() - unmap a previously mapped BAR subrange
> > + * @epc: the EPC device on which the inbound mapping was programmed
> > + * @func_no: the physical endpoint function number in the EPC device
> > + * @vfunc_no: the virtual endpoint function number in the physical function
> > + * @epf_bar: the struct epf_bar used when the mapping was created
> > + * @offset: byte offset from the BAR base that was mapped
> > + *
> > + * Invoke to remove a BAR subrange mapping created by pci_epc_map_inbound().
> > + * If the controller has no support, this call is a no-op.
> > + */
> > +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			   struct pci_epf_bar *epf_bar, u64 offset)
> > +{
> > +	if (!epc || !epc->ops || !epc->ops->unmap_inbound)
> > +		return;
> > +
> > +	epc->ops->unmap_inbound(epc, func_no, vfunc_no, epf_bar, offset);
> > +}
> > +EXPORT_SYMBOL_GPL(pci_epc_unmap_inbound);
> > +
> >  /**
> >   * pci_epc_mem_map() - allocate and map a PCI address to a CPU address
> >   * @epc: the EPC device on which the CPU address is to be allocated and mapped
> > diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> > index 4286bfdbfdfa..a5fb91cc2982 100644
> > --- a/include/linux/pci-epc.h
> > +++ b/include/linux/pci-epc.h
> > @@ -71,6 +71,8 @@ struct pci_epc_map {
> >   *		region
> >   * @map_addr: ops to map CPU address to PCI address
> >   * @unmap_addr: ops to unmap CPU address and PCI address
> > + * @map_inbound: ops to map a subrange inside a BAR to CPU address.
> > + * @unmap_inbound: ops to unmap a subrange inside a BAR and CPU address.
> >   * @set_msi: ops to set the requested number of MSI interrupts in the MSI
> >   *	     capability register
> >   * @get_msi: ops to get the number of MSI interrupts allocated by the RC from
> > @@ -99,6 +101,10 @@ struct pci_epc_ops {
> >  			    phys_addr_t addr, u64 pci_addr, size_t size);
> >  	void	(*unmap_addr)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  			      phys_addr_t addr);
> > +	int	(*map_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			       struct pci_epf_bar *epf_bar, u64 offset);
> > +	void	(*unmap_inbound)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +				 struct pci_epf_bar *epf_bar, u64 offset);
> >  	int	(*set_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  			   u8 nr_irqs);
> >  	int	(*get_msi)(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> > @@ -286,6 +292,11 @@ int pci_epc_map_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  		     u64 pci_addr, size_t size);
> >  void pci_epc_unmap_addr(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> >  			phys_addr_t phys_addr);
> > +
> > +int pci_epc_map_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			struct pci_epf_bar *epf_bar, u64 offset);
> > +void pci_epc_unmap_inbound(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> > +			   struct pci_epf_bar *epf_bar, u64 offset);
> >  int pci_epc_set_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u8 nr_irqs);
> >  int pci_epc_get_msi(struct pci_epc *epc, u8 func_no, u8 vfunc_no);
> >  int pci_epc_set_msix(struct pci_epc *epc, u8 func_no, u8 vfunc_no, u16 nr_irqs,
> > --
> > 2.48.1
> >

