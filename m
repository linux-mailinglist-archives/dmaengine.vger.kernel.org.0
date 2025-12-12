Return-Path: <dmaengine+bounces-7601-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB22CB9F30
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 23:31:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04327314C02C
	for <lists+dmaengine@lfdr.de>; Fri, 12 Dec 2025 22:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1748D313551;
	Fri, 12 Dec 2025 22:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CB4K9HfI"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013060.outbound.protection.outlook.com [40.107.162.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CCD312821;
	Fri, 12 Dec 2025 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765578396; cv=fail; b=hhkh0KFwfwsaYs2FhHEgAwyQmFAOQjUiNnUqjFcioavxDgZxNIDEAFv+4j47zocQ9hO8Sp6G8+0YqCOiK6CMBZyhGaM1DqiHn3l5UOaHlYRCFXdZeCQr6s1MBpy5n+RSlGwaX3PHLKwbY6Vh4u2x1Yw6q/3HVFY2YiWvYdmAEIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765578396; c=relaxed/simple;
	bh=Sn/GabRX7BNWFcJWwGbQB+v4PtaxhlGTzNFSiUMk1y0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=o0fM/6JpQGXo5GC2OtxHDBRy0CF/3l4VsqXw7guH1JH745HHt7qlU3qscRP3T7q9jsY/6VdbXBzxiieF1WAMqc0GkPdoVhnlsFIl2cb9yyLi8l/wRKKXbtJTS7twq+ykNVla4zIUdcS5WtSPyXp2zAEri5LKXi2dOFUfeAMI+X0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CB4K9HfI; arc=fail smtp.client-ip=40.107.162.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HtErbvgqUva9R9PgI295pwCQWmwbwean9eQI/1liwh5V0LY5Ls/9i/34zz2yCph0f8OGiBdf0j3nWZOOiPJrTqpZgi4qxan597qhlbxAK2xyjLjhEN1IoKdxmFDgPW6IUaYDRwemseoSg8tL1HtB+R8PVAVmUgvtArvf9kas307xqcmU134/e2FN8mp1VBqxTMJD97kVY+ruXNeyHxlnDB6TphzpTQ+3oX8h+PvVSW7KAUcNCgbNXVljUwWFhIfg/IziUw3pbPff5Gfs5L1vVZOe90NkIkU/w+3XqbAvOlC/avTt6pHWJ9qIDwRDm9SxNLYAj0NNMikcaGbhMR8HOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdHF1bJHb2SnhhFi/q3JvimqVgVenpa/dEP9w08caNM=;
 b=Z05+AZiYMO5kUKQKqvjb/vOfqfkuju6DURZomYdla/Ux35y6WOb/QLxnXtkvu6sK07bM3c/ooLvuVaKB4MceJjHYJoA6ZWqiZY0ZH5wqK0LINb+ZbeTt6zxwnUrQJoa/O/sF2rd0ZWY48cCpCcGfZe/u6LJPf0GgtuGp8RXMmjbhiWNVfoF3CgwakuvxaBQpRLM9zgdFFdkWhr5S9eLeU6niBGKzajExFMvN3sKEHHeq3q/et6f5kq3YF/N27sBQ1kMyndgGuKLpqgIXc65pCracPjS/gWuQ8IT0ACa3XdJFutooIsORMTPlEHuxRZN0lXoezC9bH4+1/rIXyuHGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdHF1bJHb2SnhhFi/q3JvimqVgVenpa/dEP9w08caNM=;
 b=CB4K9HfIxp6QxJBx9rqhYOe+FaXosAC9N3LlkqeXN+ic2sroaotlNlrli2A61oSROzU1bjXIo0w99G5+8/IOyW0cKx1k8SEym7BY0jojcrArEfDbZpIAXNjKd3V7N1Cw4Wjvw48jK2a+IuHw8C5nNC1PA5CaQHpltMnCYnrk7IHIIaTM77OXHcD3oIThKVbUZxXTnaZkpbx9+1zOONdpf17TLVrmtpx86KZ8R5KV//sHvz0KiPxfAanDOCMJDW0JuB3Jh6mLms7QxPWGLjOkNYHP+ltKfixbgXQy2pMLxTYh+cuAwW5Wkl07X3nUHMX8lUJ+CxBBTJNIrSEut+1/3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by GV1PR04MB9053.eurprd04.prod.outlook.com (2603:10a6:150:1c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.12; Fri, 12 Dec
 2025 22:25:34 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9412.011; Fri, 12 Dec 2025
 22:25:34 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 12 Dec 2025 17:24:47 -0500
Subject: [PATCH 08/11] dmaengine: dw-edma: Add new callback to fill link
 list entry
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251212-edma_ll-v1-8-fc863d9f5ca3@nxp.com>
References: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
In-Reply-To: <20251212-edma_ll-v1-0-fc863d9f5ca3@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>, 
 Niklas Cassel <cassel@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-nvme@lists.infradead.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1765578298; l=6121;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Sn/GabRX7BNWFcJWwGbQB+v4PtaxhlGTzNFSiUMk1y0=;
 b=a2YUmB4WwA+skM1MwjYhlVEUgTbmNMsMmi0aZoRULqtqxc6XeKW2g8oHi2epHKUTa+j6x2z2e
 2x86xCwKso/AN2Kt7JJ6JtGq8m58oMPXIL/Vymdvt+4iCNp748jNPio
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR20CA0025.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::38) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|GV1PR04MB9053:EE_
X-MS-Office365-Filtering-Correlation-Id: 076597ac-708d-46d7-3746-08de39cd5e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmtBSGZFOGVSYVZuc2RCaXpVakJITVVsVCt2K2g3c2NLRjZOSTJBbDB4ZnFo?=
 =?utf-8?B?c2tvM3phdFpjeXJidjM4aWJRZXZrODF5NVlzdVhTZ2VFakxNRVJNcjU2cnFL?=
 =?utf-8?B?MWdxZWd5azRzSDNhcXN6TkZ5MHlSZVRybHllSzdZbStXWHJVS1doTEt0V2Zk?=
 =?utf-8?B?MVhLZkVhbElsUFd5ZGhGa1dhUkQvQzJ0emVFMHFFY2dhOXlPN3MvVEpreFZ6?=
 =?utf-8?B?ZjltZE5MQXU4czhmV3QzRFMyVDZsMk5DWFdSTGtabFJ1eHYrOXU5WEhNS2w1?=
 =?utf-8?B?Mkhia2p6a25oVFlmeXFsSkJ6ZjhkODV5L1dBK3Zqd25aN1l5ZGhHSHF5MXpi?=
 =?utf-8?B?ck1SMVRUT21CeGV5Q1VSc1JrZGdoZHJ5eDByZzVmVmpHQVBiQTVuVjhQVnVk?=
 =?utf-8?B?dnQyazJsMnZkdlYxMTkwNi9lbS9TcFRSd29VUFlDSGVkZXByRHQzbHp2bHFt?=
 =?utf-8?B?RWU4S1dTTFp0V0lUOEF6c1hBT0ZCQmkvMXoySkhmU1Q5UU9URGtSd1VLZHVX?=
 =?utf-8?B?cno4cnZYU2ZpTE1QQUJ4dE1JR1djRUZtZzRkNEZlckpRRy9vRm5UWCtXSTlH?=
 =?utf-8?B?YTlsODlib0xZeW5NdktJMlhQT0VSUXN1WE9kL3VXTlpsd0dxdWJEczc2L1Vr?=
 =?utf-8?B?RE9UN09jamVub1RoQk4xNkRwUGRIb056M05kUjNsdTVwZS8rVERDN2xiL0ZJ?=
 =?utf-8?B?MFpNRzlNUHE2enJEbmxCTVF3Tk5VaGlSejNzVVFmeVRDcHIvTWpUUkpINHBY?=
 =?utf-8?B?UWFiWFJpeGg1VkxsZXFNKzJibXpKN2diTEVncXV3c21HMHJ1UlRqL0JEVWds?=
 =?utf-8?B?VHVvRXNqTUxlV25KbTU3S3dlTVgyVjJUVEVTY05tRzlXQ3FlZ21aeTNCTG1w?=
 =?utf-8?B?ZHlzZG5hNmE5MlJQblRhZHIwL0tRSU9GL1J2Skh6RExtcC9sb0kyZFdSQmo0?=
 =?utf-8?B?VHYyMFNTM1YzVzRVS3BLZmo3clRjcWNBMDUwN0g3ZUp2MWpWd21Cc3BUN1Z0?=
 =?utf-8?B?WFUvVzFFUTBkTGtudDVta1RzMG5XcmVjVDlya1hMbVp4Ymg3aFpURTl5U3lB?=
 =?utf-8?B?cTlzaGNtOCtVT2kyOXp1T20yd2ZDTjdadWJGOVlFOExybkg5enV3ejJmUVRw?=
 =?utf-8?B?VjRsRUhRMkd6elhKSytRTS9MOVpDdkFVMlNFOW93S055cEtacnM2ZmlmTWth?=
 =?utf-8?B?RjlvTG5ra0ZCR1pCQmIvZzIvWWZTQmk3RnV6M0N0WEtTVXhNc1hPenZ5SUdy?=
 =?utf-8?B?bmtkMldLcTVFZ1EzUDd6R0FsWTIvVlpVVGY3T0h5bHZyaWlPSzJkMlROQUIv?=
 =?utf-8?B?L1dKYzhicnozSGNMNTU5Y0p0K25pTlNMbU1STy9JYnkwLy84OWtNNThOYmhX?=
 =?utf-8?B?aTlnYWhMd09IL0VMb1VNWnFiQnRKUmYzQ3lLbkcxTmdoUXVnY1REbFh5RVps?=
 =?utf-8?B?SStERW5Celc4WUw1emtLQk1yaDVFa2FLYjB4eWtha0dvSnh3MTNjd3c0UkFt?=
 =?utf-8?B?ejZvREVWNHNZSEh0cW9ZVkdNRXVPZ1NMSXZ0bTBsZFZpNDgyV0Vzc1doeHNX?=
 =?utf-8?B?NE1XWHhWVEx5aFFabWR0eDdCa3pSLzhHb2t5cVJ4UWZiMkkwMGFqU2F2T3VE?=
 =?utf-8?B?MXhoejkzcnU3WklSd2VPcmV3MHVaU3dhLzJTc3lJNi95TldvNTdLcXJYRHI4?=
 =?utf-8?B?MXdQTkF3eFNjTUVMZFZGR0cyZThFbW95ZTZPMkVBUDFGQlY4T0EyWVNDN3V6?=
 =?utf-8?B?YTFWT2ptV01xS213Z095NW5KK25KR0tyRk9FNDRUdE84eUpiNnNWc2dORVZW?=
 =?utf-8?B?b2hKYms2bjduSHpsME1HcDN2UVRaU2JVcy8ySVo0ODZQQTVjOHR4OE0zVHNO?=
 =?utf-8?B?YUNLc0Y2WkR4ZUhObjl4SUpRK01zYXl6Y0xxQU11RXBWUk1CUERsd0IzcmFT?=
 =?utf-8?B?RU1yMnJ6SnJLVUFLM0xobk1HekVIZGhQWms3T2tJbnRiMlB0U3NkRS8wMWpi?=
 =?utf-8?B?cXNNcVhHckZoVHVCS2pYUENycXVRT08xb3BJTDV2MzBuaGF0aGFYRjZuNEZC?=
 =?utf-8?B?QmJwaEc3V2IxTlJhL1BpdnFVWHZ4N2xDdUY0QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WS84SDhMRWxPRWZOeWR6S0srOC9GVG9SbW9PU1orKzJDVkJKdUNTaERIUS9i?=
 =?utf-8?B?TkVQSWdPNkRrd1ZtWTFhck0zczBzaTJBZ3h4RGVQTENxakJub3laODNIRnoz?=
 =?utf-8?B?ZFFId2g5anBad0MrRE13RG05eGFzOWRQZ1Z2ckNQR05GZWVyNi9xT3pCL0lN?=
 =?utf-8?B?empVR3pQcFlQQVQ3MGN5VlkzR2JXK2pZaC94ZWdhalJkdmw3RWtoWHk1bkdO?=
 =?utf-8?B?OTFybkhwYWtVTllqb0lHRjMxdUFmakZGYlZ5WlllYUhaODBiM1NIV0hZYVdn?=
 =?utf-8?B?b2syU1IzTUk0VlphdlZhRy9MSTBEUFpCcUxnMTZnNGVxSGpMZFUzamdTWlFa?=
 =?utf-8?B?bWtydjhXSmp5Mzdmb1ZseXhkaWF0Zm52KzNLQktCS0R2NXI0VCt3S2xQUXhH?=
 =?utf-8?B?ektnSnc4Tkl0V0picGhhL2JIZHVwaWl3Ri9pSWV5azZqNElUWDd2OENFbzV3?=
 =?utf-8?B?blU3eUtYREh2UDN1WGJneVZtUEtIeVZpM3cyUjRDZXJQOVBIYU01dGh6bS9Q?=
 =?utf-8?B?U3N2T1JKdFBKa05DY2IvdklRNDJudmordXIvYjBuaU5GRld3bk1vdndhRkZE?=
 =?utf-8?B?U0hvUTk5V2RRelBsYWRFMVlJRm5OYmpONVh4RXZIVzhMVmkyUUNLb2ZDK3BX?=
 =?utf-8?B?OVExeHFWZ0N1RmF3blNydDhIWkY0czlpdktUajc3QjlQOFl3NzZmM0hGNTdS?=
 =?utf-8?B?SGp5eTNGeFlLZWJEYWJhSEJSSTA3Mnc0emd0dHE3S1BpbjR4c25sRG1CblpO?=
 =?utf-8?B?S3U4RTJxUWhab3JrS0dFdXlmRUZldFdnL1BGd1gwUUhhQUN4Q01uMHVVVG9K?=
 =?utf-8?B?dWJUMnlaa3B6VkNpZFhiaFlCZ25acEo0SUxOVmgwbGsrNEtXMHJHVFV1L3Rn?=
 =?utf-8?B?TlZsUEwyK1lFdm5yQzZpOTZtbFdRSENjUG1PYm9GVU5QSis1OW5QVFNxRTZH?=
 =?utf-8?B?RUpoQ3JtemhUTzhrdm1oNGQ2T0FZNWd0eGRuc0Fsei9pK0t1T3c3TzBYT0hU?=
 =?utf-8?B?eVdPQy9mdGNhRGovSXJLQzBxQU5CUVZkK1Fac2JsZ1FwNGlpUks2NU1Ndkxh?=
 =?utf-8?B?VEZLVXFFRTFnc2ROMlNIcEZLZ09LcVo3WWNVUklqeE8zYVllRWx6VU1PdWwx?=
 =?utf-8?B?V2tkZFZSb1RjdXVoN25yaC9DUHJTdy93M2ZYazU2aklQcTg0bCtUWjQ0blBp?=
 =?utf-8?B?ZzUrTUwvc1Y1cnNHSW1wZStiam8zcFpad3hUVTJVYjczbWhGZFVsMHgxS05C?=
 =?utf-8?B?aWtpdFhka1dRYVhIeDEyYSs5eTZLZjIrREVudVhRczVCalloZ1UzSTd0WEhV?=
 =?utf-8?B?TEdtZHZZZGZwZ3YzV0V4TTVkbTJCZTA1TjNwYlVJVDdhRndhWXhUTS80aTdK?=
 =?utf-8?B?VFZPcTNWRzV1S09LWThoZmxoZlozM0FnVEFRcU9WaG5aTnJMYWlHNW5zNGxR?=
 =?utf-8?B?Wm40WlJjNU1PTElzMlJxUjVGSlFlMlVwK1lSaU1jcG5FM0NtTHY3ai9rZitm?=
 =?utf-8?B?MmxmYkdTME9WTFErVjN1ZHpXTm9Fam56bCs1b1YwSDlVWnV0Wk9odmYzRFFz?=
 =?utf-8?B?cjJEa3ZLaVMyVWhIbHB4YlBCUHY4VmJrZldwbHN1bHBMdmdxVGJnMkplcFVK?=
 =?utf-8?B?MkdaSlVxbXdOWnBWckU1SVBycnlQaGtDUE5jUGF5R0tPVkt6Qmdxc2owa05q?=
 =?utf-8?B?VkFMUUYxMkNqdG41RkJ6SVNqeTJyN3JKZ2tZRW5SajdxQ1BuenZhNzNlZWZN?=
 =?utf-8?B?TE82L1Y2S0E2Skl3NUVIRFVXR3Q5MUR1M2p3Y2FYY2VaeUZ1QzFJYzVJMisv?=
 =?utf-8?B?SEJoUVppU1lqSFM1WlppRlZwdTYyb2loOGo0VnZNRzVPdkFKUFBlUXljd1l2?=
 =?utf-8?B?WXF4QUJxTkVKcDQxb0F3L0tXOUVBVldmMzcwYmc5Z3VjQjg1dXE5RVJ1TjUv?=
 =?utf-8?B?TFVlalVtTmhUUmpmVDlwemY2RzVmeUZVOTNlcHpKbTZ1K2ZOQjNmQmVqdll3?=
 =?utf-8?B?V0lhbmVOYWJ1eFVrejA5dXlJQ1U5YUQ5RldOYTRMcGZrREpNeWpXdHczTUwz?=
 =?utf-8?B?OVB4d3I0MUsyc2dacXRBTTYyczJvM0JORWd2UDJ3Z2ZHczRUS2NxM0pZeWUy?=
 =?utf-8?Q?ciL0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076597ac-708d-46d7-3746-08de39cd5e22
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 22:25:34.4748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eesT8mEQT5c4Cm1sKUBqUklKonb41ErcXexAp/BE3oTBhpU8wBL7zb1ItLle1qTqVpPXe9EvBHaSPxj47rzoXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9053

Introduce a new callback to fill a link list entry, preparing for the
future replacement of dw_(edma|hdma)_v0_core_start().

Filling link entries will become more complex, and both the EDMA and HDMA
paths would otherwise need to duplicate the same logic. Add a fill-entry
callback so that common code can be moved into dw-edma-core.c and shared
cleanly.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/dma/dw-edma/dw-edma-core.h    | 31 +++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 46 +++++++++++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 38 +++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index e074a6375f8a6853c212e65d2d54cb3e614b1483..2b5defae133c360f142394f9fab35c4748a893da 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -125,6 +125,12 @@ struct dw_edma_core_ops {
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 				  dw_edma_handler_t done, dw_edma_handler_t abort);
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
+	void (*ll_data)(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq);
+	void (*ll_link)(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr);
+	void (*ch_doorbell)(struct dw_edma_chan *chan);
+	void (*ch_enable)(struct dw_edma_chan *chan);
+
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
 };
@@ -201,6 +207,31 @@ void dw_edma_core_ch_config(struct dw_edma_chan *chan)
 	chan->dw->core->ch_config(chan);
 }
 
+static inline void
+dw_edma_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+		     u32 idx, bool cb, bool irq)
+{
+	chan->dw->core->ll_data(chan, burst, idx, cb, irq);
+}
+
+static inline void
+dw_edma_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	chan->dw->core->ll_link(chan, idx, cb, addr);
+}
+
+static inline
+void dw_edma_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_doorbell(chan);
+}
+
+static inline
+void dw_edma_core_ch_enable(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_enable(chan);
+}
+
 static inline
 void dw_edma_core_debugfs_on(struct dw_edma *dw)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index cd99bb34452d19eb9fd04b237609545ab1092eaa..59ee219f1abddd48806dec953ce96afdc87ffdab 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,48 @@ static void dw_edma_v0_core_ch_config(struct dw_edma_chan *chan)
 	}
 }
 
+static void
+dw_edma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_EDMA_V0_CB;
+
+	if (irq) {
+		control |= DW_EDMA_V0_LIE;
+
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			control |= DW_EDMA_V0_RIE;
+	}
+
+	dw_edma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_edma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_EDMA_V0_LLP | DW_EDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_EDMA_V0_CB;
+
+	dw_edma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
+}
+
+static void dw_edma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_edma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_RW_32(dw, chan->dir, doorbell,
+		  FIELD_PREP(EDMA_V0_DOORBELL_CH_MASK, chan->id));
+}
+
 /* eDMA debugfs callbacks */
 static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -521,6 +563,10 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
 	.start = dw_edma_v0_core_start,
+	.ll_data = dw_edma_v0_core_ll_data,
+	.ll_link = dw_edma_v0_core_ll_link,
+	.ch_doorbell = dw_edma_v0_core_ch_doorbell,
+	.ch_enable = dw_edma_v0_core_ch_enable,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
 };
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 953868ef424250c1b696b9e61b72ba9a9c7c38c9..94350bb2bdcd6e29d8a42380160a5bd77caf4680 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -287,6 +287,40 @@ static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 	SET_CH_32(dw, chan->dir, chan->id, msi_msgdata, chan->msi.data);
 }
 
+static void
+dw_hdma_v0_core_ll_data(struct dw_edma_chan *chan, struct dw_edma_burst *burst,
+			u32 idx, bool cb, bool irq)
+{
+	u32 control = 0;
+
+	if (cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_data(chan, idx, control, burst->sz, burst->sar,
+				 burst->dar);
+}
+
+static void
+dw_hdma_v0_core_ll_link(struct dw_edma_chan *chan, u32 idx, bool cb, u64 addr)
+{
+	u32 control = DW_HDMA_V0_LLP | DW_HDMA_V0_TCB;
+
+	if (!cb)
+		control |= DW_HDMA_V0_CB;
+
+	dw_hdma_v0_write_ll_link(chan, idx, control, chan->ll_region.paddr);
+}
+
+static void dw_hdma_v0_core_ch_doorbell(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	dw_hdma_v0_sync_ll_data(chan);
+
+	/* Doorbell */
+	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
+}
+
 /* HDMA debugfs callbacks */
 static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 {
@@ -299,6 +333,10 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
 	.start = dw_hdma_v0_core_start,
+	.ll_data = dw_hdma_v0_core_ll_data,
+	.ll_link = dw_hdma_v0_core_ll_link,
+	.ch_doorbell = dw_hdma_v0_core_ch_doorbell,
+	.ch_enable = dw_hdma_v0_core_ch_enable,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
 };

-- 
2.34.1


