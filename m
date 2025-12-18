Return-Path: <dmaengine+bounces-7799-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3271BCCAE12
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 09:29:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 249873009853
	for <lists+dmaengine@lfdr.de>; Thu, 18 Dec 2025 08:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF03330677;
	Thu, 18 Dec 2025 08:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nXvdTN0K"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D8230274D;
	Thu, 18 Dec 2025 08:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766046547; cv=fail; b=Y9ZiDqvzWzXetIIxa+uiWbMAUygcju1P/+oVrtDhH4LSGxCXZ+aZgbUK12MY7JTAAdcsLB50oWWGPkGD3k3OwrTx99GppO27Pg/hqq9DYrCxMjYUKFPXzhIwHR6cdCO5eLfwf/0TNatHwVpCFXq/GmKLLL7eVGmCsMphl36ItiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766046547; c=relaxed/simple;
	bh=lbpV+aEPLjMVd+zL5zjb7aqipBTJGIWUC+azzplJlOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IfzAxkaS19/sqPY5wxqwOPmVNS7JeKBtgJDMXgpLDQJBjDt4zd4uJcS0pxy7sI2/IPbTr3Oy72e797NtY4Z4Imn2n9Fp2283+8l1VP5Dt2AuI2HNo/z1Jhm8g1i36H6JcOStdIXnWnzz6IoXRz+QtVd92GbRhb597oy872tMwWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nXvdTN0K; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TrZVuuMgv8DiqalvMQgSWJw/qHDFRp2U+76a7T/aXWEEu/jm/M3h46VOxXhbSQNlapq44AiY9pwflYEzH5aa5JiXlxpOUcw/JcaPZNpWv3a/X6ObcBKInlpAi0KOP6HV9FVzFnfbVQiJNC6Ne8wneEmAT/x1ZsKsqnTnTyQmBn2gJKefshZrG+YDka3a2pyihDqaKiQ5czGz0JI1FZ9Rgoe04zZkqYaulutcHbQUbAFM3npv9cM0rIThqlNwJ39ApgESJRIVpUXD7Mrt0ocm6GQ0zJe7lOCxOyW0O54Ji8LtS0Qx/BG1CrrwISe6ZOZZAG0aCxpW6NXlH7yMv/3nWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6La3U3u33bTXcN8arX/6gHWAFYaQ0qkXgeMwMiaWjXs=;
 b=fjSFtwx1sGnUVCpW4xtENJWdB25SQrlRDV42sic49MPLV5MqCaN1XqZpnCK9AMdq9OTZBS0gQIuXSQBni4IwFmcbxISrLD4EyQTRgHnUHFAwK+gHEGywDCh4boDm7M+SAxdj/yIa0NMXQKxkTFy+47MGHVy1qnqcGsj2uqdKK11kJl/K+Vy4a/gXf57eRQRxniLkPHp1pQWX/DjzN8c4zGJKMf8bQb8qHDgMRqQD4/CPaJMocUcdtsqp6dFXqjHCYe/kE51DwoA3/QeS4xlZ81p+y4ASaia1ztt7Q3k/t+sbCSxcZXMDjVetJKM0nXi2oQoqBGA93lN+rNDqz72gEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6La3U3u33bTXcN8arX/6gHWAFYaQ0qkXgeMwMiaWjXs=;
 b=nXvdTN0KP5vDbGl3IF3cvmJ2sTql/L5e/quNPo33ZBqnwsavh7fRWA7w+j/dtwmJ2EniojwKyl/m1hFF2tgucMyXJbaL4mlfSzOaOkV1fld/AQHU9Fly6eBJoXB3/7DdGSiuaw0F6zaVKnU0frtpTaRqCEfTbW22tEqmLekRakg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:257::10)
 by OS9P286MB5696.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:3c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:28:59 +0000
Received: from TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639]) by TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 ([fe80::b17b:8311:62f:5639%3]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:28:59 +0000
Date: Thu, 18 Dec 2025 17:28:57 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Frank.Li@nxp.com, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 19/27] PCI: dwc: ep: Cache MSI outbound iATU
 mapping
Message-ID: <ktms7rwzn5o4etaiafuv2bt2lkmrp3w54db5hmhllas24fgjtt@bbppaojijag6>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-20-den@valinux.co.jp>
 <qyrjma57yonkgy4ouopzssyrktcrosjs2v6hnawjkddzwcfm5e@bm5q2isynhet>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qyrjma57yonkgy4ouopzssyrktcrosjs2v6hnawjkddzwcfm5e@bm5q2isynhet>
X-ClientProxiedBy: TY4P286CA0099.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:380::12) To TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:257::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2708:EE_|OS9P286MB5696:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae6826e-9bdb-4bcf-81d4-08de3e0f7db9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmFKNjZzUjc4VmJTaEY1OGtnWS9HNnBLYTQ5MUk0SmRITjhJc21rMWhrdCtl?=
 =?utf-8?B?YXVlcDFkUHhBMkszM2pIaVYzYXoxVWVmUXlvYWNGWXlyL29IUlJNVFRMdUZo?=
 =?utf-8?B?ZEVHMnBqT2NCbDIxQ1BpVEZoU2VObS9yaVZxSTVEUU5Zem9iczB0OTJ1dWxi?=
 =?utf-8?B?N0dic1dHZnZQR3NhdTFsRDVjUHVjTVIxMTBGMVBQM3JFSnVCVzBjYkw3VUtQ?=
 =?utf-8?B?Nm1aNlU4dVVkZ0lma2ZmaXBLdisyaTN0ejhacW42Mm51VjF6bUt0UlJYUVU0?=
 =?utf-8?B?MTBLR29yU3dvOTBZSHhhenhZR2xLek5hZmRMUWpmZU8zT05NTUlMcGk5MTh2?=
 =?utf-8?B?SVZhSG5XRm02Q2xDZ2hBU0YzTGdVVm1Ra3pJb2pIeHFGSENTZ3hMcjhPUlNG?=
 =?utf-8?B?d1M4VG9kRnhqdlk2aUd5OUpVMm1JWC9xUU9YVlpPbWIzVko0MTFucmZ5Q3FO?=
 =?utf-8?B?MzBzZjNrMlRuOFBNWVhOcUx4OUw0SzlQVkxoR1RJMzVhZjNWZ251MG0wNmkv?=
 =?utf-8?B?ZFRsdVY2Znd6UkVlcGZmRDEwZDFtbnNMSEFzbERFYkI1cEdCRE9kY2JlTFFJ?=
 =?utf-8?B?dWxsSXNSWnlyYVMzVWIxM0I0YXBMeEhxdWxLOWRtbGxiU2lOMUltbDZvbzRa?=
 =?utf-8?B?VjNtRm53aXNzMGRCTHBVWVdiVVVZMUZtUnNpYmZmcmhiVVNxSkJFUFVYMmUv?=
 =?utf-8?B?cWl1V3FFUXhISUFrSXJHNlgwbE9ydDBHR1FZa2pUSmdHNng5MUtjenFMVzZL?=
 =?utf-8?B?aEtsMmpQU0dRZUM1eXJOWUlSdUdscHd6Yk1MbW4xYmtuRnI2ekFCNGUva2ZG?=
 =?utf-8?B?elo0cHMralVXbmJNeGNGb0dMd3R5S0JXL2hOK0tCZ1JEVm1mSi8rOFphLzU5?=
 =?utf-8?B?bEk3ZUd3bURqWWxZZHJjbHNVaUJ5bnJyWURKMkZXMm81Rm1MVEZENVdOOTF5?=
 =?utf-8?B?WHExdjRsR0cva1E1bC9oUHNsRUcxbkh2MTZ0VGF4ZTRTbXNIazVkRC9zMlRV?=
 =?utf-8?B?THQ1bWdZS1NaSGl2dHFHZnUvdlA0WnkwSmhQWVBseDFUMXBVdlRjRFl5M1Az?=
 =?utf-8?B?RjJxeUVmTC85NnNjdDRoc3dwN2JqRlg2ZUlnYWpNMnlWMWxrbXViV1lyNXdz?=
 =?utf-8?B?TldRRTVQNHNkd2Rlc2Q1RXhwQzk0Q253UEpPN1hMQm9YU211OWtvRUJOODUr?=
 =?utf-8?B?WmpENTlxaWM3bnp1NlFhWXcrVUZtTjAvakhPTGVZdGtNdTJwUlVvVG9Hc3dX?=
 =?utf-8?B?TGw4TlEveW1vVXFoaUZBb01ZRVY5QW40ak4wMG1ybFZUQzhNTHdqWXJxQm1j?=
 =?utf-8?B?eENmek82S1J0RjJhQkVrYjlOY01KUmw4dFpjTzJDdlhJczNWRDRWcFBRemlO?=
 =?utf-8?B?MUI1elZVbkgzejNjL2xNSGlFdHpZdUI1UHphVTRaMUQ3VTd6cFpqaXRJNFNH?=
 =?utf-8?B?SWdhbVNKaDhkcTgzcTZpVDlZWXlNcnU3Qkx2TDIrV21lajJVRTE2aHE3NVNQ?=
 =?utf-8?B?WnIzNE9MYjhZdUJjbjhUbWNaczM1MjQ3N0g1YVhOWGljMERBZHBycTB3djlJ?=
 =?utf-8?B?Ny9tdTVJcWRDU3lUKzdFZWtWcEdKUTUrU1haeG0xdUJXYi90cmtGMDdEa202?=
 =?utf-8?B?QWNKMndoSWJEOTNjbGVncHFia0R1MjdSSDArTHhCUVZIMVVKbjNsaXdWTkhB?=
 =?utf-8?B?Sm81WjFFbkhsaWJHdmVrRTFaQW1WU2JPN0Q3ZE5WOXV2blFaVTgreFlWWWVy?=
 =?utf-8?B?Y05jSmZya09sMEl6SEMvejkvRjVxRWNENG1qZmNoNHFoTkdCbGJsRkZmVnQx?=
 =?utf-8?B?d3E1Z2U2UUFLTUlFbFhWNFlBWHN2VzlPMVZ3eCtBWGE1RGZMU0xnMjdyQTkx?=
 =?utf-8?B?dzA4dmxZWmxPOE55N3psdUpxTXAzeDBLdWZmRGpDaEZsekpJV2VSNTNtUTBJ?=
 =?utf-8?Q?7hgt+01xu2Kgb7nqcKXLozcbKoYA7bQ+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blFmT2tCa0loRjd6eVNPK2R3TTA0aDlkUktFdXk4dW5BczRMSzhLYUNCRmZV?=
 =?utf-8?B?c0ttVHRBY2lDVVpZNnFqc0xsaUFDTUFIYzFiSFVFelRaNFJxdDJKam5zNXRW?=
 =?utf-8?B?YUREVHpWNHIvdUlLcDVyeEJJYnIzV216d2h0VzJvcVNoNFV5RFhBcGlXY2Fw?=
 =?utf-8?B?eTdRNVZMWmN0ZTJoeTRqQzh6elJsSWZoOCtNS0lkY29kbzVGSkQ1VlhqOGR6?=
 =?utf-8?B?UEx3VXhOR0V3YkluZFh2S21tMUJEdC9GcldNYUViTm50OHNiTjloSHROajZX?=
 =?utf-8?B?WkJJMFVNYnFZa1lwTGRzdldoSG53TnJ4L29yL0owYURBUjJmR0IxbTYrZ0k0?=
 =?utf-8?B?VG9jNVl2eVdMaTZVZFE2SHFaLzR6ZnRHQU4rNU5lWUNTaDU5NE1yL0NNZHIw?=
 =?utf-8?B?WStsRFBRNGlKWXFDdStHTlpaM21xcUl3WHdhZkZNRmMxMVo5RDhYeDJCNkZv?=
 =?utf-8?B?WStDZmJVZ1hjUW13REM4TWxLUkozbjdSYXMva2lVWWxPZnZCL3ZURXBpM0RS?=
 =?utf-8?B?bzAzK0ZnUmROY1pnQUJzVk4rTWpzM2lHSE9ycmNIYXlScGlta1o5dWM2K1RS?=
 =?utf-8?B?b21PM3RWRUhMVFJaQjMzZENVdlhkNmhIRlJWb2txeGJ1djM2RjRqc285WVJT?=
 =?utf-8?B?R20vcnd5S0dlT2RhZkVXaDhyMFBoY1BsbUFqUGpyYkdXMDNXZTNQbU0ydnYv?=
 =?utf-8?B?MzBjdThjNWdjMVY0ZmttZ1haNGtCR2RwTThrVWVVeFRGUlRIakw0eGpXcnYw?=
 =?utf-8?B?eFBkd3RVN1hLUjB6SDdzdmk5VVZiMU9acDVRNXdWdkEvUnRaUjZNUkRIUnlS?=
 =?utf-8?B?ay9IVUI1eDZ2Nnh4aHpPNnM5N0d5V0ZuNW42RWR0MTdSMUVSM05jZkxNVHgx?=
 =?utf-8?B?TGI5VDhBUG9raWJ5cGNPa2tHbGM0OExRNjkxUGlHbkRQcXZpT3BnT2F3WGhT?=
 =?utf-8?B?NE9BWlhBR3FkVGxYU1hDckk0c0RDcDkwR3hOVU9oYWVTVm56aXYzeTcwcUJK?=
 =?utf-8?B?clh2cW82OGkrN1NYWllyazZBbStEcnlqNGFQOWp5VGp4Q291MThNcHZLOE5x?=
 =?utf-8?B?K3FNYlpVL2JMdWRZWjMvamU3RDR3bnYxNmFwT3NMakR1SFNGVFBQOTRpVUNt?=
 =?utf-8?B?N1dzUHdjRHJ1UlBqeGNBSWdudDAyTm1lZlJoUGxKUWtzdytCNU9GemhTbk9l?=
 =?utf-8?B?T2M4K05zeDJSczlWQzhmN3lqY1kyV3Vrdkw3bEJmMHdsMG8yejVCcm1xTHdO?=
 =?utf-8?B?VFhUZnFqYUdUMUpLZGJFWGZvWGZYdVM5WG9Da2VTa2hKejdaamhqZmhIR0tB?=
 =?utf-8?B?d0MybjVZWGdIYzhmNWx6eS9rQTIvUEJldDg2TzIxcmp3TExWb3dIYm1aZ2Yr?=
 =?utf-8?B?R0lsNnE2bnpmcmJNNlRsNkZvUUdxRlNxK1dlVmtNRlF3UkxuK21zZmpCTDJn?=
 =?utf-8?B?bW9ITFkrVUY0dUQ3eDNWNTVvRmR4ZmhIR1FBekV3SmVtRWgvNWw0UEhmMytM?=
 =?utf-8?B?T2tQMUljQi90MVNKNDBBMnNGc1YyL1JlQVVhWS93cDlZQ05MQ1NCR3J3UGlM?=
 =?utf-8?B?V3JUcVpvV3lwL2c3Z2kvSTZyYlRRd29LTHVXWi90Q0dIU0JUcitnK0dXSDIr?=
 =?utf-8?B?cWZRSlo2aXJnQW1pZHlGdlRlUGY4UjdsY2ZzK3ZnUnZyM25SNndENmFlaW1V?=
 =?utf-8?B?SVN6VjY2dDR2NFRlUmxPZkFWcHRYMFZiM1R5c0hZSUxSZEJHSDkzdHA1djFv?=
 =?utf-8?B?alBEREdtdDFYTXpFUEVnZngwQnR2cWZDaGtNV0lzejhCekJiQkJUMTliU1pT?=
 =?utf-8?B?aEIrbnJXSWg5MkdWaTVMUm8zTWZyMmtlMlZhdVhjUEFMdXJXZzJoRGZKUisy?=
 =?utf-8?B?cWVTbUY3R2tZcnRSU1Y1eDhSYTVRY0NvQ0NnSkg0UWNqbThuTzRMSzkwVGR4?=
 =?utf-8?B?R081WFFNeDFaejR4WFBUK2JHUFdMZGIxVTgyUDNvS3ZXV1dOclRhZ200cWVv?=
 =?utf-8?B?cUFsMGNLYy9KRFF0SjI3RW54WWI1WU84dHR3N1lNYkNua3p1MnFOQ3BZd045?=
 =?utf-8?B?SnBXNUtHNWl1Qzk2RklFKy8ySHdwdDVQK3cxUWU2eEpEVEpXYWdoVkJiUlgv?=
 =?utf-8?B?d2UrS2xpS0VQanFJNll0U2ZzOXIzRU44YkFoaTIxRXdLNnV2VjJvTkV4Ujkx?=
 =?utf-8?Q?1MWrwvj1rDihcMfdGbenSEM=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae6826e-9bdb-4bcf-81d4-08de3e0f7db9
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2708.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 08:28:58.9196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJsvpSj3XSMJPdkk9ZW0TmX5sMQfUAkaTArl4Kf8V11GuP4sqFkOVLwQAz4TfJLu2sIib7mGNMTvQU7hLa6nSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB5696

On Fri, Dec 12, 2025 at 12:38:02PM +0900, Manivannan Sadhasivam wrote:
> On Sun, Nov 30, 2025 at 01:03:57AM +0900, Koichiro Den wrote:
> > dw_pcie_ep_raise_msi_irq() currently programs an outbound iATU window
> > for the MSI target address on every interrupt and tears it down again
> > via dw_pcie_ep_unmap_addr().
> > 
> > On systems that heavily use the AXI bridge interface (for example when
> > the integrated eDMA engine is active), this means the outbound iATU
> > registers are updated while traffic is in flight. The DesignWare
> > endpoint spec warns that updating iATU registers in this situation is
> > not supported, and the behavior is undefined.
> > 
> 
> When claiming spec violation, you should quote the spec reference such as the
> spec version, section, and actual wording snippet.

Thank you for the review and sorry about my late response.

The relevant wording is from the DW EPC databook 5.40a - 3.10.6.1 iATU
Outbound Programming Overview:
"Dynamic iATU Programming with AXI Bridge Module - You must not update the
iATU registers while operations are in progress on the AXI bridge slave
interface."

Niklas had pointed this out earlier and posted a stand-alone patch that
includes the reference and quote:
https://lore.kernel.org/all/20251210071358.2267494-2-cassel@kernel.org/

> 
> > Under high MSI and eDMA load this pattern results in occasional bogus
> > outbound transactions and IOMMU faults such as:
> > 
> >   ipmmu-vmsa eed40000.iommu: Unhandled fault: status 0x00001502 iova 0xfe000000
> > 
> > followed by the system becoming unresponsive. This is the actual output
> > observed on Renesas R-Car S4, with its ipmmu_hc used with PCIe ch0.
> > 
> > There is no need to reprogram the iATU region used for MSI on every
> > interrupt. The host-provided MSI address is stable while MSI is enabled,
> > and the endpoint driver already dedicates a scratch buffer for MSI
> > generation.
> > 
> > Cache the aligned MSI address and map size, program the outbound iATU
> > once, and keep the window enabled. Subsequent interrupts only perform a
> > write to the MSI scratch buffer, avoiding dynamic iATU reprogramming in
> > the hot path and fixing the lockups seen under load.
> > 
> 
> iATU windows are very limited (just 8 in some cases), so I don't like allocating
> fixed windows for MSIs.

Do you think there is a generic way to resolve the issue without OB iATU
window? If so, I'd be happy to pursue it. I wonder whether MSI sideband
interface is something that can be used generically from software.

> 
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  .../pci/controller/dwc/pcie-designware-ep.c   | 48 ++++++++++++++++---
> >  drivers/pci/controller/dwc/pcie-designware.h  |  5 ++
> >  2 files changed, 47 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > index 3780a9bd6f79..ef8ded34d9ab 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > @@ -778,6 +778,16 @@ static void dw_pcie_ep_stop(struct pci_epc *epc)
> >  	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> > +	/*
> > +	 * Tear down the dedicated outbound window used for MSI
> > +	 * generation. This avoids leaking an iATU window across
> > +	 * endpoint stop/start cycles.
> > +	 */
> > +	if (ep->msi_iatu_mapped) {
> > +		dw_pcie_ep_unmap_addr(epc, 0, 0, ep->msi_mem_phys);
> > +		ep->msi_iatu_mapped = false;
> > +	}
> > +
> >  	dw_pcie_stop_link(pci);
> >  }
> >  
> > @@ -881,14 +891,37 @@ int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> >  	msg_addr = ((u64)msg_addr_upper) << 32 | msg_addr_lower;
> >  
> >  	msg_addr = dw_pcie_ep_align_addr(epc, msg_addr, &map_size, &offset);
> > -	ret = dw_pcie_ep_map_addr(epc, func_no, 0, ep->msi_mem_phys, msg_addr,
> > -				  map_size);
> > -	if (ret)
> > -		return ret;
> >  
> > -	writel(msg_data | (interrupt_num - 1), ep->msi_mem + offset);
> > +	/*
> > +	 * Program the outbound iATU once and keep it enabled.
> > +	 *
> > +	 * The spec warns that updating iATU registers while there are
> > +	 * operations in flight on the AXI bridge interface is not
> > +	 * supported, so we avoid reprogramming the region on every MSI,
> > +	 * specifically unmapping immediately after writel().
> > +	 */
> > +	if (!ep->msi_iatu_mapped) {
> > +		ret = dw_pcie_ep_map_addr(epc, func_no, 0,
> > +					  ep->msi_mem_phys, msg_addr,
> > +					  map_size);
> > +		if (ret)
> > +			return ret;
> >  
> > -	dw_pcie_ep_unmap_addr(epc, func_no, 0, ep->msi_mem_phys);
> > +		ep->msi_iatu_mapped = true;
> > +		ep->msi_msg_addr = msg_addr;
> > +		ep->msi_map_size = map_size;
> > +	} else if (WARN_ON_ONCE(ep->msi_msg_addr != msg_addr ||
> > +				ep->msi_map_size != map_size)) {
> > +		/*
> > +		 * The host changed the MSI target address or the required
> > +		 * mapping size. Reprogramming the iATU at runtime is unsafe
> > +		 * on this controller, so bail out instead of trying to update
> > +		 * the existing region.
> > +		 */
> 
> I'd perfer having some sort of locking to program the iATU registers during
> runtime instead of bailing out.

Here, does the "locking" mean any mechanism to ensure the quiescence that
allows safe reprogramming?

Thank you,
Koichiro

> 
> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

