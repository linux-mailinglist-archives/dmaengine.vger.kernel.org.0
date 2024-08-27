Return-Path: <dmaengine+bounces-2978-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9747A961563
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 19:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FA91F23899
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 17:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422291CDFC3;
	Tue, 27 Aug 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJqP/INT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669501993BE;
	Tue, 27 Aug 2024 17:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724779527; cv=fail; b=gzOniFOOdWVeLkKtxCPziqVBos9riphIT1FQ4osv5I4muCFWVqJ4ddRirJqg+qRQrx5gFYlMPO9rxYFscHSQqqTXKNjwKnbQoZ/awA6C2lzDxEfWV7hh+mA5wMqBzG+2PtKUDPj9V9rQfY8AlzI+dQ/A8SSPoNVedJWc/cRa1iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724779527; c=relaxed/simple;
	bh=BcCJYIdSe+FnQCq3hS24UGIPsb1Hgx/7AAC9oHXOQ/Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ENVqJwujhdWGn9S07/CEoaErxn1HAnaCicTgGHHw7oQn6B6X0cmY1UALbjZKpSLwTpVVbwGVuEnPTEIGyPn6ldO+Ty1HfWWxWBINiNd9cg7l38Wq5shr/dNs7pjZnJyaLWtzvthvlzW/D6jJcxUDxUWX750DLYjxlwi1u/8Q0+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJqP/INT; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724779526; x=1756315526;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BcCJYIdSe+FnQCq3hS24UGIPsb1Hgx/7AAC9oHXOQ/Q=;
  b=kJqP/INTN4OaW+9cH1jXeOWvjt/gqXgibWdHMB3grESzZWBTkkcdmV+o
   A+fZiPSuE3m6rIGCaQieyZutnV18lvn6IySm8LSZ+WUTqKQzieRWjXf9r
   xniQJgMjYEaGyelD+/oz6s8Zsxnz8jfgUiIHGSh7otE6GgUFEKH4BQFOM
   UGXTNIlnlrFWYmo1GjpN79gJ6vVozeP5tegpvdwsknuzu0IYoZovQN5Ng
   svkZhZtTodT6iqkiiwFIAzFOwUvrc5ERNzKFxkgcLG5+VUGvzdcvOLpPq
   DAWz1KZo4ydFQSYNaptYyd2uf3Pl4bhJApwvkfT571Uq7SnVMjtxomU1r
   g==;
X-CSE-ConnectionGUID: 6YT+XVX3Q66PsCa6V2ZBJA==
X-CSE-MsgGUID: xY7orTFuSsGxz+D5YxiAqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11177"; a="34648512"
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="34648512"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 10:25:25 -0700
X-CSE-ConnectionGUID: l0Nn33dcQ9us0o/sqd8s6g==
X-CSE-MsgGUID: gy6KubPCTBK7ODgqOeMQUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,181,1719903600"; 
   d="scan'208";a="100446315"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 10:25:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 10:25:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 10:25:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 10:25:22 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 10:25:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf6R1rSjBbM7+5UbvIZG/F8Iv6ti4D94wKrZwAzhtzEOTphIJli9Km6IIgZAmAPfEQpEHNptCJi3XWPWG5PEq5HOsegs4AL2s2K1tRmPP6CjzANPDspIfVmrcWpX2EY/VPMxpb30p5wWUTUVt05UuM7SHY+b8itBmtLbZVygWNq/PinNOXxDM0OvrgG1ubHFjplSXkU4GDdUPWSTVvD9REmv+VEAOIiHPsJBF84x7XCFv+sZ/bdaHwd9oGW9/0nSyKbgP+XWJiNwBZAFDR1/ACB2WuYy23u+tKE4Z3mKuxmFE+D4CTC2vjep4gSk6tKft6Otod1nv/eWgicTkINt/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Od1OQwi35Y8FgH7h3FUpgE+gaFm9zcGs2eyFJ3YZE0I=;
 b=m3ihbmjnCbOXhTIrJ5iDIh376DHDpekuG0ZeIzTtE/I7RyFmU9F2XPTvpldqRX1WziYdgP5F7yCTb2sOL/097Hu1QF+obBDAfNoqZ63K7aXpExB5XyIKbJsGl/PQ/G9O0xF5Ofb2824GkFq448HeCgr/Eg4rrJrfrpj4ry6oLGpofUUu1AdzySQXjmrM6SOrgXyqw764am35GmV0xC+h5xRiIKwopZpQ397aYqvuvXb6hVAFCO0es3BLlsglST7iiNEgHvz18JQqtIMDf58DZ8WwSJJ2znmKpsHwIsU1n87t39ltrt4uYJGI2ldM0lVzGQ++3evHSzTsdEK3K6ODug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 by MN2PR11MB4758.namprd11.prod.outlook.com (2603:10b6:208:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:25:20 +0000
Received: from IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392]) by IA1PR11MB6097.namprd11.prod.outlook.com
 ([fe80::8f29:c6c9:9eb2:6392%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 17:25:20 +0000
Message-ID: <b664dacf-fcf6-0938-b835-a1d9bc920937@intel.com>
Date: Tue, 27 Aug 2024 10:25:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH V2] dmaengine: Fix spelling mistakes
Content-Language: en-US
To: Amit Vadhavana <av2082000@gmail.com>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <ricardo@marliere.net>
CC: <linux-kernel-mentees@lists.linux.dev>, <skhan@linuxfoundation.org>,
	<vkoul@kernel.org>, <olivierdautricourt@gmail.com>, <sr@denx.de>,
	<ludovic.desroches@microchip.com>, <florian.fainelli@broadcom.com>,
	<bcm-kernel-feedback-list@broadcom.com>, <rjui@broadcom.com>,
	<sbranden@broadcom.com>, <wangzhou1@hisilicon.com>, <haijie1@huawei.com>,
	<dave.jiang@intel.com>, <zhoubinbin@loongson.cn>, <sean.wang@mediatek.com>,
	<matthias.bgg@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<afaerber@suse.de>, <manivannan.sadhasivam@linaro.org>,
	<Basavaraj.Natikar@amd.com>, <linus.walleij@linaro.org>,
	<ldewangan@nvidia.com>, <jonathanh@nvidia.com>, <thierry.reding@gmail.com>,
	<laurent.pinchart@ideasonboard.com>, <michal.simek@amd.com>,
	<Frank.Li@nxp.com>, <n.shubin@yadro.com>, <yajun.deng@linux.dev>,
	<quic_jjohnson@quicinc.com>, <lizetao1@huawei.com>, <pliem@maxlinear.com>,
	<konrad.dybcio@linaro.org>, <kees@kernel.org>, <gustavoars@kernel.org>,
	<bryan.odonoghue@linaro.org>, <linux@treblig.org>,
	<dan.carpenter@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-rpi-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
References: <20240817080408.8010-1-av2082000@gmail.com>
From: Fenghua Yu <fenghua.yu@intel.com>
In-Reply-To: <20240817080408.8010-1-av2082000@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:a03:333::28) To IA1PR11MB6097.namprd11.prod.outlook.com
 (2603:10b6:208:3d7::17)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB6097:EE_|MN2PR11MB4758:EE_
X-MS-Office365-Filtering-Correlation-Id: 74545e5c-b68a-428b-2720-08dcc6bd39ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODFkbTl2SzdIZkh1Zk9uM0N1QUlrQ2JtMkNkTFpWSGYxQkhSLzJFZCtaWXJT?=
 =?utf-8?B?dDBqWGtUZ1NKdURMbS9yZzhoRTBCQURwMVdqQ0hYYXBjdWNwZFNxQTFITC8w?=
 =?utf-8?B?UzM1MTN4YWMzN0hsVFp6b1krOXJ2WEYvK3EvT1FYZ203MDlwOWcrZHB4dnlM?=
 =?utf-8?B?clNSTUxKY2NaTHJCcWFTR1BPVU95VTFaY1hnZERNcDQraURKSk9yMXRHQXlr?=
 =?utf-8?B?MytORVhpbytkeStYSnN5YmVXc0VhajZHTkUyaEUvL2lGNVExT1Vwc0NGVG1H?=
 =?utf-8?B?MG9IbEJaUklWdEFVZ0hreUQ2V2hRbCtzWXVpNnNZZVl1WHZEOGFlbStIelpi?=
 =?utf-8?B?Y3owTVU5Ti9QbDdveHNORkIzTnJaRi9ZaWM3YTh6N0g5bUVlUnRjS09VME0y?=
 =?utf-8?B?VmUvcFprZmdGUnhCSG03THdCUW84aEZXTW9Ud0JFTHJ1Vjc1NVZzN0g5blBp?=
 =?utf-8?B?STBaTnl3UlVVZUtXMGdManpyakxtbG9OeFhjS1ZWS3hlWXQ4UzV6cnNnelZa?=
 =?utf-8?B?UnlQdUNYb3BXYVVyY25ad0RWRldQR1lQcUFaKzdmV2JQdHJCeTJqOWhwTno0?=
 =?utf-8?B?KzdZRmgreEorSEJzWi9oSHhKRFlZTTdYVHRqdndoaUYvR3YyL01vL0xFT3VG?=
 =?utf-8?B?Sk9lNFVVaUxyN2dRRk9uaFRXMVNzRVB5QUhKNlVneEg4cWVBdWxMbGg3bTBw?=
 =?utf-8?B?aFZZaGMrQm9CanRvYW9Qd1V2NDVxWGw2OHUyRDB6VEJXZUlCTnBHU2lIZndS?=
 =?utf-8?B?WHBOMlgzVXZZTEdKaUwwNXlVSE5qRlRicUNzRGhvdk9yY2J4bnUzL0JYaE9a?=
 =?utf-8?B?d1dpUmVNOW5PeTZnREVwSFkwWHJYZkhoUkxsakZhNUwvb1o2bDhUNHF3Z1Z3?=
 =?utf-8?B?b0RaTlMvdUN1QmdmN0lidEVYdVp4WjBBTmduTjRlUnlWNWtVcDQ0WnM0eG9E?=
 =?utf-8?B?WEhrYWJOT3VXM3VEbWZRbVlDaHR2WkZLaFBJeUlWYVlaOWZjampxVFBSRWpY?=
 =?utf-8?B?Y1h2eEZuNGQxbXkzOWdaNk1NMlpyNE5tbjhWN3lUYVh1Y0dCc01WK3E4Q2ov?=
 =?utf-8?B?U1BaeWN0bE8yYlNiMVRZZkRmNExoYjlJeVJGZW1hcU5DeXFXUTJWVkVoV084?=
 =?utf-8?B?RUwxOWUzWVRiMklGQU1tUUtROG5KYkNyc0RaRzhvOWs4blZjSURFNzNETmRB?=
 =?utf-8?B?VHVRRE1nN0hvdVVRM3c3bVpsNnplcHh4a1prbGZncHUrbmZObWVPNWV6VlNj?=
 =?utf-8?B?SXBXandqMi9XS2FzbGNRbXZFK2o0RCtQUFJoNCt5bjB4Z29SSnM2VnZRV0NO?=
 =?utf-8?B?QTdpV05aRGgwS2JLWkR2Q0RMUDVmTkZZL1Q4Qi93eU1sVnRkSWVWL1NvcWN6?=
 =?utf-8?B?dlMzbFpCdEJIeE9OT2Fack9vNUExMlBVTXVWRHRwcEdZN2QrY29GTktCL2Z2?=
 =?utf-8?B?dFVBODF6cU83bXluNzJISXF3ZG51RGV3MDdlbGgxbjk5Y2pCS1c2MkM5eVJP?=
 =?utf-8?B?OGx1Qk1CZzhmak0xUFdjMjkyODcyMVpIUmRmbVRtT0hCYjlqdWhXNUtPOERB?=
 =?utf-8?B?c2ZMNlJDcVNIVEVqQTJSbUVFLytHblFqd3NCK09BVWh3Smp5SnZsODFGaUEz?=
 =?utf-8?B?Njl5aW41cTk4eE9CVVRScnlibkNVbEZ6MGQ3NjBBYkRKQkIrdmNHWUxjM0hi?=
 =?utf-8?B?SEh5Slo3YlB4SStqT1UwUjlyZnBRSVI0emVzdFlKVDZKdkxrMVo2SG5kczNZ?=
 =?utf-8?B?Ukd1RHFjMitYc1ZpVzA3VHRMOEhJck9SOGQyTlZ4dEorVnR6eUs1cno3Ukd2?=
 =?utf-8?B?aWZKeTREZHJ1eFVoV2t0QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6097.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zmc3Zk1jYVNubmpsVVBGQ2JndmJyQ0M0L2hWOU1PZGEyV2NLaUZTZ0IyRDJI?=
 =?utf-8?B?RWU5QmpkSjYvZXhWYVhhYkRPazNKUERMY3hEUCtmTmpZSmpybTVQZ2p0Ri9r?=
 =?utf-8?B?cEhQLzZmNzF3cjA0enV2NC9nVXR1K09ZQStZVkNHVUlZZ29xTURnLy9GMTQ1?=
 =?utf-8?B?THdQNHdhaVc3TlJSTzlXdEpUZDlQQUxreHZwRTdZelFzVExoajV3eVBnNlVJ?=
 =?utf-8?B?V0FGTTk5dzJhbmQrY0liQXhXRUczQno0QTNrODNaUlcyR3lLbjdTbEQ1bXRo?=
 =?utf-8?B?UzA5cW03UlcrTEFTUjAvUCt0KzRkUFhaR0luU3REQVNVRVZnZWNKaDZwVzFF?=
 =?utf-8?B?TFRUbGtzRm1vOG9TVURXUUxwdjc2QkFFRHdDTXNMempXRTk4NnlFSVpwWDZZ?=
 =?utf-8?B?ZTVRbU8xNkpGTFliak43ZHJncCtFSUlXUG5OL0o0KzVwTmRhcXVtdTl5ZE1m?=
 =?utf-8?B?aGxIaEUwUHFVSFJDSlRqMlVaV1k4a296cldFU0Flb3hiTzYxRGs3SkZpQk5k?=
 =?utf-8?B?VnM2Z0R3NnpERTgybDhkSmgvUkhGV1NMNXZqWXZ5eDgyQnkvLytUWjRXcEVP?=
 =?utf-8?B?UUE4RE1xNWM2cUNycTlhTWVDejFSVlcxUlNPQmtNd2pOL0FIRnd1TVNBRDdv?=
 =?utf-8?B?bFdXbStFbzViYmFDaHdHbitIdFl0bnovMEdiWC9ZQlRYUTd4a0l3LzRSbUFu?=
 =?utf-8?B?Z25oV29xYVliYk92aGI1eXk1S3FlZVhzL0hpSUluYmFaN281WWpMVm9qeVB3?=
 =?utf-8?B?OFhtUXJva1A4QTg3ZlFDb2RQUUgvdUwzbWpFVzNuaHBpc2xhTnRxMUxGVDBu?=
 =?utf-8?B?bWtMQWJyVUN3TXZGV0RrTUF1RHpuQTRqR1htUmJHMHowT2dEZG5YZWdyMTRj?=
 =?utf-8?B?Qlo0c3dwdkYyQXFSUUNNOEtZYzBFU2FVazMzZTc4MkxjYWhKR3ViTWo2OVRK?=
 =?utf-8?B?VGVLRGQrMFltTEtYbjQzb2dsZ2hlTVV2RGYvTkRveGlwOVBvRlNxbFNvZzFC?=
 =?utf-8?B?TjRRRWY0MXlaRlk1WE5SUzR3ck9EajBNSkNTQzVXNkJWSWZXZXFSRlNaUjk5?=
 =?utf-8?B?R2t5a3lZRCtDY0ozNW5QTmJHSVpQMXF6a3R5VFlXL0lkUGxicGlldVdiNk1m?=
 =?utf-8?B?VWtWcG5FN29WUFpVYm9hYkFoaU1OVUc1aERkd29Qdm16MGZza0txUEZDVC9u?=
 =?utf-8?B?cDFyRmEvMHd5dFNpVUl6eVJzeUtjSVVVVnRqbENKN0xQSTdQM081NzNwL0dG?=
 =?utf-8?B?UEU5SW5OVVgrYkJid1NJSng3UC9PbUNDRUdaWnpwdnZOQ0JQbTN6UU9aM0lD?=
 =?utf-8?B?UzN6RkYrbHlMMG5qeHllWGpFeW5xNmM4WnluU0dUdm82VE1lb2F4RlZtNnEz?=
 =?utf-8?B?WGh5cTNUdkRJOXkrbmVrWFZ0Znp3NUFHdTZoejYxeGNMQmJKL0wrYzFUaEky?=
 =?utf-8?B?dVAxT2crQ3BoSlErMXdHeEwvb3BLc3VjLzAxRE9ibFlQZ0ppZC9ESzg2a0xQ?=
 =?utf-8?B?Q1h2Z0RVU2t5ZWtmaFVSZzFFQk5qTHhXdThtUlN3TnZPZkpSOFIvdEZYWXg2?=
 =?utf-8?B?QTBrSXdqQWlrU1lmeEppL2RlYy9YUFRqaE1peE5CTGsxZko0UFBndVpPOWJU?=
 =?utf-8?B?dTZOZ2lSWHB5cDBsc3pLcFU3clhsVWNWZUlsdHA4a2VGWVF4OU9WUU9sT0Qy?=
 =?utf-8?B?NEVJNDBtdTcrcDB5ZTRGcFh1dmZpb1Z5SGN5c01zVlFpZGd3Uk90RmZES2ZI?=
 =?utf-8?B?aE1MOU9qSnN0WHdHRHkwOEcrK2kxLzV4M2FCZExFUXRHajFRT1BXNzhTWHdZ?=
 =?utf-8?B?WDRGQjhkRjJ0aHJlWTBVUjRvSlpWNm8wcGJZN2V4dGgwT1RoU0RmY1VPN3lD?=
 =?utf-8?B?REFJVDA0VG0wcDlYV1cvUENIemN4SHdNNjRyRGwwdDhuR1pyMUdaTzlzY015?=
 =?utf-8?B?TGZiTHpHNlFXYWhMbTRKR09KSmVsOGc5NU9iazZ1b25NRTM0SlNNZlhLVnpm?=
 =?utf-8?B?RWQxTlFDVDhtUGNiNVN5MG9jSkNia0xkbFhNdzh1MHJnaW1jMGtCd2JFeExL?=
 =?utf-8?B?YkVZSTVKcmNsTDUxZ3BQdWR3eWVZcDdaWFI2bmRuQnVkaytKajF1ZHVaU1B1?=
 =?utf-8?Q?P2IEUvA20dpas+XkkH5V+VASA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74545e5c-b68a-428b-2720-08dcc6bd39ac
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6097.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 17:25:20.0593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKGygkSmOAQvyJKvy6bavkK/Qg70n4RTU8w+2zTuyNGwxekbQZLRE55PV9QJzP8xiuTdq/8vqcH/wRcmTkOcUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4758
X-OriginatorOrg: intel.com



On 8/17/24 01:04, Amit Vadhavana wrote:
> Correct spelling mistakes in the DMA engine to improve readability
> and clarity without altering functionality.
> 
> Signed-off-by: Amit Vadhavana <av2082000@gmail.com> > Reviewed-by: Kees Cook <kees@kernel.org>

For idxd part,

Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>

Thanks.

-Fenghua

