Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4862A6D7C3E
	for <lists+dmaengine@lfdr.de>; Wed,  5 Apr 2023 14:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237801AbjDEMPT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 5 Apr 2023 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbjDEMPR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 5 Apr 2023 08:15:17 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DE740C8;
        Wed,  5 Apr 2023 05:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nu4A/X0VDYTazNnfmEv0t5HddgjJSlr3KgumxsnqeZby+IpuP+Ukx71ObTNUaubP/sQhk/QdMY0O6oAJM7+86zIXMjlygyYFUs1+ff7NlkDCtrkTVlWJs4zaQbW+XNFiSwZKGFv9BFXK9BugIBLG4KUl5suxh9vdYm+asejuVQi5R9SZl8aJDkJH6Uo2tIE8rw/8QWdFXGc6fNqdrPI0Zo/zXygNFXRGXlNUwug03MZ7037ephqlDY3yUZTxwu1uJhhAkBBIcGMDeN4W+wE6K9U9U6lyEHBOj/0/88jQzzmKCFkGIGP85G6/8K80TzZYyqemr5AZvhHOVxiQWH8yUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxObiAj6MOTm0UNLU0ZskxBaCh1e0k+cCtOQ1znnM9Q=;
 b=C9bjoxNoI4ntTGNvq0cE0V4/DbsGgworFQ+N0Q76sOPMt3YtaAjblB3eJXZqmz5Uf8yKjbloiLCUViP9hFiKKXdHs844zQ2tNEgHdMpIw1AMSBxRlnR17JK9bdehwInVzO1/3Z/JTUgO7ARdWmPbBGQuiu0WA9oX/mdLudlJ1tOpPrVxCa7Cu1aCNvjlsDrGBdKcTwoKD/npethtRj0xnffLQuegROCEnrqs702ilE5d/WLEPbCPGOxU5GVNM3sdPyDdnTsyFLZehDo5i6jJCwZM89HHO+NlvcqLeFqLM6LSZHduwJpU5Hmu42zgG2i6J1MdAmQkyp3gOy6L5lpWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxObiAj6MOTm0UNLU0ZskxBaCh1e0k+cCtOQ1znnM9Q=;
 b=chAAQ+hPzC9/zhZHgI7JJYBXEZO3NXnrZ2DtbwQW8rGNyoSAHQjRjFzqhH5ob4ecAZ423oPpPJPP3aWqhin13QbdbF+m/Gvwu4ljJvp/CA8QoVWhY4Hku6OYwnWWg3cvtPEIh0jZFvvQXEaLZbsOQH1nx15Odp+ZyAw+/DgMsdc1d+ZOXiAEzgwbLnQVfaQpLeiuzrqwR8ZwxIDL5da3AMvzH0AVabQXfuVsHoYTRP3tiMQlb4vv0yEK4c/kjuktp4q8qwuvzZtm7+6ii/QrJs0tZ/NlTUO9aO1OzrmPgYj4X9MwagIYBey++fquP2RrVyKA0cQCefFN9rTOA9pPkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Wed, 5 Apr
 2023 12:15:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%6]) with mapi id 15.20.6254.035; Wed, 5 Apr 2023
 12:15:13 +0000
Date:   Wed, 5 Apr 2023 09:15:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, dmaengine@vger.kernel.org,
        vkoul@kernel.org, Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>
Subject: Re: [PATCH v3 7/7] dmaengine/idxd: Re-enable kernel workqueue under
 DMA API
Message-ID: <ZC1mUKH/03QhkcR9@nvidia.com>
References: <20230331231137.1947675-1-jacob.jun.pan@linux.intel.com>
 <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331231137.1947675-8-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0054.namprd19.prod.outlook.com
 (2603:10b6:208:19b::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: aacc0adc-6e84-41fb-8740-08db35cf688a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Y31ThsPE79Ulo2/eV9ggpzF3p/s/96U8kcelT29OFwNkJ7IBxWJ20x8xisFxmZZF/VWS9l96DJjQZnSmVJZ1ZwC/xEjRUwEoREqjK4iCP35FKPiXUcJZN0jO8LO+fjVIbSOqaD3FtH13sDyyLq2uY4ZVI0luHiglgKhBEZamjNt/M7BhohmmmZUwM/IUDJfSJZpKTppqJVytuRCAQyBX5RQ+Vz5X2+WHgxUYHhilJg99kjbkN7OjwJBsJErH8+KJCK5m/cIX9hJMUgLhsVMPr2rPStroeudLZoqJYaPwhqwePHhQ1jB7KE8CYnrmcGYRabd3j0a0RXfJJdjUxc7ipYEMXhiSOfmsGmBg0XYiSaF25cWU/cHlq/sdegTQ4vl0+7wIGDHDSetVxPN21kYEPZ+XIYnKaM+pwWtFcSmdtuAyBeyoxehfA8P7eMfYVuQBgg7BaKkDsmmN8FSKm2smOOzifX8gnQPkbMGZvPtg9oru5uAgjcoqpdAUMoaLIwqyZvPEMmBdIjvy/J9xS857FrlRLAv6mMiulO7IR3667FH1zn68MY7AOfxuJ19+QBo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(2616005)(86362001)(2906002)(36756003)(6486002)(83380400001)(186003)(6512007)(6506007)(26005)(4326008)(478600001)(66556008)(66476007)(66946007)(8676002)(6916009)(54906003)(5660300002)(38100700002)(41300700001)(7416002)(316002)(4744005)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e8PNnqozcg8S5JYR7b6K0KutrgclQpjFVjqDUFaCh2ldt9mf+hz1nrJ/Kjd3?=
 =?us-ascii?Q?bk+v92xmSd8kKum9k460ox5s9+noGguQDIRgxXq7HWlNdAv09CHUvBP3dgl9?=
 =?us-ascii?Q?jhiQuDtdqsD6ibiGAdLMj0YESFzh85hGtFEdKij6NjoC/CopJbdMRJZ1cGPa?=
 =?us-ascii?Q?erL3OL1QwBmjle9uB7p/zxVi+OdRX7FDWvD8c9an9z1ZPV8NhmPqtRi4/BwH?=
 =?us-ascii?Q?l7+jaYHsRNNVj3pE/5rNK7OgzEcTxm0Pm2LfJAaBoDbCwQEX24/vCjze6aTR?=
 =?us-ascii?Q?mpcJEHCfu4K54ZyTlV3PGGoyjBN7E6NM+fyicOIQu/9rflmP5OPkxf9DoQVn?=
 =?us-ascii?Q?2aQapLKl9JzYoSIZ7fLDeyj+f7wUOZ2Mk756qrKrzyhTd2kp02wFl5hJu3cf?=
 =?us-ascii?Q?GRDMyxGGxsJWO/yLnSn4vDszqgNvMz1rzW/ppHCUEBKNAIxTyR7BVsK20Mg2?=
 =?us-ascii?Q?eHNuv5nayHGsczR9Xf5+UH717dFB42QvEFESoSasi3cObK8Cvunpf6NnUur1?=
 =?us-ascii?Q?PhzU6Mnl8UZmg+5ejUwJThahSsTKHGWGHzeFI/TeLfUD52RF3+eFsAMlz1Ey?=
 =?us-ascii?Q?5UN7hLRoKGSAhM0McekN9nL9av0z//v5XYQI1OKwzne6xYLyyYPOr4reY5k8?=
 =?us-ascii?Q?35E8C9ClYIvgH+7ViB1fDpPjIO/oTK+2CENEcNNoCx8oEQ/y0GNYjC/Az8oH?=
 =?us-ascii?Q?sr1Uk1iJfedhAlqxrXSn9RcjMlpvFzR4R+4hubl+SACjY0puqwhbpkmDeOel?=
 =?us-ascii?Q?Le7laSY1Ho49L9p5nWldaYV8ZaisaFP8VGPhiDUd9ZfVtMaSUU3aTDGAPXs7?=
 =?us-ascii?Q?XgcaxCbWdjIs9jdZPBBPBuKTZFGTRDrUuNGVCKQELj+M4oC1+wJlOyIDBiTX?=
 =?us-ascii?Q?J8HIW8LiTWpxFQ8VLx07TEUBGe2uG55/KX6VGKi3d9nmFwr78GU4tZ5EX6SI?=
 =?us-ascii?Q?UDnA9+VQ8Gb6rSAdJXjsh92T6KRixf5Y3d1HCTzyoW9FwI1d0ahhm3p+14+m?=
 =?us-ascii?Q?mNunyqVOSlFJvGdgkp80IjVji95X50GaDu/FkvzDcE22qRRNcsECApzn68WR?=
 =?us-ascii?Q?++jaAuuhPAvYr6sMd2LBa3FAes+YsqpXINUHC8T6OOFNiMtCUJaUyqDNcsil?=
 =?us-ascii?Q?7Ng7Myp6/CY9p6QIVkVu+x9V/hKAGXwjOQt5HSAvVWMRd7GVbAoHjvDOcMw6?=
 =?us-ascii?Q?xAgsi9eW5wgyyB8x7x3ta7Y84XFj/udsefcMD6EgQcSgRXdwJBeS4DxqXzh1?=
 =?us-ascii?Q?UAWy0IMzVQ5PnVa1pa7TnowAAB+l6M8657Ii6JHFy6M/PTIU8CLrPw0ZjBBa?=
 =?us-ascii?Q?it7zZ1BnBR/PAAzA1LQskZjSTPhvMctFvWFBRBso6+JZlfH3C40BMxN3w/dA?=
 =?us-ascii?Q?esHYZ+QJORmQN7suGWJwk+deBl8xd/83lFZXGFkuBofqzvmJDRKf5SiiZUoL?=
 =?us-ascii?Q?7ssJawaz7X3fE9Ew1oFlDPD5ayTTeG5MHMRbygekUdVHcw30GFuml7P9uK6l?=
 =?us-ascii?Q?A0FrT2HCUaomWP1CDblWX/mVEhBtoI8U1xHFql7uw/Qt9tzx8EdmwsZn5YWF?=
 =?us-ascii?Q?ncgKq4ZMw1DxAOE2N7clI7ORUTVCsl2tJM8MIvi3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacc0adc-6e84-41fb-8740-08db35cf688a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2023 12:15:13.4298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7nwB22y8zya+F68aLFd9dfn1NUOqibF2oroR/tmmYMuKaC8u75OQgt7XP5jCS5P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Mar 31, 2023 at 04:11:37PM -0700, Jacob Pan wrote:
>  static void idxd_disable_system_pasid(struct idxd_device *idxd)
>  {
> +	struct pci_dev *pdev = idxd->pdev;
> +	struct device *dev = &pdev->dev;
> +	struct iommu_domain *domain;
> +	union gencfg_reg gencfg;
> +
> +	domain = iommu_get_domain_for_dev(dev);
> +	if (!domain || domain->type == IOMMU_DOMAIN_BLOCKED)
> +		return;
> +
> +	iommu_detach_device_pasid(domain, dev, idxd->pasid);

This sequence is kinda weird, we shouldn't pass in domain to
detach_device_pasid, IMHO. We already know the domain because we store
it in an xarray, it just creates weirdness if the user passes in the
wrong domain.

Jason
